IMPORT AutoHeaderI, AutoStandardI, Business_Header, Business_Header_SS, Corp2, DCA, dx_dca, doxie_cbrs,
  LiensV2, LN_PropertyV2, UCCv2, BankruptcyV3, ut, STD, doxie, Suppress;

EXPORT RollupBusiness_BatchService_Records(
	DATASET(RollupBusiness_BatchService_Layouts.Input) indata,
	RollupBusiness_BatchService_Interfaces.Input args) := MODULE

	SHARED mod_access := MODULE(doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule()))
    EXPORT unsigned1 glb := args.glbpurpose;
    EXPORT unsigned1 dppa := args.dppapurpose;

  END;
	SHARED limits := RollupBusiness_BatchService_Constants.Limits;

	// First, project into the layout for Business Header Fetch.
	it := AutoStandardI.InterfaceTranslator;
	SHARED Header_Fetch_Records := PROJECT(indata,TRANSFORM(AutoHeaderI.Layouts.Fetch_Hdr_Batch_Biz_Layout,
		tempmod := MODULE(
			it.company_name_value.params,
			it.pname_value.params,
			it.prange_value.params,
			it.sec_range_value.params,
			it.addr_loose.params,
			it.addr_error_value.params,
			it.any_addr_error_value.params,
			it.city_value.params,
			it.state_value.params,
			it.zip_value.params,
			it.phone_value.params,
			it.fein_value.params,
			it.bdid_value.params)
			EXPORT asisname := '';
			EXPORT cn := '';
			EXPORT company := '';
			EXPORT companyname := LEFT.comp_name;
			EXPORT corpname := '';
			EXPORT nameasis := '';
			EXPORT addr := '';
			EXPORT city := LEFT.p_city_name;
			EXPORT isPRP := false;
			EXPORT prim_name := LEFT.prim_name;
			EXPORT primname := '';
			EXPORT prim_range := LEFT.prim_range;
			EXPORT primrange := '';
			EXPORT sec_range := LEFT.sec_range;
			EXPORT secrange := '';
			EXPORT st := LEFT.st;
			EXPORT st_orig := '';
			EXPORT state := '';
			EXPORT statecityzip := '';
			EXPORT street_name := '';
			EXPORT z5 := LEFT.z5;
			EXPORT zip := '';
			EXPORT mileradius := (UNSIGNED)LEFT.mileradius;
			EXPORT zipradius := (UNSIGNED)LEFT.mileradius;
			EXPORT county := '';
			EXPORT phone := LEFT.workphone;
			EXPORT fein := LEFT.fein;
			EXPORT bdid := LEFT.bdid;
		END;
		temp_company_name_value := it.company_name_value.val(PROJECT(tempmod,it.company_name_value.params));
		SELF.company_name_value := temp_company_name_value,
    temp_pname_value := it.pname_value.val(PROJECT(tempmod,it.pname_value.params));
    SELF.pname_value := temp_pname_value,
		SELF.prange_value := it.prange_value.val(PROJECT(tempmod,it.prange_value.params)),
		SELF.sec_range_value := it.sec_range_value.val(PROJECT(tempmod,it.sec_range_value.params)),
		SELF.addr_loose := it.addr_loose.val(PROJECT(tempmod,it.addr_loose.params)),
		SELF.addr_error_value := it.addr_error_value.val(PROJECT(tempmod,it.addr_error_value.params)),
		SELF.any_addr_error_value := it.any_addr_error_value.val(PROJECT(tempmod,it.any_addr_error_value.params)),
		SELF.city_value := it.city_value.val(PROJECT(tempmod,it.city_value.params)),
		SELF.state_value := it.state_value.val(PROJECT(tempmod,it.state_value.params)),
		SELF.zip_value := it.zip_value.val(PROJECT(tempmod,it.zip_value.params)),
		boolean OTHER_INPUT_PRESENT := if(temp_company_name_value !='' and
		                                  temp_pname_value !='',
													            true, false);
	  // Since certain input fein#s (i.e. 820100960 for Boise Cascade Corp at
		// address= 896 Mercury Ave Idaho Falls, ID 83402) retrieve way too many BDID_Records;
		// don't use the input fein# for AutoHeader fetches if a company_name and street_name
		// was entered. (See RQ 100563).
		SELF.fein_value := if(OTHER_INPUT_PRESENT,
		                      0,it.fein_value.val(PROJECT(tempmod,it.fein_value.params))),
	  // Since certain input phone#s (i.e. 2165235000 for Eaton Corporation at
		// address= PO BOX 818022 CLEVELAND OH 44181) retrieve way too many BDID_Records;
		// don't use the input phone# for AutoHeader fetches if a company_name and street_name
		// was entered. (See RQ 100563).
		SELF.phone_value := if(OTHER_INPUT_PRESENT,
		                       '', it.phone_value.val(PROJECT(tempmod,it.phone_value.params))),
		SELF.bdid_value := it.bdid_value.val(PROJECT(tempmod,it.bdid_value.params)),
		SELF.nofail := FALSE,
		SELF.searchignoresaddressonly_value := FALSE,
		SELF.allow_close_match_value := args.FuzzinessDial > 0,
		SELF.allow_indic_match_value := args.FuzzinessDial > 1,
		SELF.allow_wild_match_value := args.FuzzinessDial > 2,
		SELF.fein_mandatory_match := FALSE,
		SELF.phone_mandatory_match := FALSE,
		SELF := LEFT));

	// Get BDIDs. These can be obtained either by Header lookup, or by being passed into the
	// batch service via the SOAP interface. Via SOAP is common when several batch services
	// are chained together in a Kettle job.

	// Call the Business Header Fetch to get bdids based on input data. Project into a layout that
	// describes the BDID as not from input.
	SHARED BDID_Records_via_Header_pre := AutoHeaderI.FetchI_Hdr_Batch_Biz(Header_Fetch_Records);

	SHARED BDID_Records_via_Header :=
		PROJECT(
			BDID_Records_via_Header_pre,
			TRANSFORM( {AutoHeaderI.Layouts.Fetch_Batch_PreOutput_Layout, BOOLEAN isInput},
				SELF.isInput := FALSE,
				SELF := LEFT
			)
		);

	// Project those input records having a BDID into a layout that describes the BDID as
	// originating from input.
	SHARED BDID_Records_via_Input :=
		PROJECT(
			Header_Fetch_Records(bdid_value != 0),
			TRANSFORM( {AutoHeaderI.Layouts.Fetch_Batch_PreOutput_Layout, BOOLEAN isInput},
				SELF.acctno  := LEFT.acctno,
				SELF.errcode := AutoHeaderI.Types.ErrCode.NONE,
				SELF.id      := LEFT.bdid_value,
				SELF.isInput := TRUE
			)
		);

	// Sort and Dedup. RULE: For each acctno...
	//   o  ...if there exists a bdid from the input batch, keep only that bdid and exclude
	//      any other bdids obtained from the Header. We'll favor the input bdid since
	//      (assumption!) it was obtained from the ADL batch process earlier in the job.
	//   o  ...else, keep all bdids.
	SHARED BDID_records_grouped :=
		GROUP(SORT( (BDID_Records_via_Header + BDID_Records_via_Input), acctno), acctno);

	SHARED BDID_records_from_Input :=
		HAVING( BDID_records_grouped, EXISTS(ROWS(LEFT)(isInput = TRUE)) )(isInput);

	SHARED BDID_records_from_Header_only :=
		HAVING( BDID_records_grouped, NOT EXISTS(ROWS(LEFT)(isInput = TRUE)) );

	SHARED BDID_Records := BDID_records_from_Input + BDID_records_from_Header_only;

	// Next, for each bdid, get its GroupId.
	SHARED GroupId_Layout := RECORD
		AutoHeaderI.Layouts.Fetch_Batch_PreOutput_Layout;
		UNSIGNED6 GroupId;
	END;

	SHARED GroupId_Records := JOIN(BDID_Records,Business_Header.Key_BH_SuperGroup_BDID,
		LEFT.errcode = 0 AND
		KEYED (LEFT.id = RIGHT.bdid),
		TRANSFORM(GroupId_Layout,
			SELF.GroupId := RIGHT.group_id,
			SELF := LEFT),
		KEEP(limits.GROUPID_KEEP), LIMIT (0)); // GROUPID_KEEP = 1

	// NOTE: Level-0 Relatives are those bdids having the same group_id.
	SHARED Relatives_Layout := RECORD
		UNSIGNED6 base_bdid;
		UNSIGNED6 related_bdid;
		UNSIGNED6 GroupId;
		UNSIGNED1 level;        // Level 0 = those identified by AutoHeader search, Level 1 = their relatives, etc.
	END;

	SHARED Relatives_Level_0 := PROJECT(GroupId_Records,TRANSFORM(Relatives_Layout,
		SELF.base_bdid    := LEFT.id,
		SELF.related_bdid := LEFT.id,
		SELF.GroupId      := LEFT.GroupId,
		SELF.level        := 0));

	// Get rid of duplicates and group for aggregate filter--Level 0.
	SHARED Deduped_Relatives_Level_0 :=
			GROUP(SORT(DEDUP(SORT(Relatives_Level_0,base_bdid),base_bdid),GroupId),GroupId);

	// Filter down to all those group_ids having fewer than our limit of related bdids already--Level 0.
	SHARED Reduced_Relatives_Level_0 :=
			HAVING(Deduped_Relatives_Level_0, COUNT(ROWS(LEFT)) < limits.SUFFICIENT_NUMBER_OF_RELATIVES_AT_THIS_LEVEL);

	// Go get first level relatives.
	SHARED Relatives_Level1 := JOIN(Reduced_Relatives_Level_0,Business_Header.Key_Business_Relatives,
		KEYED(LEFT.related_bdid = RIGHT.bdid1) AND
		Business_Header.mac_isGroupRel(RIGHT,TRUE), // i.e. "TRUE" = NO DCA RELATIVES
		TRANSFORM(Relatives_Layout,
			SELF.related_bdid := RIGHT.bdid2,
			SELF.level := 1,
			SELF := LEFT),
		LIMIT(limits.RELATIVES_LIMIT,SKIP),
		KEEP(limits.RELATIVES_KEEP));

	// Get rid of duplicates and group for aggregate filter--Level 1.
	SHARED Deduped_Relatives_Level1 :=
			GROUP(DEDUP(SORT(UNGROUP(Deduped_Relatives_Level_0) + Relatives_Level1,base_bdid,related_bdid,level),base_bdid,related_bdid),base_bdid);

	// Filter down to all those group_ids having fewer than our limit of related bdids already--Level 1.
	SHARED Reduced_Relatives_Level1 :=
			HAVING(Deduped_Relatives_Level1, COUNT(ROWS(LEFT)) < limits.SUFFICIENT_NUMBER_OF_RELATIVES_AT_THIS_LEVEL);

	// Use what remains to do the process a couple more times.
	SHARED Relatives_Level2 := JOIN(Reduced_Relatives_Level1(level = 1),Business_Header.Key_Business_Relatives,
		LEFT.level = 1 AND
		KEYED(LEFT.related_bdid = RIGHT.bdid1) AND
		Business_Header.mac_isGroupRel(RIGHT,TRUE), // i.e. "TRUE" = NO DCA RELATIVES
		TRANSFORM(Relatives_Layout,
			SELF.related_bdid := RIGHT.bdid2,
			SELF.level := 2,
			SELF := LEFT),
		LIMIT(limits.RELATIVES_LIMIT,SKIP),
		KEEP(limits.RELATIVES_KEEP));

	// Get rid of duplicates and group for aggregate filter--Level 2.
	SHARED Deduped_Relatives_Level2 :=
			GROUP(DEDUP(SORT(UNGROUP(Deduped_Relatives_Level1) + Relatives_Level2,base_bdid,related_bdid,level),base_bdid,related_bdid),base_bdid);

	// Filter down to all those group_ids having fewer than our limit of related bdids already--Level 2.
	SHARED Reduced_Relatives_Level2 :=
			HAVING(Deduped_Relatives_Level2, COUNT(ROWS(LEFT)) < limits.SUFFICIENT_NUMBER_OF_RELATIVES_AT_THIS_LEVEL);

	SHARED Relatives_Level3 := JOIN(Reduced_Relatives_Level2(level = 2),Business_Header.Key_Business_Relatives,
		LEFT.level = 2 AND
		KEYED(LEFT.related_bdid = RIGHT.bdid1) AND
		Business_Header.mac_isGroupRel(RIGHT,TRUE), // i.e. "TRUE" = NO DCA RELATIVES
		TRANSFORM(Relatives_Layout,
			SELF.related_bdid := RIGHT.bdid2,
			SELF.level := 3,
			SELF := LEFT),
		LIMIT(limits.RELATIVES_LIMIT,SKIP),
		KEEP(limits.RELATIVES_KEEP));

	SHARED Deduped_Relatives_Level3 :=
			DEDUP(SORT(UNGROUP(Deduped_Relatives_Level2) + Relatives_Level3,base_bdid,related_bdid,level),base_bdid,related_bdid);

	SHARED Final_Relatives_Layout := RECORD
		GroupId_Layout.acctno;
		Relatives_Layout;
	END;

	// Join the IDs back to the acctnos
	SHARED Final_Relatives_Records := JOIN(GroupId_Records,Deduped_Relatives_Level3,
		LEFT.id = RIGHT.base_bdid,
		TRANSFORM(Final_Relatives_Layout,
			SELF := RIGHT,
			SELF := LEFT),
		LEFT OUTER);

	// Now, combine BDIDs under the GroupId.  The cnt is a rough approximation of the "centralness of a BDID".
	// The "level" indicates how many "steps" it takes to get from those BDIDs identified by the search to the BDID in question.
	SHARED Tabled_GroupId_Results :=
		TABLE(
			Final_Relatives_Records,
			{acctno, groupid, related_bdid, UNSIGNED1 level := MIN(GROUP,level), UNSIGNED cnt := COUNT(GROUP)},
			acctno,groupid,related_bdid
		);

	SHARED Deduped_GroupId_Results_No_Filter :=
		DEDUP(
			SORT(Tabled_GroupId_Results,acctno,groupid,level,-cnt,related_bdid),
			acctno,groupid,keep limits.RELATIVES_KEEP);

	// Next, go and get the best info for each record
	SHARED BestInfo_Records := JOIN(Deduped_GroupId_Results_No_Filter,Business_Header.Key_BH_Best,
		KEYED(LEFT.related_bdid = RIGHT.bdid),
		KEEP(limits.BEST_KEEP), LIMIT (0));

	SHARED Penalized_BestInfo_Records := JOIN(indata,BestInfo_Records,
		LEFT.acctno = RIGHT.acctno,
		TRANSFORM(
			{
				RECORDOF(indata);
				BestInfo_Records.groupid;
				UNSIGNED2 penalt;
			},
			tempmod := MODULE(AutoStandardI.LIBIN.PenaltyI_Biz.full)
				// Options
				EXPORT allow_wildcard := FALSE;
				EXPORT isPRP := FALSE;
				EXPORT scorethreshold := args.penaltThreshold;
				EXPORT useGlobalScope := FALSE;

				// Company name
				EXPORT asisname := '';
				EXPORT cn := '';
				EXPORT company := '';
				EXPORT companyname := LEFT.comp_name;
				EXPORT corpname := '';
				EXPORT nameasis := '';
				EXPORT cname_field := RIGHT.company_name;

				// Address
				EXPORT addr := '';
				EXPORT prim_range := LEFT.prim_range;
				EXPORT primrange := '';
				EXPORT predir := LEFT.predir;
				EXPORT prim_name := LEFT.prim_name;
				EXPORT primname := '';
				EXPORT street_name := '';
				EXPORT suffix := '';
				EXPORT postdir := LEFT.postdir;
				EXPORT sec_range := LEFT.sec_range;
				EXPORT secrange := '';
				EXPORT statecityzip := '';
				EXPORT city := LEFT.p_city_name;
				EXPORT othercity1 := '';
				EXPORT st := LEFT.st;
				EXPORT st_orig := '';
				EXPORT state := '';
				EXPORT otherstate1 := '';
				EXPORT otherstate2 := '';
				EXPORT z5 := LEFT.z5;
				EXPORT zip := '';
				EXPORT mileradius := (UNSIGNED)LEFT.mileradius;
				EXPORT zipradius := (UNSIGNED)LEFT.mileradius;
				EXPORT prange_field := RIGHT.prim_range;
				EXPORT predir_field := RIGHT.predir;
				EXPORT pname_field := RIGHT.prim_name;
				EXPORT suffix_field := RIGHT.addr_suffix;
				EXPORT postdir_field := RIGHT.postdir;
				EXPORT city_field := RIGHT.city;
				EXPORT city2_field := '';
				EXPORT state_field := RIGHT.state;
				EXPORT zip_field := IF(RIGHT.zip = 0,'',INTFORMAT(RIGHT.zip,5,1));

				// County
				EXPORT county := '';
				EXPORT county_field := '';

				// Phone
				EXPORT phone := LEFT.workphone;
				EXPORT phone_field := IF(RIGHT.phone = 0,'',INTFORMAT(RIGHT.phone,10,1));

				// FEIN
				EXPORT fein := LEFT.fein;
				EXPORT fein_field := IF(RIGHT.fein = 0,'',INTFORMAT(RIGHT.fein,9,1));

				// BDID
				EXPORT bdid := LEFT.bdid;
				EXPORT bdid_field := IF(RIGHT.bdid = 0,'',(STRING)RIGHT.bdid);
			END;
			SELF.penalt := AutoStandardI.LIBCALL_PenaltyI_Biz.val(tempmod),
			SELF.groupid := RIGHT.groupid,
			SELF := LEFT),
		LIMIT(limits.PENALTY_LIMIT,SKIP),
		KEEP(limits.PENALTY_KEEP));

	SHARED Indata_Plus_Penalty :=
		DEDUP(
			SORT(
				DEDUP(
					SORT( Penalized_BestInfo_Records(penalt <= args.PenaltThreshold), acctno,groupid,penalt ),
					acctno,groupid),
				acctno,penalt,groupid),
			acctno,keep args.MaxResultsPerRow);

	SHARED Deduped_GroupId_Results := JOIN(Deduped_GroupId_Results_No_Filter,Indata_Plus_Penalty,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(
			{
				RECORDOF(Deduped_GroupId_Results_No_Filter);
				UNSIGNED2 penalt;
			},
			SELF.penalt := RIGHT.penalt,
			SELF := LEFT
		));

	// Get the FEIN records
	SHARED FEIN_Records := TABLE(BestInfo_Records(fein != 0),{acctno,groupid,fein,UNSIGNED1 level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,fein);
	SHARED Sorted_FEIN_Records := DEDUP(SORT(FEIN_Records,acctno,groupid,level,-cnt,fein),acctno,groupid,keep 10);

	// Get the Phone records
	SHARED Phone_Records := TABLE(BestInfo_Records(phone != 0),{acctno,groupid,phone,UNSIGNED1 level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,phone);
	SHARED Sorted_Phone_Records := DEDUP(SORT(Phone_Records,acctno,groupid,level,-cnt,phone),acctno,groupid,keep 10);

	// Get the Address records
  SHARED ExtraBestInfo_Records :=
	  SORT(
      JOIN(Deduped_GroupId_Results_No_Filter, Business_Header_SS.Key_BH_BDID_pl,
        KEYED(LEFT.related_bdid = RIGHT.bdid)
				AND LEFT.level <= 1
        AND (RIGHT.dt_first_seen != 0 OR RIGHT.dt_last_seen != 0) AND
        doxie.compliance.source_ok(mod_access.glb, mod_access.DataRestrictionMask, right.source),
				KEEP(Limits.EXTRABEST_KEEP),
				LIMIT(Limits.EXTRABEST_LIMIT, SKIP)),
	    company_name, bdid);

  SHARED Address_Layout := RECORD
    Business_Header.Layout_BH_Best;
    AutoHeaderI.Types.acctno  acctno;
    UNSIGNED6                 groupid := 0;
    UNSIGNED6                 related_bdid := 0;
    UNSIGNED1                 level := 0;
    UNSIGNED                  cnt := 0;
    UNSIGNED4                 dt_first_seen := 0;
  END;

  SHARED BestInfoWithAddedDate_Records :=
	  SORT(
      PROJECT(BestInfo_Records, Address_Layout),
	    company_name, bdid);

  STRING8 zero_pad := '00000000';
  Address_Layout PadDate(RECORDOF(ExtraBestInfo_Records) L) := TRANSFORM
	  SELF.dt_first_seen := (UNSIGNED4)((STRING8)(L.dt_first_seen + zero_pad));
	  SELF.dt_last_seen := (UNSIGNED4)((STRING8)(L.dt_last_seen + zero_pad));
    SELF := L;
  END;

  SHARED PaddedExtraBestInfo_Records := PROJECT(ExtraBestInfo_Records, PadDate(LEFT));

  Address_Layout DetermineDateSeen(Address_Layout L, DATASET(RECORDOF(PaddedExtraBestInfo_Records)) R) := TRANSFORM
	  SELF.dt_first_seen := MIN(R(dt_first_seen != 0), R.dt_first_seen);
	  SELF.dt_last_seen := MAX(R, R.dt_last_seen);
	  SELF := L;
  END;

  SHARED BestAddressInfo_Records := DENORMALIZE(BestInfoWithAddedDate_Records, PaddedExtraBestInfo_Records,
    LEFT.company_name = RIGHT.company_name
	  AND LEFT.bdid = RIGHT.bdid,
	  GROUP,
	  DetermineDateSeen(LEFT, ROWS(RIGHT)));

	SHARED Address_Records := TABLE(BestAddressInfo_Records,{acctno,groupid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,city,state,zip,zip4,dt_first_seen,dt_last_seen,UNSIGNED1 level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,city,state,zip,zip4,dt_first_seen,dt_last_seen);
	SHARED Sorted_Address_Records := DEDUP(SORT(Address_Records,acctno,groupid,level,-cnt,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,city,state,zip,zip4),acctno,groupid,keep 10);


	// Get the Name records
	SHARED Name_Records := TABLE(BestInfo_Records,{acctno,groupid,company_name,UNSIGNED1 level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,company_name);
	SHARED Sorted_Name_Records := DEDUP(SORT(Name_Records,acctno,groupid,level,-cnt,company_name),acctno,groupid,keep 10);

	// Get the SIC Code records
	SHARED Raw_SIC_Codes := JOIN(Deduped_GroupId_Results,Business_Header.Key_SIC_Code,
		KEYED(LEFT.related_bdid = RIGHT.bdid),
		KEEP(limits.SIC_CODE_KEEP));
	SHARED SIC_Code_Records := TABLE(Raw_SIC_Codes,{acctno,groupid,sic_code,UNSIGNED1 level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,sic_code);
	SHARED Sorted_SIC_Code_Records := DEDUP(SORT(SIC_Code_Records,acctno,groupid,level,-cnt,sic_code),acctno,groupid,keep 10);

	// Get judgment & lien flag
	SHARED JudgmentLiens_byBDID := JOIN(Deduped_GroupId_Results,LiensV2.key_liens_BDID,
		KEYED(LEFT.related_bdid = RIGHT.p_bdid),
		KEEP(limits.LIENS_TMSIDS_KEEP));

	SHARED JudgmentLiens_byTMSID := JOIN(JudgmentLiens_byBDID,LiensV2.key_liens_party_ID,
		KEYED(LEFT.tmsid = RIGHT.tmsid) AND
		KEYED(LEFT.rmsid = RIGHT.rmsid) AND
		RIGHT.name_type = 'D' AND
		LEFT.p_bdid = (UNSIGNED)RIGHT.bdid,
		TRANSFORM(LEFT),
		LIMIT(limits.LIENS_RECORDS_LIMIT,SKIP),
		KEEP(limits.LIENS_RECORDS_KEEP));

		//output(JudgmentLiens_byTMSID, named('JudgmentLiens_byTMSID'));

	SHARED JudgmentLiens_Flags := DEDUP(SORT(JudgmentLiens_byTMSID,acctno,groupid),acctno,groupid);

	// get BK's

	SHARED Bankruptcies_byBDID := JOIN(Deduped_GroupId_Results,BankruptcyV3.key_bankruptcyv3_bdid(),
		KEYED(LEFT.related_bdid = RIGHT.p_bdid),
		KEEP(limits.LIENS_TMSIDS_KEEP));

  SHARED Bankruptcies_ByTMSID := JOIN(Bankruptcies_byBDID, BankruptcyV3.key_bankruptcyv3_main_full(),
	  KEYED(LEFT.tmsid = RIGHT.TMSID),
		//LEFT.p_bdid = (UNSIGNED)RIGHT.bdid,
		TRANSFORM(LEFT),
		LIMIT(limits.LIENS_RECORDS_LIMIT,SKIP),
		KEEP(limits.LIENS_RECORDS_KEEP));

	//	output(Bankruptcies_ByTMSID, named('Bankruptcies_ByTMSID'));

	// Get executives

  Contacts_byBDID_pre := JOIN(Deduped_GroupId_Results,Business_Header.Key_Business_Contacts_BDID,
		KEYED(LEFT.related_bdid = RIGHT.bdid),
		KEEP(limits.CONTACTS_KEEP));

  Contacts_byBDID_a := Suppress.MAC_SuppressSource(Contacts_byBDID_pre, mod_access);

	SHARED Contacts_byBDID := Contacts_byBDID_a(~glb or mod_access.isValidGLB());
	SHARED Contacts_withTitle := JOIN(Contacts_byBDID,doxie_cbrs.executive_titles,
		LEFT.company_title = RIGHT.stored_title);

	SHARED Tabled_Executives_Records := TABLE(Contacts_withTitle,{acctno,groupid,lname,fname,mname,name_suffix,title,title_rank,display_title,UNSIGNED level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,lname,fname,mname,name_suffix,title,title_rank,display_title);

	SHARED Rolledup_Executives_Records := ROLLUP(SORT(Tabled_Executives_Records,acctno,groupid,lname,fname,mname,name_suffix,title),
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid AND
		LEFT.lname = RIGHT.lname AND
		LEFT.fname = RIGHT.fname AND
		LEFT.mname = RIGHT.mname AND
		LEFT.name_suffix = RIGHT.name_suffix AND
		LEFT.title = RIGHT.title,
		TRANSFORM(RECORDOF(Tabled_Executives_Records),
			SELF.level := MIN(LEFT.level,RIGHT.level),
			SELF.cnt := LEFT.cnt + RIGHT.cnt,
			SELF.title_rank := MIN(LEFT.title_rank,RIGHT.title_rank),
			SELF.display_title := LEFT.display_title + '; ' + RIGHT.display_title,
			SELF := LEFT));

	SHARED Sorted_Executives_Records := DEDUP(SORT(Rolledup_Executives_Records,acctno,groupid,level,-cnt,title_rank,lname,fname,mname,name_suffix,title,display_title),acctno,groupid,keep 10);

	// Get UCC flag
	SHARED UCCs_byBDID := JOIN(Deduped_GroupId_Results,uccv2.Key_Bdid,
		KEYED(LEFT.related_bdid = RIGHT.bdid) AND
		LEFT.level <= 2,
		KEEP(limits.LIENS_TMSIDS_KEEP));

	SHARED UCCs_byTMSID := JOIN(UCCs_byBDID,uccv2.Key_Rmsid_Party(),
		KEYED(LEFT.tmsid = RIGHT.tmsid) AND
		KEYED(LEFT.rmsid = RIGHT.rmsid) AND
		RIGHT.party_type = 'D' AND
		LEFT.bdid = RIGHT.bdid,
		TRANSFORM(left),
		LIMIT(limits.LIENS_RECORDS_LIMIT,SKIP),
		KEEP(limits.LIENS_RECORDS_KEEP));

		//output(UCCs_bytmsid, named('uccs_bytmsid'));

	SHARED UCCs_Flags := DEDUP(SORT(UCCs_byTMSID,acctno,groupid),acctno,groupid);

	// Get Property flag
	SHARED Props_byBDID := JOIN(Deduped_GroupId_Results,LN_PropertyV2.key_search_bdid,
		KEYED(LEFT.related_bdid = RIGHT.s_bid),
		KEEP(limits.PROPERTIES_KEEP));

	SHARED Props_Flags := DEDUP(SORT(Props_byBDID,acctno,groupid),acctno,groupid);

	// Get Corporate Filing records (for RA name, etc)
	SHARED Corp_Records := JOIN(Deduped_GroupId_Results,Corp2.Key_Corp_BdidPL,
		KEYED(LEFT.related_bdid = RIGHT.bdid),
		KEEP(limits.CORPS_KEEP));

	SHARED Tabled_RA_Records := TABLE(Corp_Records(corp_ra_title1 != '' or corp_ra_fname1 != '' or corp_ra_mname1 != '' or corp_ra_lname1 != '' or corp_ra_name_suffix1 != '' or corp_ra_cname1 != '' or corp_ra_phone10 != ''),{acctno,groupid,corp_ra_title1,corp_ra_fname1,corp_ra_mname1,corp_ra_lname1,corp_ra_name_suffix1,corp_ra_cname1,corp_ra_phone10,UNSIGNED level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,corp_ra_title1,corp_ra_fname1,corp_ra_mname1,corp_ra_lname1,corp_ra_name_suffix1,corp_ra_cname1,corp_ra_phone10);
	SHARED Sorted_RA_Records := DEDUP(SORT(Tabled_RA_Records,acctno,groupid,level,-cnt,corp_ra_title1,corp_ra_fname1,corp_ra_mname1,corp_ra_lname1,corp_ra_name_suffix1,corp_ra_cname1,corp_ra_phone10),acctno,groupid);

	// Also get the corporate status records
	SHARED Tabled_Status_Records := TABLE(Corp_Records(corp_status_desc != ''),{acctno,groupid,corp_status_desc,UNSIGNED level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,corp_status_desc);
	SHARED Sorted_Status_Records := DEDUP(SORT(Tabled_Status_Records,acctno,groupid,level,-cnt,corp_status_desc),acctno,groupid);

	DCA_Records_Raw := dx_dca.get_bdid(Deduped_GroupId_Results, mod_access, related_bdid, TRUE);
	SHARED DCA_Records1 := JOIN(Deduped_GroupId_Results, DCA_Records_Raw,
		LEFT.related_bdid = RIGHT.bdid,
		KEEP(limits.DCA_KEEP),
		LIMIT (ut.limits.MAX_DCA_PER_BDID));

	SHARED Tabled_URL_Records := TABLE(DCA_Records1(url != ''),{acctno,groupid,url,UNSIGNED level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,url);
	SHARED Sorted_URL_Records := DEDUP(SORT(Tabled_URL_Records,acctno,groupid,level,-cnt,url),acctno,groupid);

	SHARED Tabled_Email_Records := TABLE(DCA_Records1(e_mail != ''),{acctno,groupid,e_mail,UNSIGNED level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,e_mail);
	SHARED Sorted_Email_Records := DEDUP(SORT(Tabled_Email_Records,acctno,groupid,level,-cnt,e_mail),acctno,groupid);

	SHARED Tabled_DCA_Records := TABLE(DCA_Records1,{acctno,groupid,root,sub,STRING10 emp_num := MAX(GROUP,emp_num),STRING10 sales_or_revenue := MAX(GROUP,sales_desc),STRING15 sales := MAX(GROUP,sales),UNSIGNED level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,root,sub);
	SHARED Sorted_DCA_Records := DEDUP(SORT(Tabled_DCA_Records,acctno,groupid,level,-cnt,root,sub),acctno,groupid);

	SHARED Tabled_DCA_Records1 := TABLE(DCA_Records1,{acctno,groupid,parent_number,UNSIGNED level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,parent_number);

	SHARED DCA_Records2 := JOIN(Tabled_DCA_Records1(parent_number != ''),DCA.Key_DCA_Root_Sub,
		KEYED (LEFT.parent_number[1..9] 		= RIGHT.root) AND
		KEYED (LEFT.parent_number[11..14] 	= RIGHT.sub),
		TRANSFORM(RECORDOF(DCA_Records1) - [related_bdid,penalt],
			SELF.level := LEFT.level,
			SELF := RIGHT,
			SELF := LEFT),
		KEEP (1), LIMIT (0));

	SHARED Tabled_DCA_Records2 := TABLE(DCA_Records2,{acctno,groupid,parent_number,UNSIGNED level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,parent_number);

	SHARED DCA_Records3 := JOIN(Tabled_DCA_Records2(parent_number != ''),DCA.Key_DCA_Root_Sub,
		KEYED (LEFT.parent_number[1..9] 		= RIGHT.root) AND
		KEYED (LEFT.parent_number[11..14] 	= RIGHT.sub),
		TRANSFORM(RECORDOF(DCA_Records2),
			SELF.level := LEFT.level,
			SELF := RIGHT,
			SELF := LEFT),
		KEEP (1), LIMIT (0));

	SHARED Tabled_DCA_Records3 := TABLE(DCA_Records3,{acctno,groupid,parent_number,UNSIGNED level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,parent_number);

	SHARED DCA_Records4 := JOIN(Tabled_DCA_Records3(parent_number != ''),DCA.Key_DCA_Root_Sub,
		KEYED (LEFT.parent_number[1..9] 		= RIGHT.root) AND
		KEYED (LEFT.parent_number[11..14] 	= RIGHT.sub),
		TRANSFORM(RECORDOF(DCA_Records2),
			SELF.level := LEFT.level,
			SELF := RIGHT,
			SELF := LEFT),
		KEEP (1), LIMIT (0));

	SHARED Tabled_DCA_Records4 := TABLE(DCA_Records4,{acctno,groupid,parent_number,UNSIGNED level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,parent_number);

	SHARED DCA_Records5 := JOIN(Tabled_DCA_Records4(parent_number != ''),DCA.Key_DCA_Root_Sub,
		KEYED (LEFT.parent_number[1..9] 		= RIGHT.root) AND
		KEYED (LEFT.parent_number[11..14] 	= RIGHT.sub),
		TRANSFORM(RECORDOF(DCA_Records2),
			SELF.level := LEFT.level,
			SELF := RIGHT,
			SELF := LEFT),
		KEEP (1), LIMIT (0));

	SHARED Tabled_DCA_Records5 := TABLE(DCA_Records5,{acctno,groupid,parent_number,UNSIGNED level := MIN(GROUP,level),UNSIGNED cnt := SUM(GROUP,cnt)},acctno,groupid,parent_number);

	SHARED Final_DCA_Records := DEDUP(SORT(ROLLUP(
		PROJECT(DCA_Records1(parent_number = ''),RECORDOF(DCA_Records2)) +
		DCA_Records2(parent_number = '') +
		DCA_Records3(parent_number = '') +
		DCA_Records4(parent_number = '') +
		DCA_Records5(parent_number = ''),
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid AND
		LEFT.root = RIGHT.root AND
		LEFT.sub = RIGHT.sub,
		TRANSFORM(RECORDOF(DCA_Records2),
			SELF.level := MIN(LEFT.level,RIGHT.level),
			SELF.cnt := LEFT.cnt + RIGHT.cnt,
			SELF := LEFT)),acctno,groupid,level,-cnt,root,sub),acctno,groupid);

	// output(Final_DCA_Records, named('Final_DCA_Records'));

	SHARED Seed_Records := PROJECT(DEDUP(SORT(Deduped_GroupId_Results,acctno,groupid),acctno,groupid),TRANSFORM(RollupBusiness_BatchService_Layouts.Final,
		SELF.acctno := LEFT.acctno,
		SELF.groupid := LEFT.groupid,
		SELF.penalt := LEFT.penalt,
		SELF := []));

	SHARED Add_Names := DENORMALIZE(Seed_Records,Sorted_Name_Records,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final,
			SELF.best_company_name := IF(COUNTER = 1,RIGHT.company_name,LEFT.best_company_name),
			SELF.company_name_var1 := IF(COUNTER = 2,RIGHT.company_name,LEFT.company_name_var1),
			SELF.company_name_var2 := IF(COUNTER = 3,RIGHT.company_name,LEFT.company_name_var2),
			SELF.company_name_var3 := IF(COUNTER = 4,RIGHT.company_name,LEFT.company_name_var3),
			SELF.company_name_var4 := IF(COUNTER = 5,RIGHT.company_name,LEFT.company_name_var4),
			SELF.company_name_var5 := IF(COUNTER = 6,RIGHT.company_name,LEFT.company_name_var5),
			SELF.company_name_var6 := IF(COUNTER = 7,RIGHT.company_name,LEFT.company_name_var6),
			SELF.company_name_var7 := IF(COUNTER = 8,RIGHT.company_name,LEFT.company_name_var7),
			SELF.company_name_var8 := IF(COUNTER = 9,RIGHT.company_name,LEFT.company_name_var8),
			SELF.company_name_var9 := IF(COUNTER = 10,RIGHT.company_name,LEFT.company_name_var9),
			SELF := LEFT));

	SHARED Add_Addresses := DENORMALIZE(Add_Names,Sorted_Address_Records,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final,
			SELF.best_prim_range     := IF(COUNTER = 1,RIGHT.prim_range                               ,LEFT.best_prim_range   ),
			SELF.best_predir         := IF(COUNTER = 1,RIGHT.predir                                   ,LEFT.best_predir       ),
			SELF.best_prim_name      := IF(COUNTER = 1,RIGHT.prim_name                                ,LEFT.best_prim_name    ),
			SELF.best_addr_suffix    := IF(COUNTER = 1,RIGHT.addr_suffix                              ,LEFT.best_addr_suffix  ),
			SELF.best_postdir        := IF(COUNTER = 1,RIGHT.postdir                                  ,LEFT.best_postdir      ),
			SELF.best_unit_desig     := IF(COUNTER = 1,RIGHT.unit_desig                               ,LEFT.best_unit_desig   ),
			SELF.best_sec_range      := IF(COUNTER = 1,RIGHT.sec_range                                ,LEFT.best_sec_range    ),
			SELF.best_city           := IF(COUNTER = 1,RIGHT.city                                     ,LEFT.best_city         ),
			SELF.best_state          := IF(COUNTER = 1,RIGHT.state                                    ,LEFT.best_state        ),
			SELF.best_zip            := IF(COUNTER = 1,IF(RIGHT.zip = 0,'',INTFORMAT(RIGHT.zip,5,1))  ,LEFT.best_zip          ),
			SELF.best_zip4           := IF(COUNTER = 1,IF(RIGHT.zip4 = 0,'',INTFORMAT(RIGHT.zip4,4,1)),LEFT.best_zip4         ),
			SELF.best_dt_first_seen  := IF(COUNTER = 1,RIGHT.dt_first_seen                            ,LEFT.best_dt_first_seen),
			SELF.best_dt_last_seen   := IF(COUNTER = 1,RIGHT.dt_last_seen                             ,LEFT.best_dt_last_seen ),
			SELF.prim_range_var1     := IF(COUNTER = 2,RIGHT.prim_range                               ,LEFT.prim_range_var1   ),
			SELF.predir_var1         := IF(COUNTER = 2,RIGHT.predir                                   ,LEFT.predir_var1       ),
			SELF.prim_name_var1      := IF(COUNTER = 2,RIGHT.prim_name                                ,LEFT.prim_name_var1    ),
			SELF.addr_suffix_var1    := IF(COUNTER = 2,RIGHT.addr_suffix                              ,LEFT.addr_suffix_var1  ),
			SELF.postdir_var1        := IF(COUNTER = 2,RIGHT.postdir                                  ,LEFT.postdir_var1      ),
			SELF.unit_desig_var1     := IF(COUNTER = 2,RIGHT.unit_desig                               ,LEFT.unit_desig_var1   ),
			SELF.sec_range_var1      := IF(COUNTER = 2,RIGHT.sec_range                                ,LEFT.sec_range_var1    ),
			SELF.city_var1           := IF(COUNTER = 2,RIGHT.city                                     ,LEFT.city_var1         ),
			SELF.state_var1          := IF(COUNTER = 2,RIGHT.state                                    ,LEFT.state_var1        ),
			SELF.zip_var1            := IF(COUNTER = 2,IF(RIGHT.zip = 0,'',INTFORMAT(RIGHT.zip,5,1))  ,LEFT.zip_var1          ),
			SELF.zip4_var1           := IF(COUNTER = 2,IF(RIGHT.zip4 = 0,'',INTFORMAT(RIGHT.zip4,4,1)),LEFT.zip4_var1         ),
			SELF.dt_first_seen_var1  := IF(COUNTER = 2,RIGHT.dt_first_seen                            ,LEFT.dt_first_seen_var1),
			SELF.dt_last_seen_var1   := IF(COUNTER = 2,RIGHT.dt_last_seen                             ,LEFT.dt_last_seen_var1 ),
			SELF.prim_range_var2     := IF(COUNTER = 3,RIGHT.prim_range                               ,LEFT.prim_range_var2   ),
			SELF.predir_var2         := IF(COUNTER = 3,RIGHT.predir                                   ,LEFT.predir_var2       ),
			SELF.prim_name_var2      := IF(COUNTER = 3,RIGHT.prim_name                                ,LEFT.prim_name_var2    ),
			SELF.addr_suffix_var2    := IF(COUNTER = 3,RIGHT.addr_suffix                              ,LEFT.addr_suffix_var2  ),
			SELF.postdir_var2        := IF(COUNTER = 3,RIGHT.postdir                                  ,LEFT.postdir_var2      ),
			SELF.unit_desig_var2     := IF(COUNTER = 3,RIGHT.unit_desig                               ,LEFT.unit_desig_var2   ),
			SELF.sec_range_var2      := IF(COUNTER = 3,RIGHT.sec_range                                ,LEFT.sec_range_var2    ),
			SELF.city_var2           := IF(COUNTER = 3,RIGHT.city                                     ,LEFT.city_var2         ),
			SELF.state_var2          := IF(COUNTER = 3,RIGHT.state                                    ,LEFT.state_var2        ),
			SELF.zip_var2            := IF(COUNTER = 3,IF(RIGHT.zip = 0,'',INTFORMAT(RIGHT.zip,5,1))  ,LEFT.zip_var2          ),
			SELF.zip4_var2           := IF(COUNTER = 3,IF(RIGHT.zip4 = 0,'',INTFORMAT(RIGHT.zip4,4,1)),LEFT.zip4_var2         ),
			SELF.dt_first_seen_var2  := IF(COUNTER = 3,RIGHT.dt_first_seen                            ,LEFT.dt_first_seen_var2),
			SELF.dt_last_seen_var2   := IF(COUNTER = 3,RIGHT.dt_last_seen                             ,LEFT.dt_last_seen_var2 ),
			SELF.prim_range_var3     := IF(COUNTER = 4,RIGHT.prim_range                               ,LEFT.prim_range_var3   ),
			SELF.predir_var3         := IF(COUNTER = 4,RIGHT.predir                                   ,LEFT.predir_var3       ),
			SELF.prim_name_var3      := IF(COUNTER = 4,RIGHT.prim_name                                ,LEFT.prim_name_var3    ),
			SELF.addr_suffix_var3    := IF(COUNTER = 4,RIGHT.addr_suffix                              ,LEFT.addr_suffix_var3  ),
			SELF.postdir_var3        := IF(COUNTER = 4,RIGHT.postdir                                  ,LEFT.postdir_var3      ),
			SELF.unit_desig_var3     := IF(COUNTER = 4,RIGHT.unit_desig                               ,LEFT.unit_desig_var3   ),
			SELF.sec_range_var3      := IF(COUNTER = 4,RIGHT.sec_range                                ,LEFT.sec_range_var3    ),
			SELF.city_var3           := IF(COUNTER = 4,RIGHT.city                                     ,LEFT.city_var3         ),
			SELF.state_var3          := IF(COUNTER = 4,RIGHT.state                                    ,LEFT.state_var3        ),
			SELF.zip_var3            := IF(COUNTER = 4,IF(RIGHT.zip = 0,'',INTFORMAT(RIGHT.zip,5,1))  ,LEFT.zip_var3          ),
			SELF.zip4_var3           := IF(COUNTER = 4,IF(RIGHT.zip4 = 0,'',INTFORMAT(RIGHT.zip4,4,1)),LEFT.zip4_var3         ),
			SELF.dt_first_seen_var3  := IF(COUNTER = 4,RIGHT.dt_first_seen                            ,LEFT.dt_first_seen_var3),
			SELF.dt_last_seen_var3   := IF(COUNTER = 4,RIGHT.dt_last_seen                             ,LEFT.dt_last_seen_var3 ),
			SELF.prim_range_var4     := IF(COUNTER = 5,RIGHT.prim_range                               ,LEFT.prim_range_var4   ),
			SELF.predir_var4         := IF(COUNTER = 5,RIGHT.predir                                   ,LEFT.predir_var4       ),
			SELF.prim_name_var4      := IF(COUNTER = 5,RIGHT.prim_name                                ,LEFT.prim_name_var4    ),
			SELF.addr_suffix_var4    := IF(COUNTER = 5,RIGHT.addr_suffix                              ,LEFT.addr_suffix_var4  ),
			SELF.postdir_var4        := IF(COUNTER = 5,RIGHT.postdir                                  ,LEFT.postdir_var4      ),
			SELF.unit_desig_var4     := IF(COUNTER = 5,RIGHT.unit_desig                               ,LEFT.unit_desig_var4   ),
			SELF.sec_range_var4      := IF(COUNTER = 5,RIGHT.sec_range                                ,LEFT.sec_range_var4    ),
			SELF.city_var4           := IF(COUNTER = 5,RIGHT.city                                     ,LEFT.city_var4         ),
			SELF.state_var4          := IF(COUNTER = 5,RIGHT.state                                    ,LEFT.state_var4        ),
			SELF.zip_var4            := IF(COUNTER = 5,IF(RIGHT.zip = 0,'',INTFORMAT(RIGHT.zip,5,1))  ,LEFT.zip_var4          ),
			SELF.zip4_var4           := IF(COUNTER = 5,IF(RIGHT.zip4 = 0,'',INTFORMAT(RIGHT.zip4,4,1)),LEFT.zip4_var4         ),
			SELF.dt_first_seen_var4  := IF(COUNTER = 5,RIGHT.dt_first_seen                            ,LEFT.dt_first_seen_var4),
			SELF.dt_last_seen_var4   := IF(COUNTER = 5,RIGHT.dt_last_seen                             ,LEFT.dt_last_seen_var4 ),
			SELF.prim_range_var5     := IF(COUNTER = 6,RIGHT.prim_range                               ,LEFT.prim_range_var5   ),
			SELF.predir_var5         := IF(COUNTER = 6,RIGHT.predir                                   ,LEFT.predir_var5       ),
			SELF.prim_name_var5      := IF(COUNTER = 6,RIGHT.prim_name                                ,LEFT.prim_name_var5    ),
			SELF.addr_suffix_var5    := IF(COUNTER = 6,RIGHT.addr_suffix                              ,LEFT.addr_suffix_var5  ),
			SELF.postdir_var5        := IF(COUNTER = 6,RIGHT.postdir                                  ,LEFT.postdir_var5      ),
			SELF.unit_desig_var5     := IF(COUNTER = 6,RIGHT.unit_desig                               ,LEFT.unit_desig_var5   ),
			SELF.sec_range_var5      := IF(COUNTER = 6,RIGHT.sec_range                                ,LEFT.sec_range_var5    ),
			SELF.city_var5           := IF(COUNTER = 6,RIGHT.city                                     ,LEFT.city_var5         ),
			SELF.state_var5          := IF(COUNTER = 6,RIGHT.state                                    ,LEFT.state_var5        ),
			SELF.zip_var5            := IF(COUNTER = 6,IF(RIGHT.zip = 0,'',INTFORMAT(RIGHT.zip,5,1))  ,LEFT.zip_var5          ),
			SELF.zip4_var5           := IF(COUNTER = 6,IF(RIGHT.zip4 = 0,'',INTFORMAT(RIGHT.zip4,4,1)),LEFT.zip4_var5         ),
			SELF.dt_first_seen_var5  := IF(COUNTER = 6,RIGHT.dt_first_seen                            ,LEFT.dt_first_seen_var5),
			SELF.dt_last_seen_var5   := IF(COUNTER = 6,RIGHT.dt_last_seen                             ,LEFT.dt_last_seen_var5 ),
			SELF.prim_range_var6     := IF(COUNTER = 7,RIGHT.prim_range                               ,LEFT.prim_range_var6   ),
			SELF.predir_var6         := IF(COUNTER = 7,RIGHT.predir                                   ,LEFT.predir_var6       ),
			SELF.prim_name_var6      := IF(COUNTER = 7,RIGHT.prim_name                                ,LEFT.prim_name_var6    ),
			SELF.addr_suffix_var6    := IF(COUNTER = 7,RIGHT.addr_suffix                              ,LEFT.addr_suffix_var6  ),
			SELF.postdir_var6        := IF(COUNTER = 7,RIGHT.postdir                                  ,LEFT.postdir_var6      ),
			SELF.unit_desig_var6     := IF(COUNTER = 7,RIGHT.unit_desig                               ,LEFT.unit_desig_var6   ),
			SELF.sec_range_var6      := IF(COUNTER = 7,RIGHT.sec_range                                ,LEFT.sec_range_var6    ),
			SELF.city_var6           := IF(COUNTER = 7,RIGHT.city                                     ,LEFT.city_var6         ),
			SELF.state_var6          := IF(COUNTER = 7,RIGHT.state                                    ,LEFT.state_var6        ),
			SELF.zip_var6            := IF(COUNTER = 7,IF(RIGHT.zip = 0,'',INTFORMAT(RIGHT.zip,5,1))  ,LEFT.zip_var6          ),
			SELF.zip4_var6           := IF(COUNTER = 7,IF(RIGHT.zip4 = 0,'',INTFORMAT(RIGHT.zip4,4,1)),LEFT.zip4_var6         ),
			SELF.dt_first_seen_var6  := IF(COUNTER = 7,RIGHT.dt_first_seen                            ,LEFT.dt_first_seen_var6),
			SELF.dt_last_seen_var6   := IF(COUNTER = 7,RIGHT.dt_last_seen                             ,LEFT.dt_last_seen_var6 ),
			SELF.prim_range_var7     := IF(COUNTER = 8,RIGHT.prim_range                               ,LEFT.prim_range_var7   ),
			SELF.predir_var7         := IF(COUNTER = 8,RIGHT.predir                                   ,LEFT.predir_var7       ),
			SELF.prim_name_var7      := IF(COUNTER = 8,RIGHT.prim_name                                ,LEFT.prim_name_var7    ),
			SELF.addr_suffix_var7    := IF(COUNTER = 8,RIGHT.addr_suffix                              ,LEFT.addr_suffix_var7  ),
			SELF.postdir_var7        := IF(COUNTER = 8,RIGHT.postdir                                  ,LEFT.postdir_var7      ),
			SELF.unit_desig_var7     := IF(COUNTER = 8,RIGHT.unit_desig                               ,LEFT.unit_desig_var7   ),
			SELF.sec_range_var7      := IF(COUNTER = 8,RIGHT.sec_range                                ,LEFT.sec_range_var7    ),
			SELF.city_var7           := IF(COUNTER = 8,RIGHT.city                                     ,LEFT.city_var7         ),
			SELF.state_var7          := IF(COUNTER = 8,RIGHT.state                                    ,LEFT.state_var7        ),
			SELF.zip_var7            := IF(COUNTER = 8,IF(RIGHT.zip = 0,'',INTFORMAT(RIGHT.zip,5,1))  ,LEFT.zip_var7          ),
			SELF.zip4_var7           := IF(COUNTER = 8,IF(RIGHT.zip4 = 0,'',INTFORMAT(RIGHT.zip4,4,1)),LEFT.zip4_var7         ),
			SELF.dt_first_seen_var7  := IF(COUNTER = 8,RIGHT.dt_first_seen                            ,LEFT.dt_first_seen_var7),
			SELF.dt_last_seen_var7   := IF(COUNTER = 8,RIGHT.dt_last_seen                             ,LEFT.dt_last_seen_var7 ),
			SELF.prim_range_var8     := IF(COUNTER = 9,RIGHT.prim_range                               ,LEFT.prim_range_var8   ),
			SELF.predir_var8         := IF(COUNTER = 9,RIGHT.predir                                   ,LEFT.predir_var8       ),
			SELF.prim_name_var8      := IF(COUNTER = 9,RIGHT.prim_name                                ,LEFT.prim_name_var8    ),
			SELF.addr_suffix_var8    := IF(COUNTER = 9,RIGHT.addr_suffix                              ,LEFT.addr_suffix_var8  ),
			SELF.postdir_var8        := IF(COUNTER = 9,RIGHT.postdir                                  ,LEFT.postdir_var8      ),
			SELF.unit_desig_var8     := IF(COUNTER = 9,RIGHT.unit_desig                               ,LEFT.unit_desig_var8   ),
			SELF.sec_range_var8      := IF(COUNTER = 9,RIGHT.sec_range                                ,LEFT.sec_range_var8    ),
			SELF.city_var8           := IF(COUNTER = 9,RIGHT.city                                     ,LEFT.city_var8         ),
			SELF.state_var8          := IF(COUNTER = 9,RIGHT.state                                    ,LEFT.state_var8        ),
			SELF.zip_var8            := IF(COUNTER = 9,IF(RIGHT.zip = 0,'',INTFORMAT(RIGHT.zip,5,1))  ,LEFT.zip_var8          ),
			SELF.zip4_var8           := IF(COUNTER = 9,IF(RIGHT.zip4 = 0,'',INTFORMAT(RIGHT.zip4,4,1)),LEFT.zip4_var8         ),
			SELF.dt_first_seen_var8  := IF(COUNTER = 9,RIGHT.dt_first_seen                            ,LEFT.dt_first_seen_var8),
			SELF.dt_last_seen_var8   := IF(COUNTER = 9,RIGHT.dt_last_seen                             ,LEFT.dt_last_seen_var8 ),
			SELF.prim_range_var9     := IF(COUNTER = 10,RIGHT.prim_range                               ,LEFT.prim_range_var9   ),
			SELF.predir_var9         := IF(COUNTER = 10,RIGHT.predir                                   ,LEFT.predir_var9       ),
			SELF.prim_name_var9      := IF(COUNTER = 10,RIGHT.prim_name                                ,LEFT.prim_name_var9    ),
			SELF.addr_suffix_var9    := IF(COUNTER = 10,RIGHT.addr_suffix                              ,LEFT.addr_suffix_var9  ),
			SELF.postdir_var9        := IF(COUNTER = 10,RIGHT.postdir                                  ,LEFT.postdir_var9      ),
			SELF.unit_desig_var9     := IF(COUNTER = 10,RIGHT.unit_desig                               ,LEFT.unit_desig_var9   ),
			SELF.sec_range_var9      := IF(COUNTER = 10,RIGHT.sec_range                                ,LEFT.sec_range_var9    ),
			SELF.city_var9           := IF(COUNTER = 10,RIGHT.city                                     ,LEFT.city_var9         ),
			SELF.state_var9          := IF(COUNTER = 10,RIGHT.state                                    ,LEFT.state_var9        ),
			SELF.zip_var9            := IF(COUNTER = 10,IF(RIGHT.zip = 0,'',INTFORMAT(RIGHT.zip,5,1))  ,LEFT.zip_var9          ),
			SELF.zip4_var9           := IF(COUNTER = 10,IF(RIGHT.zip4 = 0,'',INTFORMAT(RIGHT.zip4,4,1)),LEFT.zip4_var9         ),
			SELF.dt_first_seen_var9  := IF(COUNTER = 10,RIGHT.dt_first_seen                            ,LEFT.dt_first_seen_var9),
			SELF.dt_last_seen_var9   := IF(COUNTER = 10,RIGHT.dt_last_seen                             ,LEFT.dt_last_seen_var9 ),
			SELF := LEFT));

	SHARED Add_Phones := DENORMALIZE(Add_Addresses,Sorted_Phone_Records,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final,
			SELF.best_phone := IF(COUNTER = 1,INTFORMAT(RIGHT.phone,10,1),LEFT.best_phone),
			SELF.phone_var1 := IF(COUNTER = 2,INTFORMAT(RIGHT.phone,10,1),LEFT.phone_var1),
			SELF.phone_var2 := IF(COUNTER = 3,INTFORMAT(RIGHT.phone,10,1),LEFT.phone_var2),
			SELF.phone_var3 := IF(COUNTER = 4,INTFORMAT(RIGHT.phone,10,1),LEFT.phone_var3),
			SELF.phone_var4 := IF(COUNTER = 5,INTFORMAT(RIGHT.phone,10,1),LEFT.phone_var4),
			SELF.phone_var5 := IF(COUNTER = 6,INTFORMAT(RIGHT.phone,10,1),LEFT.phone_var5),
			SELF.phone_var6 := IF(COUNTER = 7,INTFORMAT(RIGHT.phone,10,1),LEFT.phone_var6),
			SELF.phone_var7 := IF(COUNTER = 8,INTFORMAT(RIGHT.phone,10,1),LEFT.phone_var7),
			SELF.phone_var8 := IF(COUNTER = 9,INTFORMAT(RIGHT.phone,10,1),LEFT.phone_var8),
			SELF.phone_var9 := IF(COUNTER = 10,INTFORMAT(RIGHT.phone,10,1),LEFT.phone_var9),
			SELF := LEFT));

	SHARED Add_FEINs := DENORMALIZE(Add_Phones,Sorted_FEIN_Records,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final,
			SELF.best_fein := IF(COUNTER = 1,INTFORMAT(RIGHT.fein,9,1),LEFT.best_fein),
			SELF.fein_var1 := IF(COUNTER = 2,INTFORMAT(RIGHT.fein,9,1),LEFT.fein_var1),
			SELF.fein_var2 := IF(COUNTER = 3,INTFORMAT(RIGHT.fein,9,1),LEFT.fein_var2),
			SELF.fein_var3 := IF(COUNTER = 4,INTFORMAT(RIGHT.fein,9,1),LEFT.fein_var3),
			SELF.fein_var4 := IF(COUNTER = 5,INTFORMAT(RIGHT.fein,9,1),LEFT.fein_var4),
			SELF.fein_var5 := IF(COUNTER = 6,INTFORMAT(RIGHT.fein,9,1),LEFT.fein_var5),
			SELF.fein_var6 := IF(COUNTER = 7,INTFORMAT(RIGHT.fein,9,1),LEFT.fein_var6),
			SELF.fein_var7 := IF(COUNTER = 8,INTFORMAT(RIGHT.fein,9,1),LEFT.fein_var7),
			SELF.fein_var8 := IF(COUNTER = 9,INTFORMAT(RIGHT.fein,9,1),LEFT.fein_var8),
			SELF.fein_var9 := IF(COUNTER = 10,INTFORMAT(RIGHT.fein,9,1),LEFT.fein_var9),
			SELF := LEFT));

	SHARED Add_SIC_Codes := DENORMALIZE(Add_FEINs,Sorted_SIC_Code_Records,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final,
			SELF.best_sic_code := IF(COUNTER = 1,RIGHT.sic_code,LEFT.best_sic_code),
			SELF.sic_code_var1 := IF(COUNTER = 2,RIGHT.sic_code,LEFT.sic_code_var1),
			SELF.sic_code_var2 := IF(COUNTER = 3,RIGHT.sic_code,LEFT.sic_code_var2),
			SELF.sic_code_var3 := IF(COUNTER = 4,RIGHT.sic_code,LEFT.sic_code_var3),
			SELF.sic_code_var4 := IF(COUNTER = 5,RIGHT.sic_code,LEFT.sic_code_var4),
			SELF.sic_code_var5 := IF(COUNTER = 6,RIGHT.sic_code,LEFT.sic_code_var5),
			SELF.sic_code_var6 := IF(COUNTER = 7,RIGHT.sic_code,LEFT.sic_code_var6),
			SELF.sic_code_var7 := IF(COUNTER = 8,RIGHT.sic_code,LEFT.sic_code_var7),
			SELF.sic_code_var8 := IF(COUNTER = 9,RIGHT.sic_code,LEFT.sic_code_var8),
			SELF.sic_code_var9 := IF(COUNTER = 10,RIGHT.sic_code,LEFT.sic_code_var9),
			SELF := LEFT));

	SHARED Add_Parent_Sub := DENORMALIZE(Add_SIC_Codes,DCA_Records1,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		GROUP,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final,
			SELF.parent_sub := IF(NOT EXISTS(ROWS(RIGHT)) OR EXISTS(ROWS(RIGHT)(parent_number = '')),'P','S'),
			SELF := LEFT));

	SHARED Add_Parent_Info := JOIN(Add_Parent_Sub,Final_DCA_Records,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid AND
		LEFT.parent_sub = 'S',
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final_EXTENDED,
			SELF.parent_company_name := STD.Str.ToUpperCase(RIGHT.name),
			SELF.parent_prim_range   := RIGHT.prim_range,
			SELF.parent_predir       := RIGHT.predir,
			SELF.parent_prim_name    := RIGHT.prim_name,
			SELF.parent_addr_suffix  := RIGHT.addr_suffix,
			SELF.parent_postdir      := RIGHT.postdir,
			SELF.parent_unit_desig   := RIGHT.unit_desig,
			SELF.parent_sec_range    := RIGHT.sec_range,
			SELF.parent_city         := RIGHT.p_city_name,
			SELF.parent_state        := RIGHT.st,
			SELF.parent_zip          := RIGHT.z5,
			SELF.parent_zip4         := RIGHT.zip4,
			SELF.parent_phone        := RIGHT.phone,
			// start extended layout info
			SELF.FAX                 := RIGHT.FAX,
		  SELF.Ticker_Symbol       := RIGHT.Ticker_Symbol,
		  SELF.Net_Worth           := RIGHT.Net_Worth_,
			SELF.count_JandL := 0,
			SELF.count_ucc := 0;
			SELF.count_bk := 0;
			SELF := LEFT,
			),
		LEFT OUTER);

	SHARED Add_URL_Info := JOIN(Add_Parent_Info,Sorted_URL_Records,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final_EXTENDED,
			SELF.url := RIGHT.url,
			SELF := LEFT),
		LEFT OUTER);

	SHARED Add_Email_Info := JOIN(Add_URL_Info,Sorted_Email_Records,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final_EXTENDED,
			SELF.email := RIGHT.e_mail,
			SELF := LEFT),
		LEFT OUTER);

	SHARED Add_Registered_Agent := JOIN(Add_Email_Info,Sorted_RA_Records,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final_EXTENDED,
			SELF.ra_title := RIGHT.corp_ra_title1,
			SELF.ra_fname := RIGHT.corp_ra_fname1,
			SELF.ra_mname := RIGHT.corp_ra_mname1,
			SELF.ra_lname := RIGHT.corp_ra_lname1,
			SELF.ra_name_suffix := RIGHT.corp_ra_name_suffix1,
			SELF.ra_cname := RIGHT.corp_ra_cname1,
			SELF.ra_phone := RIGHT.corp_ra_phone10,
			SELF := LEFT),
		LEFT OUTER);

	SHARED Add_Executives := DENORMALIZE(Add_Registered_Agent,Sorted_Executives_Records,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final_EXTENDED,
			SELF.executive_title_var1         := IF(COUNTER = 1,RIGHT.title        ,LEFT.executive_title_var1        ),
			SELF.executive_fname_var1         := IF(COUNTER = 1,RIGHT.fname        ,LEFT.executive_fname_var1        ),
			SELF.executive_mname_var1         := IF(COUNTER = 1,RIGHT.mname        ,LEFT.executive_mname_var1        ),
			SELF.executive_lname_var1         := IF(COUNTER = 1,RIGHT.lname        ,LEFT.executive_lname_var1        ),
			SELF.executive_name_suffix_var1   := IF(COUNTER = 1,RIGHT.name_suffix  ,LEFT.executive_name_suffix_var1  ),
			SELF.executive_display_title_var1 := IF(COUNTER = 1,RIGHT.display_title,LEFT.executive_display_title_var1),
			SELF.executive_title_var2         := IF(COUNTER = 2,RIGHT.title        ,LEFT.executive_title_var2        ),
			SELF.executive_fname_var2         := IF(COUNTER = 2,RIGHT.fname        ,LEFT.executive_fname_var2        ),
			SELF.executive_mname_var2         := IF(COUNTER = 2,RIGHT.mname        ,LEFT.executive_mname_var2        ),
			SELF.executive_lname_var2         := IF(COUNTER = 2,RIGHT.lname        ,LEFT.executive_lname_var2        ),
			SELF.executive_name_suffix_var2   := IF(COUNTER = 2,RIGHT.name_suffix  ,LEFT.executive_name_suffix_var2  ),
			SELF.executive_display_title_var2 := IF(COUNTER = 2,RIGHT.display_title,LEFT.executive_display_title_var2),
			SELF.executive_title_var3         := IF(COUNTER = 3,RIGHT.title        ,LEFT.executive_title_var3        ),
			SELF.executive_fname_var3         := IF(COUNTER = 3,RIGHT.fname        ,LEFT.executive_fname_var3        ),
			SELF.executive_mname_var3         := IF(COUNTER = 3,RIGHT.mname        ,LEFT.executive_mname_var3        ),
			SELF.executive_lname_var3         := IF(COUNTER = 3,RIGHT.lname        ,LEFT.executive_lname_var3        ),
			SELF.executive_name_suffix_var3   := IF(COUNTER = 3,RIGHT.name_suffix  ,LEFT.executive_name_suffix_var3  ),
			SELF.executive_display_title_var3 := IF(COUNTER = 3,RIGHT.display_title,LEFT.executive_display_title_var3),
			SELF.executive_title_var4         := IF(COUNTER = 4,RIGHT.title        ,LEFT.executive_title_var4        ),
			SELF.executive_fname_var4         := IF(COUNTER = 4,RIGHT.fname        ,LEFT.executive_fname_var4        ),
			SELF.executive_mname_var4         := IF(COUNTER = 4,RIGHT.mname        ,LEFT.executive_mname_var4        ),
			SELF.executive_lname_var4         := IF(COUNTER = 4,RIGHT.lname        ,LEFT.executive_lname_var4        ),
			SELF.executive_name_suffix_var4   := IF(COUNTER = 4,RIGHT.name_suffix  ,LEFT.executive_name_suffix_var4  ),
			SELF.executive_display_title_var4 := IF(COUNTER = 4,RIGHT.display_title,LEFT.executive_display_title_var4),
			SELF.executive_title_var5         := IF(COUNTER = 5,RIGHT.title        ,LEFT.executive_title_var5        ),
			SELF.executive_fname_var5         := IF(COUNTER = 5,RIGHT.fname        ,LEFT.executive_fname_var5        ),
			SELF.executive_mname_var5         := IF(COUNTER = 5,RIGHT.mname        ,LEFT.executive_mname_var5        ),
			SELF.executive_lname_var5         := IF(COUNTER = 5,RIGHT.lname        ,LEFT.executive_lname_var5        ),
			SELF.executive_name_suffix_var5   := IF(COUNTER = 5,RIGHT.name_suffix  ,LEFT.executive_name_suffix_var5  ),
			SELF.executive_display_title_var5 := IF(COUNTER = 5,RIGHT.display_title,LEFT.executive_display_title_var5),
			SELF.executive_title_var6         := IF(COUNTER = 6,RIGHT.title        ,LEFT.executive_title_var6        ),
			SELF.executive_fname_var6         := IF(COUNTER = 6,RIGHT.fname        ,LEFT.executive_fname_var6        ),
			SELF.executive_mname_var6         := IF(COUNTER = 6,RIGHT.mname        ,LEFT.executive_mname_var6        ),
			SELF.executive_lname_var6         := IF(COUNTER = 6,RIGHT.lname        ,LEFT.executive_lname_var6        ),
			SELF.executive_name_suffix_var6   := IF(COUNTER = 6,RIGHT.name_suffix  ,LEFT.executive_name_suffix_var6  ),
			SELF.executive_display_title_var6 := IF(COUNTER = 6,RIGHT.display_title,LEFT.executive_display_title_var6),
			SELF.executive_title_var7         := IF(COUNTER = 7,RIGHT.title        ,LEFT.executive_title_var7        ),
			SELF.executive_fname_var7         := IF(COUNTER = 7,RIGHT.fname        ,LEFT.executive_fname_var7        ),
			SELF.executive_mname_var7         := IF(COUNTER = 7,RIGHT.mname        ,LEFT.executive_mname_var7        ),
			SELF.executive_lname_var7         := IF(COUNTER = 7,RIGHT.lname        ,LEFT.executive_lname_var7        ),
			SELF.executive_name_suffix_var7   := IF(COUNTER = 7,RIGHT.name_suffix  ,LEFT.executive_name_suffix_var7  ),
			SELF.executive_display_title_var7 := IF(COUNTER = 7,RIGHT.display_title,LEFT.executive_display_title_var7),
			SELF.executive_title_var8         := IF(COUNTER = 8,RIGHT.title        ,LEFT.executive_title_var8        ),
			SELF.executive_fname_var8         := IF(COUNTER = 8,RIGHT.fname        ,LEFT.executive_fname_var8        ),
			SELF.executive_mname_var8         := IF(COUNTER = 8,RIGHT.mname        ,LEFT.executive_mname_var8        ),
			SELF.executive_lname_var8         := IF(COUNTER = 8,RIGHT.lname        ,LEFT.executive_lname_var8        ),
			SELF.executive_name_suffix_var8   := IF(COUNTER = 8,RIGHT.name_suffix  ,LEFT.executive_name_suffix_var8  ),
			SELF.executive_display_title_var8 := IF(COUNTER = 8,RIGHT.display_title,LEFT.executive_display_title_var8),
			SELF.executive_title_var9         := IF(COUNTER = 9,RIGHT.title        ,LEFT.executive_title_var9        ),
			SELF.executive_fname_var9         := IF(COUNTER = 9,RIGHT.fname        ,LEFT.executive_fname_var9        ),
			SELF.executive_mname_var9         := IF(COUNTER = 9,RIGHT.mname        ,LEFT.executive_mname_var9        ),
			SELF.executive_lname_var9         := IF(COUNTER = 9,RIGHT.lname        ,LEFT.executive_lname_var9        ),
			SELF.executive_name_suffix_var9   := IF(COUNTER = 9,RIGHT.name_suffix  ,LEFT.executive_name_suffix_var9  ),
			SELF.executive_display_title_var9 := IF(COUNTER = 9,RIGHT.display_title,LEFT.executive_display_title_var9),
			SELF := LEFT));

	SHARED Add_Employees_Sales := JOIN(Add_Executives,Sorted_DCA_Records,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final_EXTENDED,
			SELF.num_employees := RIGHT.emp_num,
			SELF.sales := RIGHT.sales,
			SELF.sales_or_revenue := RIGHT.sales_or_revenue,
			SELF := LEFT),
		LEFT OUTER);

	SHARED Add_Status := JOIN(Add_Employees_Sales,Sorted_Status_Records,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final_EXTENDED,
			SELF.status := RIGHT.corp_status_desc,
			SELF := LEFT),
		LEFT OUTER);

	SHARED Add_JudgmentLiens_Flag := JOIN(Add_Status,JudgmentLiens_Flags,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final_EXTENDED,
			SELF.judgmentlien_flag := IF(RIGHT.tmsid != '','Y',''),
			SELF := LEFT),
		LEFT OUTER);

	 SHARED Add_UCCs_Flag := JOIN(Add_JudgmentLiens_Flag,UCCs_Flags,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final_EXTENDED,
			SELF.ucc_flag := IF(RIGHT.tmsid != '','Y',''),
			SELF := LEFT),
		LEFT OUTER);

	SHARED Add_Props_Flag := JOIN(Add_UCCs_Flag,Props_Flags,
		LEFT.acctno = RIGHT.acctno AND
		LEFT.groupid = RIGHT.groupid,
		TRANSFORM(RollupBusiness_BatchService_Layouts.Final_EXTENDED,
			SELF.property_flag := IF(RIGHT.ln_fares_id != '','Y',''),
			SELF := LEFT),
		LEFT OUTER);

 SHARED count_add_JandL_flags := table(
                                      dedup(sort(JudgmentLiens_byTMSID,acctno,tmsid),
																			                                 acctno,tmsid),
																			          {acctno, unsigned2 cnt:= count(group);},
	                                           acctno, FEW, UNSORTED);

   SHARED Add_JandL_Count_Info := JOIN(Add_Props_Flag, count_add_JandL_flags,
     LEFT.acctno = RIGHT.acctno,
		 TRANSFORM(rollupBusiness_Batchservice_Layouts.Final_EXTENDED,
		    SELF.count_JandL := RIGHT.cnt,
				SELF.count_ucc := 0;
				SELF.count_bk := 0;
				SELF := LEFT),
		  LEFT OUTER);

  SHARED count_add_ucc_flags := table(
	                                    dedup(sort(UCCs_byTMSID,acctno,tmsid),
																			                  acctno,tmsid),
																			       {acctno, unsigned2 cnt:= count(group);},
	                                           acctno, FEW, UNSORTED);

   SHARED Add_Ucc_Count_Info := JOIN(Add_JandL_Count_Info, Count_add_UCC_flags,
     LEFT.acctno = RIGHT.acctno,
		 TRANSFORM(rollupBusiness_Batchservice_Layouts.Final_EXTENDED,
		    SELF.count_ucc := RIGHT.cnt;
				SELF.count_bk := 0;
				SELF := LEFT),
		  LEFT OUTER);

   SHARED Count_add_BK_flags := table(
	                                    dedup(sort(Bankruptcies_byTMSID,acctno,tmsid),
																			                  acctno,tmsid),
																			       {acctno, unsigned2 cnt:= count(group);},
	                                           acctno, FEW, UNSORTED);

   SHARED Add_BK_Count_Info := JOIN(Add_UCC_Count_Info, Count_add_BK_flags,
     LEFT.acctno = RIGHT.acctno,
		 TRANSFORM(rollupBusiness_Batchservice_Layouts.Final_EXTENDED,
		    SELF.count_bk := RIGHT.cnt,
				SELF := LEFT),
		  LEFT OUTER);

  // Uncomment lines below as needed for debugging.
	// output(Header_Fetch_Records,     named('Header_Fetch_Records'));
	// output( BDID_Records_via_Header, NAMED('BDID_Records_via_Header') );
	// output( BDID_Records_via_Input, NAMED('BDID_Records_via_Input') );
	// output( BDID_records_grouped, NAMED('BDID_records_grouped') );
	// output( BDID_records_from_Input, NAMED('BDID_records_from_Input') );
	// output( BDID_records_from_Header_only, NAMED('BDID_records_from_Header_only') );
  // output(BDID_Records,             named('BDID_Records'));
  // output(GroupId_Records,          named('GroupId_Records'));
  // output(Initial_Relatives,        named('Initial_Relatives'));
  //output(Deduped_Relatives,        named('Deduped_Relatives'));
  //output(Relatives_Level1,         named('Relatives_Level1'));
  //output(Deduped_Relatives_Level1, named('Deduped_Relatives_Level1'));
  //output(Tabled_Relatives_Level1,  named('Tabled_Relatives_Level1'));
  //output(Reduced_Relatives_Level1, named('Reduced_Relatives_Level1'));
  //output(Relatives_Level2,         named('Relatives_Level2'));
  //output(Deduped_Relatives_Level2, named('Deduped_Relatives_Level2'));
  //output(Tabled_Relatives_Level2,  named('Tabled_Relatives_Level2'));
  //output(Reduced_Relatives_Level2, named('Reduced_Relatives_Level2'));
  //output(Relatives_Level3,         named('Relatives_Level3'));
  //output(Deduped_Relatives_Level3, named('Deduped_Relatives_Level3'));
  //output(Final_Relatives_Records,  named('Final_Relatives_Records'));
	//output(JudgmentLiens_byTMSID, named('JudgmentLiens_byTMSID'));
	//output(UCCs_bytmsid, named('uccs_bytmsid'));
	//output(count_add_ucc_flags, named('count_add_ucc_flags'));

  // need to slim this layout a bit before returning thus project inside the sort.
	EXPORT Records := SORT(project(Add_Props_Flag, TRANSFORM(RollupBusiness_BatchService_Layouts.Final,
	                                self := left)),acctno,penalt,groupid);
  EXPORT Records_with_derog_COUNT := SORT(Add_BK_Count_Info,  acctno, penalt, groupid);

END;
