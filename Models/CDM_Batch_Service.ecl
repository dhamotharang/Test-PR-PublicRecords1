/*--SOAP--
<message name="CDM_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
</message>
*/
/*--INFO-- CDM Batch Service*/

import address, risk_indicators, models, riskwise, ut, doxie, BIPV2, Business_Risk_BIP, BizLinkFull, STD, DueDiligence, Codes, MDR, DeathV2_Services, dx_death_master;


export CDM_Batch_Service := MACRO

	// Can't have duplicate definitions of Stored with different default values,
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('GLBPurpose',RiskWise.permittedUse.GLBA);
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

	batchin := dataset([],Models.layouts.Layout_CDM_Batch_In) 			: stored('batch_in',few);
	//output(batchin,named('BatchIn'));
	gateways := Gateway.Constants.void_gateway;

	unsigned1 prep_dppa := 0 :		stored('DPPAPurpose');
	unsigned1 glb := RiskWise.permittedUse.GLBA : stored('GLBPurpose');
	string5   industry_class_val := '';
	boolean   isUtility := false;
	boolean   ofac_Only := false;

	string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	string DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
	unsigned3 history_date := 999999 		: stored('HistoryDateYYYYMM');

    //CCPA fields
    unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
    string TransactionID := '' : stored ('_TransactionId');
    string BatchUID := '' : stored('_BatchUID');
    unsigned6 GlobalCompanyId := 0 : stored('_GCID');
    industry := IF(TRIM(industry_class_val) = DueDiligence.Constants.EMPTY, Business_Risk_BIP.Constants.Default_IndustryClass, industry_class_val);

	unsigned1 dppa := prep_dppa;

    bsVersion := 41;

    Options := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
      // Clean up the Options and make sure that defaults are enforced
      EXPORT UNSIGNED1 dppa := ^.dppa;
      EXPORT UNSIGNED1 glb := ^.glb;
      EXPORT STRING DataRestrictionMask	:= DataRestriction;
      EXPORT STRING DataPermissionMask	:= TRIM(DataPermission);
      EXPORT STRING5 industry_class := STD.Str.ToUpperCase(industry);
      EXPORT UNSIGNED1 LinkSearchLevel := Business_Risk_BIP.Constants.LinkSearch.SeleID;
      EXPORT UNSIGNED1 BusShellVersion := Business_Risk_BIP.Constants.Default_BusShellVersion;
      EXPORT UNSIGNED1 MarketingMode := Business_Risk_BIP.Constants.Default_MarketingMode;
      EXPORT STRING50 AllowedSources := Business_Risk_BIP.Constants.Default_AllowedSources;
      EXPORT UNSIGNED1 BIPBestAppend := Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest;
      EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
      EXPORT string transaction_id := IF(TransactionID <> '', TransactionID, BatchUID); // esp transaction id or batch uid
      EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
    END;

    death_params := DeathV2_Services.IParam.GetRestrictions(Options);

	// add sequence to matchup later to add acctno to output
	Models.layouts.Layout_CDM_Batch_In into_seq(batchin le, integer C) := TRANSFORM
		SELF.seq := C;
		SELF := le;
	END;
	batchinseq := project(batchin, into_seq(left,counter));

	UCase := STD.Str.ToUpperCase;

	risk_indicators.Layout_Input into_in(batchinseq le) := TRANSFORM
		SELF.did 	:= (integer)le.ADL;
		SELF.score := (integer)le.ADLScore;

		// clean up input
		dob_val := riskwise.cleandob(le.dob);

		SELF.seq := le.seq;
		SELF.ssn := IF(le.SSN_TIN_FEIN='000000000','',le.SSN_TIN_FEIN);	// blank out social if it is all 0's
		SELF.dob := dob_val;
		SELF.age := if ((integer)dob_val != 0,(STRING3)ut.Age((integer)dob_val), '');

		/* got 5 phones to deal with... for now dropping all but 1
		SELF.phone10 := le.Home_Phone;
		SELF.wphone10 := le.Work_Phone;
		*/
		SELF.phone10 := le.phone_1;

		SELF.employer_name := le.name_company;

		// 4.3 orig req spreadsheet says if company name is populated then blank out the other name fields

		cleaned_name := address.CleanPerson73(le.UnParsedFullName);
		boolean valid_cleaned := le.UnParsedFullName <> '';

		SELF.fname := if(le.name_company <> '','',STD.Str.toUpperCase(if(le.Name_First='' AND valid_cleaned, cleaned_name[6..25], le.Name_First)));
		SELF.lname := if(le.name_company <> '','',STD.Str.toUpperCase(if(le.Name_Last='' AND valid_cleaned, cleaned_name[46..65], le.Name_Last)));
		SELF.mname := if(le.name_company <> '','',STD.Str.toUpperCase(if(le.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], le.Name_Middle)));
		SELF.suffix := if(le.name_company <> '','',STD.Str.toUpperCase(if(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix)));
		SELF.title := if(le.name_company <> '','',STD.Str.toUpperCase(if(valid_cleaned, cleaned_name[1..5],'')));

		street_address := trim(le.street_addr + ' ' + le.street_addr_2);
		clean_addr := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Zip) ;

		SELF.in_streetAddress := street_address;
		SELF.in_city := le.p_City_name;
		SELF.in_state := le.St;
		SELF.in_zipCode := le.Zip;

		SELF.prim_range := Address.CleanFields(clean_addr).prim_range;
		SELF.predir := Address.CleanFields(clean_addr).predir;
		SELF.prim_name := Address.CleanFields(clean_addr).prim_name;
		SELF.addr_suffix := Address.CleanFields(clean_addr).addr_suffix;
		SELF.postdir := Address.CleanFields(clean_addr).postdir;
		SELF.unit_desig := Address.CleanFields(clean_addr).unit_desig;
		SELF.sec_range := Address.CleanFields(clean_addr).sec_range;
		SELF.p_city_name := Address.CleanFields(clean_addr).p_city_name;
		SELF.st := Address.CleanFields(clean_addr).st;
		SELF.z5 := Address.CleanFields(clean_addr).zip;
		SELF.zip4 := Address.CleanFields(clean_addr).zip4;
		SELF.lat := Address.CleanFields(clean_addr).geo_lat;
		SELF.long := Address.CleanFields(clean_addr).geo_long;
		SELF.addr_type := Address.CleanFields(clean_addr).rec_type[1];
		SELF.addr_status := Address.CleanFields(clean_addr).err_stat;
		SELF.county := Address.CleanFields(clean_addr).county[3..5]; // we only want the county fips, not all 5.  first 2 are the state fips
		SELF.geo_blk := Address.CleanFields(clean_addr).geo_blk;

		SELF.historydate := if(le.historydateYYYYMM=0, history_date, le.historydateYYYYMM);
		SELF := [];
	END;
	cleanInput := project(batchinseq, into_in(left));
	//output(cleanIn,named('CleanIn'));

	// set variables for passing to bocashell function
	BOOLEAN includeDLverification := true;
	boolean 	require2ele := false;
	boolean   isLn := false;	// not needed anymore
	boolean   doRelatives := true;
	boolean   doDL := true; // n
	boolean   doVehicle := true; // n
	boolean   doDerogs := true;
	boolean   suppressNearDups := false;
	boolean   fromBIID := false;
	boolean   isFCRA := false;
	boolean   fromIT1O := false;
	boolean   doScore := false;
	boolean   nugen := true;
	BOOLEAN ofacSearching := false;
	UNSIGNED1 ofacVersion := 0;
	BOOLEAN includeAdditionalWatchlists := false;
	BOOLEAN excludeWatchlists := true;
	BOOLEAN filterOutFares := TRUE;
	append_best := 0;

	unsigned8 BSOptions := risk_indicators.iid_constants.BSOptions.IncludeDoNotMail +
												 risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity;

	layout_decd := record
		 string decd_src1;
		 string decd_srcs;
		 string decd_firstseen_dts;
		 Risk_Indicators.Layout_Boca_Shell;
		END;

	fn_getPersonAttributes(cleanIn) := FUNCTIONMACRO
		/* ***************************************
				*     Gather Boca Shell Results:      *
			 *************************************** */
		iid := Risk_Indicators.InstantID_Function(cleanIn, gateways, DPPA, GLB, isUtility, isLn, ofac_Only,
																							suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, ofacSearching, includeAdditionalWatchlists,
																							in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission,
                                                                                            LexIdSourceOptout := LexIdSourceOptout,
                                                                                            TransactionID := TransactionID,
                                                                                            BatchUID := BatchUID,
                                                                                            GlobalCompanyID := GlobalCompanyID);

		clam := Risk_Indicators.Boca_Shell_Function(iid, gateways, DPPA, GLB, isUtility, isLn, doRelatives, doDL,
																								doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																								BSOptions := BSOptions, DataPermission := DataPermission,
                                                                                                LexIdSourceOptout := LexIdSourceOptout,
                                                                                                TransactionID := TransactionID,
                                                                                                BatchUID := BatchUID,
                                                                                                GlobalCompanyID := GlobalCompanyID);

		//output(clam,named('clam'));

		/* ***************************************
				*     Gather Deceased Results:        *
			 *************************************** */
		deathSSNKey := Death_Master.key_ssn_ssa(isFCRA);
		deathHDRKey := doxie.key_Header;

		layout_decd getSSNDecd(clam le, deathSSNkey ri) := transform
		 SELF.decd_src1 := ri.src;
		 SELF.decd_srcs := ri.src;
		 SELF.decd_firstseen_dts := ri.filedate;
		 SELF := le;
		END;

		layout_decd getHDRDecd(clam le, deathHDRKey ri) := transform
		 SELF.decd_src1 := ri.src;
		 SELF.decd_srcs := ri.src;
		 SELF.decd_firstseen_dts := (string)ri.dt_first_seen;
		 SELF := le;
		END;

		SSN_Decd := join(clam, deathssnkey,
											 length(left.shell_input.ssn)=9 and keyed(left.shell_input.ssn = right.ssn)
												 and (((integer)right.dod8 <> 0 and (UNSIGNED)(RIGHT.dod8[1..6]) < LEFT.historydate)
													or ((integer)right.filedate <> 0 and(UNSIGNED)(RIGHT.filedate[1..6]) < LEFT.historydate))
												 AND (right.src <> MDR.sourceTools.src_Death_Restricted or
															Risk_Indicators.iid_constants.deathSSA_ok(DataPermission)),
										 getSSNDecd(left,right), left outer,
										 atmost(riskwise.max_atmost)
										);
		//output(SSN_Decd,named('SSN_Deceased'));

        DID_Decd_unformatted := dx_death_master.Append.byDid(clam, did, death_params);

        layout_decd getDIDDecd(clam le, DID_Decd_unformatted ri) := transform
		 SELF.decd_src1 := ri.death.src;
		 SELF.decd_srcs := ri.death.src;
		 SELF.decd_firstseen_dts := ri.death.filedate;
		 SELF := le;
		END;

		DID_Decd := JOIN(clam, DID_Decd_unformatted,
																	 LEFT.did<>0 AND LEFT.did = RIGHT.did
												 AND (((integer)right.death.dod8 <> 0 and (UNSIGNED)(RIGHT.death.dod8[1..6]) < LEFT.historydate)
													or ((integer)right.death.filedate <> 0 and (UNSIGNED)(RIGHT.death.filedate[1..6]) < LEFT.historydate))
												 AND (Risk_Indicators.iid_constants.deathSSA_ok(DataPermission)),
																 getDIDDecd(LEFT, RIGHT), LEFT OUTER, KEEP(100));

		HDR_Decd := JOIN(clam, deathhdrkey,
											 left.did<>0 and keyed(left.did=right.s_did)
												 and ((right.dod <> 0 and right.dod < left.historydate)
													 or (right.dt_first_seen <> 0 and right.dt_first_seen < left.historydate))
												 and (right.src = 'DS'),
											 getHDRDecd(left,right), left outer, atmost(riskwise.max_atmost)
										 );
		//output(HDR_Decd,named('HDR_Deceased'));

		layout_decd combine_decd(layout_decd le, layout_decd ri) := transform
			SELF.decd_srcs := le.decd_srcs + if(le.decd_src1 != ri.decd_srcs, ',' + ri.decd_srcs, '');
			SELF.decd_src1 := ri.decd_srcs;
			SELF.decd_firstseen_dts := le.decd_firstseen_dts + if(le.decd_src1 != ri.decd_srcs, ',' + ri.decd_firstseen_dts,'');
			SELF := le;
		END;

		deceased_combo := ungroup(SSN_Decd+DID_Decd+HDR_Decd);
		//output(deceased_combo,named('Deceased_Combo'));

		alldeceasedrecs := sort(deceased_combo,seq,decd_srcs,decd_firstseen_dts);
		//output(alldeceasedrecs,named('All_Deceased'));

		dedup_deceased := dedup(alldeceasedrecs,seq,decd_srcs);
		//output(dedup_deceased,named('Deceased_Deduped'));

		rolldeceased := rollup(dedup_deceased, left.seq = right.seq, combine_decd(left, right));
		//output(rolldeceased,named('Rolled_Deceased'));

		RETURN rolldeceased;
	ENDMACRO;

	rolldeceased := fn_getPersonAttributes(cleanInput(fname<>'' OR lname<>''));

	months_apart(unsigned3 system_yearmonth, unsigned some_yearmonth) := function
		 days := ut.DaysApart((string)system_yearmonth + '01', (string)some_yearmonth + '01' );
			days_in_a_month := 30.5;
			calculated_months := days/days_in_a_month;
			months := if(some_yearmonth=0, 0, calculated_months);
			return round(months);
		END;
	// this function is for correcting months of 00 in header dates.
	unsigned3 fixYYYY00( unsigned YYYYMM ) := if( YYYYMM > 0 and YYYYMM % 100 = 0, YYYYMM + 1, YYYYMM );
	// stolen from get leadintegrity attributes to calc months between dates

	//function to get Business Attributes
	fn_getBusinessAttributes(batchinputseq) := FUNCTIONMACRO

		InputCompanyInfo := RECORD
			STRING120 Name_Company;
			STRING9   SSN_TIN_FEIN;
			STRING4		SIC_Code;
			STRING6		NAICS_Code;
		END;
		CleanAddrFields := RECORD
			STRING10 Prim_Range  := '';
			STRING2  PreDir      := '';
			STRING28 Prim_Name   := '';
			STRING4  Addr_Suffix := '';
			STRING2  PostDir     := '';
			STRING10 Unit_Desig  := '';
			STRING8  Sec_Range   := '';
			STRING25 P_City_Name := '';
			STRING25 V_City_Name := '';
			STRING2  St          := '';
			STRING5  Zip5        := '';
			STRING4  Zip4        := '';
			STRING10 Lat         := '';
			STRING11 Long        := '';
			STRING1  Addr_Type   := '';
			STRING4  Addr_Status := '';
			STRING3  County      := '';
			STRING7  Geo_Block   := '';
		END;
		InputCompanyInfoClean := RECORD
			UNSIGNED4		Seq := 0;
			STRING30		AcctNo := '';
			UNSIGNED6		HistoryDate;
			InputCompanyInfo;
			CleanAddrFields;
			STRING10		Phone10;
			unsigned6		ProxID;
			unsigned6		SELEID;
		END;

		// clean business input and add sequence to matchup later
		InputCompanyInfoClean bus_intoClean_seq(batchin le) := TRANSFORM
			// Clean up the Company Name, Company Address, FEIN, and Company Phone.
			_CompanyName   := IF(le.Name_Company <> '', BizLinkFull.Fields.Make_cnp_name(le.Name_Company),'');
			_Clean_FEIN    := STD.Str.Filter(le.SSN_TIN_FEIN, '0123456789');
			_Clean_phone10 := RiskWise.CleanPhone(le.Phone_1);
			_Address       := Risk_Indicators.MOD_AddressClean.street_address(le.street_addr + ' ' + le.street_addr_2);
			_CleanAddr     := Risk_Indicators.MOD_AddressClean.clean_addr(_Address, le.p_City_name, le.St, le.Zip);
			mod_Addr       := Address.CleanFields(_CleanAddr);

			SELF.Seq            := le.Seq;
			SELF.AcctNo         := le.AcctNo;
			SELF.HistoryDate    := IF(le.historydateyyyymm <= 0, (INTEGER)Business_Risk_BIP.Constants.NinesDate, le.historydateyyyymm); // If HistoryDate not populated run in "realtime" mode
			SELF.Name_Company    := TRIM(UCase(_CompanyName));

			BusinessInstantID20_Services.Macros.mac_AppendAddrData(); // cleaned

			SELF.SSN_TIN_FEIN   := IF( LENGTH(_Clean_FEIN) != 9 OR (INTEGER)_Clean_FEIN <= 0, '', _Clean_FEIN); // Filter out FEIN's that aren't 9-Bytes, or are repeating 0's
			SELF.Phone10        := _Clean_phone10;

			SELF:=le;
			SELF := [];
		END;

		BIPV2.IDlayouts.l_xlink_ids2 grabLinkIDs(BIPV2.IdAppendLayouts.AppendOutput le) := TRANSFORM
			SELF.UniqueID		:= le.request_id;
			SELF := le;
			SELF := [];
		END;

		linkingOptions := MODULE(BIPV2.mod_sources.iParams)
					EXPORT STRING DataRestrictionMask := DataRestriction;
					EXPORT BOOLEAN ignoreFares := FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore FARES data - default it to FALSE to always utilize whatever the DataRestrictionMask allows
					EXPORT BOOLEAN ignoreFidelity := FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore Fidelity data - default it to FALSE to always utilize whatever the DataRestrictionMask allows
					EXPORT BOOLEAN AllowAll := FALSE;
					EXPORT BOOLEAN AllowGLB := Risk_Indicators.iid_constants.GLB_OK(glb, FALSE);
					EXPORT BOOLEAN AllowDPPA := Risk_Indicators.iid_constants.DPPA_OK(dppa, FALSE);
					EXPORT UNSIGNED1 DPPAPurpose := dppa;
					EXPORT UNSIGNED1 GLBPurpose := glb;
					EXPORT BOOLEAN IncludeMinors := TRUE; // Shouldn't really have an impact on business searches, set to TRUE for now
					EXPORT BOOLEAN LNBranded := TRUE; // Not entirely certain what effect this has
		END;
		ds_CleanedInput := project(batchinputseq, bus_intoClean_seq(left));

		prepBIPAppend :=
						PROJECT(
							ds_CleanedInput,
							TRANSFORM( BIPV2.IdAppendLayouts.AppendInput,
								SELF.request_id     := LEFT.Seq,
								SELF.ProxID         := LEFT.ProxID,
								SELF.SeleID         := LEFT.SeleID,
								SELF.company_name   := LEFT.Name_Company,
								SELF.Sec_Range      := LEFT.Sec_Range,
								SELF.Prim_Range     := LEFT.Prim_Range,
								SELF.Prim_Name      := LEFT.Prim_Name,
								SELF.City           := LEFT.p_City_name,
								SELF.State          := LEFT.St,
								SELF.zip5           := LEFT.Zip5,
								SELF.FEIN           := LEFT.SSN_TIN_FEIN,
								SELF.Phone10        := LEFT.Phone10,
								SELF := LEFT,
								SELF := []
								));

		append := BIPV2.IdAppendRoxie(prepBIPAppend(company_name<>'' OR FEIN<>''),
																			scoreThreshold := 75, // 75 is the default, valid values are >= 51 and <= 100
																			weightThreshold := 43, // default is 0. Can be set higher to ensure a stronger match
																			primForce := FALSE, // Set to true to enforce that prim_range match unless not specified in input
																			reAppend := FALSE); //do not re-append so can retrieve best info
		withBest := append.WithBest(fetchLevel := BIPV2.IdConstants.fetch_level_seleid);



		ds_BIPIDs := PROJECT(withBest, grabLinkIDs(LEFT));
		// ds_bus_best_info := BusinessInstantID20_Services.fn_GetBestBusinessInfo(ds_BIPIDs,Options,linkingOptions);
		ds_BusinessHeaderRaw1 :=
							BIPV2.Key_BH_Linking_Ids.kFetch2(inputs                   := ds_BIPIDs,
																							 Level                    := Business_Risk_BIP.Common.SetLinkSearchLevel(Business_Risk_BIP.Constants.LinkSearch.SeleID),
																							 ScoreThreshold           := 0, // ScoreThreshold --> 0 = Give me everything
																							 in_mod                   := linkingOptions,
																							 JoinLimit                := Business_Risk_BIP.Constants.Limit_BusHeader,//2500 and Business_Risk_BIP.Constants.Limit_Default 2000,
																							 dnbFullRemove            := FALSE,
																							 bypassContactSuppression := TRUE,
																							 JoinType                 := BIPV2.IDconstants.JoinTypes.LimitTransformJoin );// Options.KeepLargeBusinesses  same final result as Business_Risk_BIP.Constants.DefaultJoinType );

		// clean up the business header before doing anything else
		Business_Risk_BIP.Common.mac_slim_header(ds_BusinessHeaderRaw1, ds_BusinessHeaderRaw);

		//BEST_INFO
		ds_BestInformationRaw := BIPV2_Best.Key_LinkIds.kFetch2(inputs := ds_BIPIDs,
																															 Level  := Business_Risk_BIP.Common.SetLinkSearchLevel(Business_Risk_BIP.Constants.LinkSearch.SeleID),//Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																															 ScoreThreshold := 0, // ScoreThreshold --> 0 = Give me everything
																															 in_mod := linkingOptions,
																															 IncludeStatus := TRUE,
																															 JoinLimit := Business_Risk_BIP.Constants.Limit_Default,
																															 JoinType := /* Options.KeepLargeBusinesses */ Business_Risk_BIP.Constants.DefaultJoinType);
		ds_BestBusinessHeaderRaw := ds_BestInformationRaw(proxid = 0);
		BusinessInstantID20_Services.layouts.BestInfoLayout xfm_SelectBestInformation( RECORDOF(ds_BestBusinessHeaderRaw) le ) := TRANSFORM
			bestCompanyName     := le.Company_Name[1];
			bestCompanyAddress  := le.Company_Address[1];
			bestSICCode         := le.sic_code[1].company_sic_code1[1..4];
			bestNAICSCode       := le.naics_code[1].company_naics_code1[1..6];

			SELF.Seq                  := le.uniqueid;
			SELF.isactive             := le.isactive;
			SELF.isdefunct            := le.isdefunct;
			SELF.dt_first_seen        := bestCompanyName.dt_first_seen;
			SELF.dt_last_seen         := bestCompanyName.dt_last_seen;
			SELF.best_bus_name        := bestCompanyName.Company_Name;
			SELF.best_bus_prim_range  := bestCompanyAddress.Company_Prim_Range;
			SELF.best_bus_predir      := bestCompanyAddress.Company_Predir;
			SELF.best_bus_prim_name   := bestCompanyAddress.Company_Prim_Name;
			SELF.best_bus_addr_suffix := bestCompanyAddress.Company_Addr_Suffix;
			SELF.best_bus_postdir     := bestCompanyAddress.Company_Postdir;
			SELF.best_bus_unit_desig  := bestCompanyAddress.Company_Unit_Desig;
			SELF.best_bus_sec_range   := bestCompanyAddress.Company_Sec_Range;
			SELF.best_bus_addr        := Address.Addr1FromComponents(bestCompanyAddress.Company_Prim_Range, bestCompanyAddress.Company_Predir, bestCompanyAddress.Company_Prim_Name, bestCompanyAddress.Company_Addr_Suffix, bestCompanyAddress.Company_Postdir, bestCompanyAddress.Company_Unit_Desig, bestCompanyAddress.Company_Sec_Range);
			SELF.best_bus_city        := IF( bestCompanyAddress.company_p_city_name != '', bestCompanyAddress.company_p_city_name, bestCompanyAddress.address_v_city_name );
			SELF.best_bus_state       := bestCompanyAddress.company_st;
			SELF.best_bus_zip         := bestCompanyAddress.company_zip5;
			SELF.best_bus_zip4        := bestCompanyAddress.company_zip4;
			SELF.best_bus_county      := bestCompanyAddress.county_name;
			SELF.best_bus_phone       := le.Company_Phone[1].Company_Phone;
			SELF.best_bus_fein        := le.Company_FEIN[1].Company_FEIN;
			SELF.best_sic_code        := bestSICCode;
			SELF.best_sic_desc        := UCase( Codes.Key_SIC4(KEYED(SIC4_Code = bestSICCode))[1].sic4_description );
			SELF.best_naics_code      := bestNAICSCode;
			SELF.best_naics_desc      := UCase( Codes.Key_NAICS(KEYED(naics_code = bestNAICSCode))[1].naics_description );
			SELF := [];
		END;
		ds_BestBusinessHeaderInfo := PROJECT( ds_BestBusinessHeaderRaw, xfm_SelectBestInformation(LEFT) );

		finalBusnHeaderLayout := RECORD
			UNSIGNED4 		uniqueid;
			unsigned6			seleid;
			STRING2				source;
			STRING8				dt_first_seen;
		END;
		ds_BusinessHeaderBestFein :=
					JOIN(
						ds_BusinessHeaderRaw, ds_BestBusinessHeaderInfo,
						LEFT.uniqueid = RIGHT.seq AND LEFT.company_fein=RIGHT.best_bus_fein,
						TRANSFORM(finalBusnHeaderLayout,
							SELF.dt_first_seen:=(STRING)LEFT.dt_first_seen;
							SELF:=LEFT),
						INNER );
		ds_BusinessHeaderBestCompanyName :=
					JOIN(
						ds_BusinessHeaderRaw, ds_BestBusinessHeaderInfo,
						LEFT.uniqueid = RIGHT.seq AND LEFT.company_name=RIGHT.best_bus_name,
						TRANSFORM(finalBusnHeaderLayout,
							SELF.dt_first_seen:=(STRING)LEFT.dt_first_seen;
							SELF:=LEFT),
						INNER );

		// BUSINESS
		bus_credit_sources    := MDR.sourceTools.set_Business_Credit + MDR.sourceTools.set_Dunn_Bradstreet + MDR.sourceTools.set_Dunn_Bradstreet_Fein +
														 MDR.sourceTools.set_EBR + [MDR.sourceTools.src_Experian_CRDB] + MDR.sourceTools.set_Experian_FEIN + MDR.sourceTools.set_Cortera;
		bus_credit_combo_sources := [];
		bus_govt_sources      := MDR.sourceTools.set_Bk + MDR.sourceTools.set_CA_Sales_Tax + MDR.sourceTools.set_CorpV2 +
														 MDR.sourceTools.set_DCA + MDR.sourceTools.set_Dea + MDR.sourceTools.set_FAA + MDR.sourceTools.set_fbnv2 + MDR.sourceTools.set_FDIC +
														 MDR.sourceTools.set_IRS_5500 + MDR.sourceTools.set_IRS_Non_Profit + MDR.sourceTools.set_Liens_v2 + MDR.sourceTools.set_lnpropertyV2 +
														 MDR.sourceTools.set_TXBUS + MDR.sourceTools.set_UCCV2 + MDR.sourceTools.set_vehicles + MDR.sourceTools.set_WC + MDR.sourceTools.set_Workers_Compensation +
														 MDR.sourceTools.set_INFOUSA_ABIUS_USABIZ ;
		bus_govt_combo_srcs   := []; // note L2/LI count as 1
		bus_behav_sources     := MDR.sourceTools.set_BBB_Member + MDR.sourceTools.set_BBB_Non_Member + MDR.sourceTools.set_CClue + MDR.sourceTools.set_Credit_Unions +
														 MDR.sourceTools.set_Frandx + MDR.sourceTools.set_OSHAIR + MDR.sourceTools.set_Yellow_Pages +
														 MDR.sourceTools.set_Business_Registration;
		//Best FEIN
		ds_BusinessHeaderDedupedBestFEIN := DEDUP(SORT(ds_BusinessHeaderBestFein,uniqueid,seleid,source,dt_first_seen),uniqueid,seleid,source);
		ds_BusinessHeaderRecBestFEIN := RECORD
			ds_BusinessHeaderDedupedBestFEIN.uniqueid;
			STRING3 BusBestFEINCreditBureauCount      := (STRING3)COUNT(GROUP,ds_BusinessHeaderDedupedBestFEIN.source in bus_credit_sources);
			STRING8 BusBestFEINCreditBureauMonthsSeen := (STRING8)MIN(ds_BusinessHeaderDedupedBestFEIN(source in bus_credit_sources and dt_first_seen<>'0'),dt_first_seen);
			STRING3 BusBestFEINGovernmentCount        := (STRING3)COUNT(GROUP,ds_BusinessHeaderDedupedBestFEIN.source in bus_govt_sources);
			STRING8 BusBestFEINGovernmentMonthsSeen   := (STRING8)MIN(ds_BusinessHeaderDedupedBestFEIN(source in bus_govt_sources and dt_first_seen<>'0'),dt_first_seen);
			STRING3 BusBestFEINBehavioralCount        := (STRING3)COUNT(GROUP,ds_BusinessHeaderDedupedBestFEIN.source in bus_behav_sources);
			STRING8 BusBestFEINBehavioralMonthsSeen   := (STRING8)MIN(ds_BusinessHeaderDedupedBestFEIN(source in bus_behav_sources and dt_first_seen<>'0'),dt_first_seen);
		END;
		ds_BusinessHeaderGroupedBestFEIN := TABLE(ds_BusinessHeaderDedupedBestFEIN, ds_BusinessHeaderRecBestFEIN, uniqueid);
		//Best Company Name
		ds_BusinessHeaderDedupedBestCompanyName := DEDUP(SORT(ds_BusinessHeaderBestCompanyName,uniqueid,seleid,source,dt_first_seen),uniqueid,seleid,source);
		ds_BusinessHeaderRecBestCompanyName := RECORD
			ds_BusinessHeaderDedupedBestCompanyName.uniqueid;
			STRING3 BusBestCompanyNameCreditBureauCount      := (STRING3)COUNT(GROUP,ds_BusinessHeaderDedupedBestCompanyName.source in bus_credit_sources);
			STRING8 BusBestCompanyNameCreditBureauMonthsSeen := (STRING8)MIN(ds_BusinessHeaderDedupedBestCompanyName(source in bus_credit_sources and dt_first_seen<>'0'),dt_first_seen);
			STRING3 BusBestCompanyNameGovernmentCount        := (STRING3)COUNT(GROUP,ds_BusinessHeaderDedupedBestCompanyName.source in bus_govt_sources);
			STRING8 BusBestCompanyNameGovernmentMonthsSeen   := (STRING8)MIN(ds_BusinessHeaderDedupedBestCompanyName(source in bus_govt_sources and dt_first_seen<>'0'),dt_first_seen);
			STRING3 BusBestCompanyNameBehavioralCount        := (STRING3)COUNT(GROUP,ds_BusinessHeaderDedupedBestCompanyName.source in bus_behav_sources);
			STRING8 BusBestCompanyNameBehavioralMonthsSeen   := (STRING8)MIN(ds_BusinessHeaderDedupedBestCompanyName(source in bus_behav_sources and dt_first_seen<>'0'),dt_first_seen);
		END;
		ds_BusinessHeaderGroupedBestCompanyName := TABLE(ds_BusinessHeaderDedupedBestCompanyName, ds_BusinessHeaderRecBestCompanyName, uniqueid);
		BusinessHeader_FinalLayout := RECORD
			UNSIGNED4 uniqueid;
			STRING3		BusBestFEINCreditBureauCount;
			STRING8		BusBestFEINCreditBureauMonthsSeen;
			STRING3		BusBestFEINGovernmentCount;
			STRING8		BusBestFEINGovernmentMonthsSeen;
			STRING3		BusBestFEINBehavioralCount;
			STRING8		BusBestFEINBehavioralMonthsSeen;
			STRING3		BusBestCompanyNameCreditBureauCount;
			STRING8		BusBestCompanyNameCreditBureauMonthsSeen;
			STRING3		BusBestCompanyNameGovernmentCount;
			STRING8		BusBestCompanyNameGovernmentMonthsSeen;
			STRING3		BusBestCompanyNameBehavioralCount;
			STRING8		BusBestCompanyNameBehavioralMonthsSeen;
		END;
		BusinessHeader_FinalLayout xfm_final(ds_BusinessHeaderGroupedBestFEIN l,ds_BusinessHeaderGroupedBestCompanyName r) := TRANSFORM
			SELF.uniqueid := IF(l.uniqueid<>0,l.uniqueid,r.uniqueid);
			SELF := l;
			SELF := r;
			SELF := [];
		END;
		ds_BusinessHeaderGroupedCombined := JOIN(ds_BusinessHeaderGroupedBestFEIN,ds_BusinessHeaderGroupedBestCompanyName,
																							LEFT.uniqueid = RIGHT.uniqueid,
																							xfm_final(LEFT,RIGHT),
																							FULL OUTER);

		ds_BusinessHeaderGroupedCombinedWithSeq := JOIN(ds_CleanedInput, ds_BusinessHeaderGroupedCombined,
																									LEFT.seq=RIGHT.uniqueid,
																									TRANSFORM(models.layouts.layout_CDM_Batch_Out,
																									  system_yearmonth := if(LEFT.historydate = risk_indicators.iid_constants.default_history_date, (INTEGER)((STRING8)Std.Date.Today())[1..6], LEFT.historydate);
																										SELF.seq := LEFT.seq;
																										SELF.acctno := LEFT.acctno;
																										SELF.BusBestFEINCreditBureauCount := RIGHT.BusBestFEINCreditBureauCount;
																										SELF.BusBestFEINCreditBureauMonthsSeen := (STRING)months_apart(system_yearmonth, fixYYYY00((integer)trim(RIGHT.BusBestFEINCreditBureauMonthsSeen)[1..6]));
																										SELF.BusBestFEINGovernmentCount := RIGHT.BusBestFEINGovernmentCount;
																										SELF.BusBestFEINGovernmentMonthsSeen := (STRING)months_apart(system_yearmonth, fixYYYY00((integer)trim(RIGHT.BusBestFEINGovernmentMonthsSeen)[1..6]));//RIGHT.BusBestFEINGovernmentMonthsSeen[1..6];
																										SELF.BusBestFEINBehavioralCount := RIGHT.BusBestFEINBehavioralCount;
																										SELF.BusBestFEINBehavioralMonthsSeen := (STRING)months_apart(system_yearmonth, fixYYYY00((integer)trim(RIGHT.BusBestFEINBehavioralMonthsSeen)[1..6]));//RIGHT.BusBestFEINBehavioralMonthsSeen[1..6];
																										SELF.BusBestCompanyNameCreditBureauCount := RIGHT.BusBestCompanyNameCreditBureauCount;
																										SELF.BusBestCompanyNameCreditBureauMonthsSeen := (STRING)months_apart(system_yearmonth, fixYYYY00((integer)trim(RIGHT.BusBestCompanyNameCreditBureauMonthsSeen)[1..6]));//RIGHT.BusBestCompanyNameCreditBureauMonthsSeen[1..6];
																										SELF.BusBestCompanyNameGovernmentCount := RIGHT.BusBestCompanyNameGovernmentCount;
																										SELF.BusBestCompanyNameGovernmentMonthsSeen := (STRING)months_apart(system_yearmonth, fixYYYY00((integer)trim(RIGHT.BusBestCompanyNameGovernmentMonthsSeen)[1..6]));//RIGHT.BusBestCompanyNameGovernmentMonthsSeen[1..6];
																										SELF.BusBestCompanyNameBehavioralCount := RIGHT.BusBestCompanyNameBehavioralCount;
																										SELF.BusBestCompanyNameBehavioralMonthsSeen := (STRING)months_apart(system_yearmonth, fixYYYY00((integer)trim(RIGHT.BusBestCompanyNameBehavioralMonthsSeen)[1..6]));//RIGHT.BusBestCompanyNameBehavioralMonthsSeen[1..6];
																										SELF := [];
																										),
																									LEFT OUTER);
		// output(ds_CleanedInput,named('ds_CleanedInput'));
		// output(prepBIPAppend,named('prepBIPAppend'));
		// output(BIPAppendLinkID,named('BIPAppendLinkID'));
		// output(BIPAppend,named('BIPAppend'));
		// output(ds_BIPIDs,named('ds_BIPIDs'));
		// output(ds_BusinessHeaderRaw1,named('ds_BusinessHeaderRaw1'));
		// output(ds_BusinessHeaderRaw,named('ds_BusinessHeaderRaw'));
		// output(ds_BestBusinessHeaderInfo,named('ds_BestBusinessHeaderInfo'));
		// output(ds_BusinessHeader,named('ds_BusinessHeader'));
		// output(ds_BusinessHeaderDedupedBestCompanyName,named('ds_BusinessHeaderDedupedBestCompanyName'));
		// output(ds_BusinessHeaderGroupedBestCompanyName,named('ds_BusinessHeaderGroupedBestCompanyName'));
		// output(ds_BusinessHeaderDedupedBestFEIN,named('ds_BusinessHeaderDedupedBestFEIN'));
		// output(ds_BusinessHeaderGroupedBestFEIN,named('ds_BusinessHeaderGroupedBestFEIN'));
		// output(ds_BusinessHeaderGroupedCombined,named('ds_BusinessHeaderGroupedCombined'));
		// output(ds_bus_best_info,named('ds_bus_best_info'));
		// output(ds_WithBusnHeaderBestFEIN,named('ds_WithBusnHeaderBestFEIN'));
		RETURN ds_BusinessHeaderGroupedCombinedWithSeq;

	ENDMACRO;
	batchInputseq := batchinseq(Name_Company<>'' AND SSN_TIN_FEIN<>'' AND Name_First='' AND Name_Last='' AND unParsedFullName='');
	ds_BusinessHeaderGroupedCombinedWithSeq := fn_getBusinessAttributes(batchInputseq);


	models.layouts.layout_CDM_Batch_Out get_clam(layout_decd le) := TRANSFORM
		SELF.seq := le.seq;
		system_yearmonth := if(le.historydate = risk_indicators.iid_constants.default_history_date, (INTEGER)((STRING8)Std.Date.Today())[1..6], le.historydate);

		noAddrinput    := not le.input_validation.Address;
		noSSNinput     := not le.input_validation.ssn;
		noDOBinput     := not le.input_validation.dateofbirth;
		noFNameInput   := not le.input_validation.firstname;
		noLNameInput   := not le.input_validation.lastname;

		// orig source code lists from sheet provided by AJ
		// these codes are used with the ver_x_sources part in the header_summary of the clam
		// and with the death keys for the deceased results
		credit_sources    := ['EQ', 'EN'];
		credit_combo_srcs := ['TN', 'TS', 'TU']; // note that TN/TS/TU only count as 1 source if multiple of them are present

		govt_sources      := ['AK', 'AM', 'AR', 'BA', 'CG', 'DA', 'D',
													'DS', 'DE', 'EB', 'EM', 'E1', 'E2', 'E3', 'E4',
																		 'FE', 'FF', 'FR', 'MW', 'NT', 'P',
																		 'V',  'VO', 'W'];
		govt_combo_srcs   := ['L2', 'LI']; // note L2/LI count as 1
		decd_govt_srcs    := ['D0', 'D2', 'D3', 'D7', 'D9', 'D$', 'D!', 'D@', 'D%',
													'OP']; // death sources for states, and OP = OKC Probate

		allDL_sources     := ['CY', 'D'];
		govtDL_sources    := ['D'];
		nongovtDL_sources := ['CY'];

		voter_sources     := ['VO'];
		vehicle_sources   := ['V'];
		property_sources  := ['P'];

		behav_sources     := ['CY', 'PL', 'SL', 'WP'];
		decd_behav_srcs   := ['OB', 'TR', '64']; // For deceased, obits, tributes, and enclarity are being lumped into behavioral

		ssn_dts   := models.common.zip2(le.header_summary.ver_ssn_sources, le.header_summary.ver_ssn_sources_first_seen_date,',',models.common.options.leftouter);
		ssn_src_dts := sort(ssn_dts(str2 not in ['','0']),str2,str1) + sort(ssn_dts(str2 in ['','0']),str1);
		addr_dts  := models.common.zip2(le.header_summary.ver_addr_sources, le.header_summary.ver_addr_sources_first_seen_date,',',models.common.options.leftouter);
		addr_src_dts := sort(addr_dts(str2 not in ['','0']),str2,str1) + sort(addr_dts(str2 in ['','0']),str1);
		dob_dts   := models.common.zip2(le.header_summary.ver_dob_sources, le.header_summary.ver_dob_sources_first_seen_date,',',models.common.options.leftouter);
		dob_src_dts := sort(dob_dts(str2 not in ['','0']),str2,str1) + sort(dob_dts(str2 in ['','0']),str1);
		fname_dts := models.common.zip2(le.header_summary.ver_fname_sources, le.header_summary.ver_fname_sources_first_seen_date,',',models.common.options.leftouter);
		fname_src_dts := sort(fname_dts(str2 not in ['','0']),str2,str1) + sort(fname_dts(str2 in ['','0']),str1);
		lname_dts := models.common.zip2(le.header_summary.ver_lname_sources, le.header_summary.ver_lname_sources_first_seen_date,',',models.common.options.leftouter);
		lname_src_dts := sort(lname_dts(str2 not in ['','0']),str2,str1) + sort(lname_dts(str2 in ['','0']),str1);
		decd_dts  := models.common.zip2(le.decd_srcs, le.decd_firstseen_dts,',',models.common.options.leftouter);
		decd_src_dts := sort(decd_dts(str2 not in ['','0']),str2,str1) + sort(decd_dts(str2 in ['','0']),str1);

		// ssn - credit bureau
		t_ssn_src := if(count(ssn_src_dts(str1 in credit_combo_srcs)) > 0,1,0);
		SELF.IDVerSSNCreditBureauCount     := if(noSSNinput, '-1', (string)min(9, count(ssn_src_dts(str1 in credit_sources))+t_ssn_src) );
		SELF.IDVerSSNCreditBureauMonthsSeen := map(le.did=0 => '-1',
																						SELF.IDVerSSNCreditBureauCount = '0' => '-2',
																						(integer)trim(ssn_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2) = 0 => '-3',
																						(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(ssn_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2))))
																						);
		// ssn - government
		g_ssn_src := if(count(ssn_src_dts(str1 in govt_combo_srcs)) > 0,1,0);
		SELF.IDVerSSNGovernmentCount     := if(noSSNinput, '-1', (string)min(255, count(ssn_src_dts(str1 in govt_sources))+g_ssn_src) );
		SELF.IDVerSSNGovernmentMonthsSeen := map(le.did=0 => '-1',
																					SELF.IDVerSSNGovernmentCount = '0' => '-2',
																					(integer)trim(ssn_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2) = 0 => '-3',
																					(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(ssn_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2))))
																					);
		SELF.IDVerSSNDriversLicense := map(le.did=0 or noSSNinput                                        => '-1',
																			 (count(ssn_src_dts(str1 in govtDL_sources)) > 0
																							and count(ssn_src_dts(str1 in nongovtDL_sources)) > 0) => '3',
																				count(ssn_src_dts(str1 in govtDL_sources)) > 0               => '2',
																				count(ssn_src_dts(str1 in nongovtDL_sources)) > 0            => '1',
																																																				'0');
		SELF.IDVerSSNDriversLicenseMonthsSeen := map(le.did=0 => '-1',
																								count(ssn_src_dts(str1 in allDL_sources)) = 0 => '-2',
																								(integer)trim(ssn_src_dts(str1 in allDL_sources)[1].str2) = 0 => '-3',
																								(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(ssn_src_dts(str1 in allDL_sources)[1].str2))))
																								);
		// ssn - behavioral
		SELF.IDVerSSNBehavioralCount     := if(noSSNinput, '-1', (string)min(255, count(ssn_src_dts(str1 in behav_sources))) );
		SELF.IDVerSSNBehavioralMonthsSeen := map(le.did=0 => '-1',
																					SELF.IDVerSSNBehavioralCount = '0' => '-2',
																					(integer)trim(ssn_src_dts(str1 in behav_sources)[1].str2) = 0 => '-3',
																					(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(ssn_src_dts(str1 in behav_sources)[1].str2))))
																					);


		SELF.IDVerAddrMatchesCurrent := map(le.did=0 or noAddrinput => '-1',
																				le.Address_Verification.Address_History_1.address_score >= 80 => '1',
																											'0');

		// addr - credit bureau
		t_addr_src := if(count(addr_src_dts(str1 in credit_combo_srcs)) > 0,1,0);
		SELF.IDVerAddrCreditBureauCount     := if(noaddrinput, '-1', (string)min(9, count(addr_src_dts(str1 in credit_sources))+t_addr_src) );
		SELF.IDVerAddrCreditBureauMonthsSeen := map(le.did=0 => '-1',
																								SELF.IDVerAddrCreditBureauCount = '0' => '-2',
																								(integer)trim(addr_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2) = 0 => '-3',
																								(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2))))
																								);
		// addr - government
		g_addr_src := if(count(addr_src_dts(str1 in govt_combo_srcs)) > 0,1,0);
		SELF.IDVerAddrGovernmentCount     := if(noaddrinput, '-1', (string)min(255, count(addr_src_dts(str1 in govt_sources))+g_addr_src) );
		SELF.IDVerAddrGovernmentMonthsSeen := map(le.did=0 => '-1',
																					 SELF.IDVerAddrGovernmentCount = '0' => '-2',
																					 (integer)trim(addr_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2) = 0 => '-3',
																					 (string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2))))
																					 );
		// addr - drivers license
		SELF.IDVerAddrDriversLicense          := map(le.did=0 or noAddrinput                              => '-1',
																								 (count(addr_src_dts(str1 in govtDL_sources)) > 0
																							and count(addr_src_dts(str1 in nongovtDL_sources)) > 0) => '3',
																								 count(addr_src_dts(str1 in govtDL_sources)) > 0      => '2',
																								 count(addr_src_dts(str1 in nongovtDL_sources)) > 0   => '1',
																																																				 '0');
		SELF.IDVerAddrDriversLicenseMonthsSeen := map(le.did=0 => '-1',
																							 count(addr_src_dts(str1 in allDL_sources)) = 0 => '-2',
																							 (integer)trim(addr_src_dts(str1 in allDL_sources)[1].str2) = 0 => '-3',
																							 (string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in allDL_sources)[1].str2))))
																							 );
		// addr - voter
		SELF.IDVerAddrVoterRegistration := map(le.did=0 or noAddrinput                        => '-1',
																					 count(addr_src_dts(str1 in voter_sources)) > 0 => '1',
																																														 '0');
		SELF.IDVerAddrVoterRegMonthsSeen := map(le.did=0 => '-1',
																				 count(addr_src_dts(str1 in voter_sources)) = 0 => '-2',
																				 (integer)trim(addr_src_dts(str1 in voter_sources)[1].str2) = 0 => '-3',
																				 (string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in voter_sources)[1].str2))))
																				 );
		// addr - vehicle reg
		SELF.IDVerAddrVehicleRegistration := map(le.did=0 or noAddrinput                          => '-1',
																						 count(addr_src_dts(str1 in vehicle_sources)) > 0 => '1',
																																																 '0');
		SELF.IDVerAddrVehicleRegMonthsSeen := map(le.did=0 => '-1',
																					 count(addr_src_dts(str1 in vehicle_sources)) = 0 => '-2',
																					 (integer)trim(addr_src_dts(str1 in vehicle_sources)[1].str2) = 0 => '-3',
																					 (string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in vehicle_sources)[1].str2))))
																					 );
		// addr - property
		SELF.IDVerAddrProperty := map(le.did=0 or noAddrinput                           => '-1',
																	count(addr_src_dts(str1 in property_sources)) > 0 => '1',
																																											 '0');
		SELF.IDVerAddrPropertyMonthsSeen := map(le.did=0 => '-1',
																				 count(addr_src_dts(str1 in property_sources)) = 0 => '-2',
																				 (integer)trim(addr_src_dts(str1 in property_sources)[1].str2) = 0 => '-3',
																				 (string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in property_sources)[1].str2))))
																				 );
		// addr - behavioral
		SELF.IDVerAddrBehavioralCount     := if(noAddrinput, '-1', (string)min(255, count(addr_src_dts(str1 in behav_sources))) );
		SELF.IDVerAddrBehavioralMonthsSeen := map(le.did=0 => '-1',
																					 SELF.IDVerAddrBehavioralCount = '0' => '-2',
																					 (integer)trim(addr_src_dts(str1 in behav_sources)[1].str2) = 0 => '-3',
																					 (string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(addr_src_dts(str1 in behav_sources)[1].str2))))
																					 );


		// dob - credit bureau
		t_dob_src := if(count(dob_src_dts(str1 in credit_combo_srcs)) > 0,1,0);
		SELF.IDVerDOBCreditBureauCount := if(noDOBinput, '-1', (string)min(9, count(dob_src_dts(str1 in credit_sources))+t_dob_src) );
		SELF.IDVerDOBCreditBureauMonthsSeen := map(le.did=0 => '-1',
																						SELF.IDVerDOBCreditBureauCount = '0' => '-2',
																						(integer)trim(dob_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2) = 0 => '-3',
																						(string)min(9999, months_apart(system_yearmonth,fixYYYY00((integer)trim(dob_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2))))
																						);
		// dob - government
		g_dob_src := if(count(dob_src_dts(str1 in govt_combo_srcs)) > 0,1,0);
		SELF.IDVerDOBGovernmentCount := if(noDOBinput, '-1', (string)min(255, count(dob_src_dts(str1 in govt_sources))+g_dob_src) );
		SELF.IDVerDOBGovernmentMonthsSeen := map(le.did=0 => '-1',
																					SELF.IDVerDOBGovernmentCount = '0' => '-2',
																					(integer)trim(dob_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2) = 0 => '-3',
																					(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(dob_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2))))
																					);
		// dob - drivers license
		SELF.IDVerDOBDriversLicense := map(le.did=0 or noDOBinput                              => '-1',
																			 (count(dob_src_dts(str1 in govtDL_sources)) > 0
																		and count(dob_src_dts(str1 in nongovtDL_sources)) > 0) => '3',
																			 count(dob_src_dts(str1 in govtDL_sources)) > 0      => '2',
																			 count(dob_src_dts(str1 in nongovtDL_sources)) > 0   => '1',
																																															'0');
		SELF.IDVerDOBDriversLicenseMonthsSeen := map(le.did=0 => '-1',
																							count(dob_src_dts(str1 in allDL_sources)) = 0 => '-2',
																							(integer)trim(dob_src_dts(str1 in allDL_sources)[1].str2) = 0 => '-3',
																							(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(dob_src_dts(str1 in allDL_sources)[1].str2))))
																							);
		// dob - voter
		SELF.IDVerDOBVoterRegistration := map(le.did=0 or noDOBinput => '-1',
																					count(dob_src_dts(str1 in voter_sources)) > 0 => '1',
																					'0');
		SELF.IDVerDOBVoterRegMonthsSeen := map(le.did=0 => '-1',
																				count(dob_src_dts(str1 in voter_sources)) = 0 => '-2',
																				(integer)trim(dob_src_dts(str1 in voter_sources)[1].str2) = 0 => '-3',
																				(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(dob_src_dts(str1 in voter_sources)[1].str2))))
																				);
		// dob - vehicle
		SELF.IDVerDOBVehicleRegistration := map(le.did=0 or noDOBinput => '-1',
																						count(dob_src_dts(str1 in vehicle_sources)) > 0 => '1',
																						'0');
		SELF.IDVerDOBVehicleRegMonthsSeen := map(le.did=0 => '-1',
																					count(dob_src_dts(str1 in vehicle_sources)) = 0 => '-2',
																					(integer)trim(dob_src_dts(str1 in vehicle_sources)[1].str2) = 0 => '-3',
																					(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(dob_src_dts(str1 in vehicle_sources)[1].str2))))
																					);
		// dob - behavioral
		SELF.IDVerDOBBehavioralCount     := if(noDOBinput, '-1', (string)min(255, count(dob_src_dts(str1 in behav_sources))) );
		SELF.IDVerDOBBehavioralMonthsSeen := map(le.did=0 => '-1',
																					SELF.IDVerDOBBehavioralCount = '0' => '-2',
																					(integer)trim(dob_src_dts(str1 in behav_sources)[1].str2) = 0 => '-3',
																					(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(dob_src_dts(str1 in behav_sources)[1].str2))))
																					);


		// fname - credit bureau
		t_fnm_src := if(count(fname_src_dts(str1 in credit_combo_srcs)) > 0,1,0);
		SELF.IDVerFirstNameCreditBureauCount     := if(noFNameinput, '-1', (string)min(9, count(fname_src_dts(str1 in credit_sources))+t_fnm_src) );
		SELF.IDVerFirstNameCreditBureauMonthsSeen := map(le.did=0 => '-1',
																									SELF.IDVerFirstNameCreditBureauCount = '0' => '-2',
																									(integer)trim(fname_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2) = 0 => '-3',
																									(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(fname_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2))))
																									);
		// fname - government
		g_fnm_src := if(count(fname_src_dts(str1 in govt_combo_srcs)) > 0,1,0);
		SELF.IDVerFirstNameGovernmentCount     := if(noFNameinput, '-1', (string)min(255, count(fname_src_dts(str1 in govt_sources))+g_fnm_src) );
		SELF.IDVerFirstNameGovernmentMonthsSeen := map(le.did=0 => '-1',
																								SELF.IDVerFirstNameGovernmentCount = '0' => '-2',
																								(integer)trim(fname_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2) = 0 => '-3',
																								(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(fname_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2))))
																								);
		// fname - behavioral
		SELF.IDVerFirstNameBehavioralCount     := if(noFNameinput, '-1', (string)min(255, count(fname_src_dts(str1 in behav_sources))) );
		SELF.IDVerFirstNameBehavioralMonthsSeen := map(le.did=0 => '-1',
																								SELF.IDVerFirstNameBehavioralCount = '0' => '-2',
																								(integer)trim(fname_src_dts(str1 in behav_sources)[1].str2) = 0 => '-3',
																								(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(fname_src_dts(str1 in behav_sources)[1].str2))))
																								);


		// lname - credit bureau
		t_lnm_src := if(count(lname_src_dts(str1 in credit_combo_srcs)) > 0,1,0);
		SELF.IDVerLastNameCreditBureauCount     := if(noLNameinput, '-1', (string)min(9, count(lname_src_dts(str1 in credit_sources))+t_lnm_src) );
		SELF.IDVerLastNameCreditBureauMonthsSeen := map(le.did=0 => '-1',
																									SELF.IDVerLastNameCreditBureauCount = '0' => '-2',
																									(integer)trim(lname_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2) = 0 => '-3',
																									(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(lname_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2))))
																									);
		// lname - government
		g_lnm_src := if(count(lname_src_dts(str1 in govt_combo_srcs)) > 0,1,0);
		SELF.IDVerLastNameGovernmentCount     := if(noLNameinput, '-1', (string)min(255, count(lname_src_dts(str1 in govt_sources))+g_lnm_src) );
		SELF.IDVerLastNameGovernmentMonthsSeen := map(le.did=0 => '-1',
																								SELF.IDVerLastNameGovernmentCount = '0' => '-2',
																								(integer)trim(lname_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2) = 0 => '-3',
																								(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(lname_src_dts(str1 in (govt_sources+govt_combo_srcs))[1].str2))))
																								);
		// lname - behavioral
		SELF.IDVerLastNameBehavioralCount     := if(noLNameinput, '-1', (string)min(255, count(lname_src_dts(str1 in behav_sources))) );
		SELF.IDVerLastNameBehavioralMonthsSeen := map(le.did=0 => '-1',
																								SELF.IDVerLastNameBehavioralCount = '0' => '-2',
																								(integer)trim(lname_src_dts(str1 in behav_sources)[1].str2) = 0 => '-3',
																								(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(lname_src_dts(str1 in behav_sources)[1].str2))))
																								);


		// deceased - credit bureau
		t_decd_src := if(count(decd_src_dts(str1 in credit_combo_srcs)) > 0,1,0);
		SELF.IDVerDeceasedCreditBureauCount     := (string)min(9, count(decd_src_dts(str1 in credit_sources))+t_decd_src);
		SELF.IDVerDeceasedCreditBureauMonthsSeen := map(le.did=0 => '-1',
																									SELF.IDVerDeceasedCreditBureauCount = '0' => '-2',
																									(integer)trim(decd_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2) = 0 => '-3',
																									(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(decd_src_dts(str1 in (credit_sources+credit_combo_srcs))[1].str2[1..6]))))
																									);
		// deceased - government
		g_decd_src := if(count(decd_src_dts(str1 in govt_combo_srcs)) > 0,1,0);
		SELF.IDVerDeceasedGovernmentCount     := (string)min(255, count(decd_src_dts(str1 in govt_sources+decd_govt_srcs))+g_decd_src);
		SELF.IDVerDeceasedGovernmentMonthsSeen := map(le.did=0 => '-1',
																								SELF.IDVerDeceasedGovernmentCount = '0' => '-2',
																								(integer)trim(decd_src_dts(str1 in (govt_sources+govt_combo_srcs+decd_govt_srcs))[1].str2) = 0 => '-3',
																								(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(decd_src_dts(str1 in (govt_sources+govt_combo_srcs+decd_govt_srcs))[1].str2[1..6]))))
																								);
		// deceased - behavioral
		SELF.IDVerDeceasedBehavioralCount     := (string)min(255, count(decd_src_dts(str1 in behav_sources+decd_behav_srcs)));
		SELF.IDVerDeceasedBehavioralMonthsSeen := map(le.did=0 => '-1',
																								SELF.IDVerDeceasedBehavioralCount = '0' => '-2',
																								(integer)trim(decd_src_dts(str1 in behav_sources+decd_behav_srcs)[1].str2) = 0 => '-3',
																								(string)min(9999, months_apart(system_yearmonth, fixYYYY00((integer)trim(decd_src_dts(str1 in behav_sources+decd_behav_srcs)[1].str2[1..6]))))
																								);
		SELF := le;
		SELF := [];
	END;

	models.layouts.layout_CDM_Batch_Out get_busn(ds_BusinessHeaderGroupedCombinedWithSeq ri) := TRANSFORM
		SELF.seq := ri.seq;
		SELF.acctno := ri.acctno;
		// BUSINESS
		SELF.BusBestFEINCreditBureauCount             := (STRING3)MIN(255,(INTEGER)if(ri.BusBestFEINCreditBureauCount='','0',ri.BusBestFEINCreditBureauCount));
		SELF.BusBestFEINCreditBureauMonthsSeen        := (STRING4)MIN(9999,(INTEGER)if(ri.BusBestFEINCreditBureauMonthsSeen IN ['','0'],'-1',ri.BusBestFEINCreditBureauMonthsSeen ));
		SELF.BusBestFEINGovernmentCount               := (STRING3)MIN(255,(INTEGER)if(ri.BusBestFEINGovernmentCount='','0',ri.BusBestFEINGovernmentCount));
		SELF.BusBestFEINGovernmentMonthsSeen          := (STRING4)MIN(9999,(INTEGER)if(ri.BusBestFEINGovernmentMonthsSeen IN ['','0'],'-1',ri.BusBestFEINGovernmentMonthsSeen));
		SELF.BusBestFEINBehavioralCount               := (STRING3)MIN(255,(INTEGER)if(ri.BusBestFEINBehavioralCount='','0',ri.BusBestFEINBehavioralCount));
		SELF.BusBestFEINBehavioralMonthsSeen          := (STRING4)MIN(9999,(INTEGER)if(ri.BusBestFEINBehavioralMonthsSeen IN ['','0'],'-1',ri.BusBestFEINBehavioralMonthsSeen));
		SELF.BusBestCompanyNameCreditBureauCount      := (STRING3)MIN(255,(INTEGER)if(ri.BusBestCompanyNameCreditBureauCount='','0',ri.BusBestCompanyNameCreditBureauCount));
		SELF.BusBestCompanyNameCreditBureauMonthsSeen := (STRING4)MIN(9999,(INTEGER)if(ri.BusBestCompanyNameCreditBureauMonthsSeen IN ['','0'],'-1',ri.BusBestCompanyNameCreditBureauMonthsSeen));
		SELF.BusBestCompanyNameGovernmentCount        := (STRING3)MIN(255,(INTEGER)if(ri.BusBestCompanyNameGovernmentCount='','0',ri.BusBestCompanyNameGovernmentCount));
		SELF.BusBestCompanyNameGovernmentMonthsSeen   := (STRING4)MIN(9999,(INTEGER)if(ri.BusBestCompanyNameGovernmentMonthsSeen IN ['','0'],'-1',ri.BusBestCompanyNameGovernmentMonthsSeen));
		SELF.BusBestCompanyNameBehavioralCount        := (STRING3)MIN(255,(INTEGER)if(ri.BusBestCompanyNameBehavioralCount='','0',ri.BusBestCompanyNameBehavioralCount));
		SELF.BusBestCompanyNameBehavioralMonthsSeen   := (STRING4)MIN(9999,(INTEGER)if(ri.BusBestCompanyNameBehavioralMonthsSeen IN ['','0'],'-1',ri.BusBestCompanyNameBehavioralMonthsSeen));
		SELF := [];
	END;

	clam_attrib := project( rolldeceased, get_clam(LEFT) );
	busn_attrib := project( ds_BusinessHeaderGroupedCombinedWithSeq, get_busn(LEFT) );
	merged_results := clam_attrib+busn_attrib;
	merged_plus_acct := join( merged_results, batchinseq,
													LEFT.seq=RIGHT.seq,
													TRANSFORM(models.layouts.layout_CDM_Batch_Out,SELF.acctno := RIGHT.acctno; SELF := LEFT),
													FULL OUTER
												);

	final := merged_plus_acct;

	// DEBUGGING...
	// output(batchinseq,named('batchinseq'));
	// output(batchinputseq,named('batchinputseq'));
	// output(ds_BusinessHeaderGroupedCombinedWithSeq,named('ds_BusinessHeaderGroupedCombinedWithSeq'));
	// output(clam_attrib,named('PreResults'));
	// output(rolldeceased,named('rolldeceased'));
	// output(busn_attrib,named('busn_attrib'));
	// output(merged_results,named('merged_results'));
	output(final,named('Results'));

ENDMACRO;

//Models.CDM_Batch_Service();
