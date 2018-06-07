//_Lien_RV_data is a copy of _Lien_data! If you make changes there or here you must change the other!
//_Lien_RV_data is RV 50 specific to have the same logic as boca_shell_liens_FCRA has for RV50.
//_Lien_RV_data is only used by the RV50 Report

EXPORT _Lien_RV_data(in_dids, flag_file, liensdata,      
									_history_date = 999999, boca_shell) := macro

  IMPORT liensv2, FCRA, riskwise, doxie, ut, Risk_Indicators, STD, PersonContext;

	_MAX_OVERRIDE_LIMIT := 100;

	layout_liens_main  := liensv2.Layout_liens_main_module.layout_liens_main;
 layout_liens_party := liensv2.layout_liens_party;	
	
	// check the first record in the batch to determine if this a realtime transaction or an archive test
	// if the record is default_history_date or same month as today's date, run production_realtime_mode
 // this check was stolen from Risk_Indicators.getAllBocaShellData as we want the same Juli/RV output
 // to match this report. 
	production_realtime_mode := _history_date=risk_indicators.iid_constants.default_history_date
														or _history_date = (unsigned)((string)risk_indicators.iid_constants.todaydate[1..6]);		
	  
  
	// first get the TMSID/RMSIDs for this individual
	liens_slim := JOIN( in_dids, liensv2.key_liens_DID_FCRA,
		left.did!=0 and keyed (Left.did = Right.did),
		transform(recordof(liensv2.key_liens_DID_FCRA), 
     self := right),
  atmost(riskwise.max_atmost), 
		KEEP (100));

	lien_correct_tmsid_rmsid := SET( flag_file(file_id = FCRA.FILE_ID.LIEN), record_id );
	lien_correct_ffid        := SET( flag_file(file_id = FCRA.FILE_ID.LIEN), flag_file_id );
  tmpConS := record
    string RecIdForStId;
  end;

 //Gets the PersisentIds of records we can't give back, such as DR types 
 personContext := SET(project(bocashell[1].ConsumerStatements, 
    transform(tmpConS,
    //make sure to show Lien CS and RS types for Lien Main and Lien Party types
    self.RecIdForStId := if(left.RecIdForStId <> '' and 
      left.StatementType NOT in [PersonContext.constants.RecordTypes.CS, PersonContext.constants.RecordTypes.RS] and
      left.DataGroup in [PersonContext.constants.datagroups.LIEN_MAIN, 
								PersonContext.constants.datagroups.LIEN_PARTY], 
      left.RecIdForStId, 
      '');  
      )),
      RecIdForStId);
 //We want to get the statementIds of the persisentIds that we should give back 
 //this is for when we return the consumerStatementId back in the RV report section 
/*	PcontextStId := NORMALIZE(bocashell,
    LEFT.ConsumerStatements, 
    TRANSFORM(Risk_Indicators.Layouts.tmp_Consumer_Statements, 
    SELF := RIGHT));
*/
 //Overrides aren't used when it's in archive mode so remove the override checks when in archive mode
	liens_party := JOIN (liens_slim, liensv2.key_liens_party_id_FCRA, 
					  Right.rmsid<> '' and left.tmsid <> ''
       AND keyed (Left.rmsid = Right.rmsid)
						 AND keyed (Left.tmsid = Right.tmsid)
						 AND left.did=(unsigned)right.did
						 AND (unsigned3)(RIGHT.date_first_seen[1..6]) < (unsigned3) _history_date[1..6] 
       AND (unsigned)RIGHT.date_first_seen<>0
       and right.name_type = 'D'
       and if(production_realtime_mode,
						  (string50)right.tmsid + (string50)right.rmsid not in lien_correct_tmsid_rmsid, true)  // old way - exclude corrected records
						 and if(production_realtime_mode, 
         trim((string)right.persistent_record_id) not in lien_correct_tmsid_rmsid, true)
  					and if(production_realtime_mode, 
         trim((string)right.persistent_record_id) not in personContext, true) ,
					 transform(RiskWiseFCRA.layouts.layoutParty, 
							self.ptmsid := if(right.tmsid='', '', left.tmsid);	
							self.prmsid := if(right.rmsid='', '', left.rmsid);
							self.pdate_last_seen := right.date_last_seen; //at defendant level so take here over at main where it's all defendants
							self.pdate_first_seen := right.date_first_seen;
							self.pname_type := right.name_type;
							//orig_name is not parsed/cleaned...so need to use the cleaned name fields
							self.porig_name := Risk_Indicators.iid_constants.CreateFullName(right.title, right.fname, right.mname, right.lname, right.name_suffix);		 
							self.pdid := (unsigned)left.did;
      	self.Party_PersistId := (string) right.persistent_record_id;
       self := right,
					 self := []),
					 ATMOST(keyed (Left.tmsid = Right.tmsid) and keyed (Left.rmsid = Right.rmsid), riskwise.max_atmost));

	party_override := fcra.key_Override_liensv2_party_ffid (keyed (flag_file_id IN lien_correct_ffid));
	party_new := PROJECT (CHOOSEN (party_override(
         (unsigned3) date_first_seen[1..6] < _history_date and 
									(unsigned3) date_first_seen <> 0 and 
         name_type='D'),
								_MAX_OVERRIDE_LIMIT), 
			TRANSFORM (RiskWiseFCRA.layouts.layoutParty, 
							self.ptmsid := left.tmsid;	
							self.prmsid := left.rmsid;
							self.pdate_last_seen :=left.date_last_seen; //at defendant level so take here over at main where it's all defendants
							self.pdate_first_seen := left.date_first_seen;
							self.pname_type := left.name_type;
							//orig_name is not parsed/cleaned...so need to use the cleaned name fields
							self.porig_name := Risk_Indicators.iid_constants.CreateFullName(left.title, left.fname, left.mname, left.lname, left.name_suffix);		 
							self.pdid := (unsigned) left.did;
       self.Party_PersistId := (string) left.persistent_record_id;
							SELF := Left; 
							Self := []));

 //Overrides aren't used when it's in archive mode so remove the override checks when in archive mode
	// all party records known in both_party. use this instead of liens_slim to retrieve main records
	liens_main := JOIN( liens_party, liensv2.key_liens_main_id_FCRA, 
					Left.tmsid<>''
						AND right.orig_filing_date<>''
						AND keyed(Left.ptmsid = Right.tmsid)
						AND keyed (Left.prmsid = Right.rmsid)
						and (unsigned) left.pdate_first_seen = (unsigned) right.orig_filing_date 
						and (unsigned) left.pdate_last_seen = (unsigned) right.release_date  
						and right.filing_type_desc not in Risk_Indicators.iid_constants.setMechanicsLiens
						and right.filing_type_desc not in Risk_Indicators.iid_constants.set_Invalid_Liens_50
						and right.filing_type_desc not in risk_indicators.iid_constants.setSuitsFCRA
						and if(production_realtime_mode, 
          (string50)right.tmsid + (string50)right.rmsid not in lien_correct_tmsid_rmsid, 
          true)
						and if(production_realtime_mode, 
         trim((string)right.persistent_record_id) not in lien_correct_tmsid_rmsid,
         true)
      and if(production_realtime_mode, 
         trim((string)right.persistent_record_id) not in personContext,
         true)
         ,
					transform(RiskWiseFCRA.layouts.layoutMain, 
							SELF.mReleaseDate := (string) left.date_last_seen ;	
							SELF.mProcessDate := right.Process_Date;
							SELF.mFilingnumber := right.Filing_number;
							SELF.mOrigFilingNumber := right.Orig_Filing_Number;
							SELF.mcertificateNumber := right.certificate_number;
							SELF.mirsSerialNumber := right.irs_serial_number;
							SELF.mCaseNumberL := right.Case_number;
							SELF.mFilingbook := right.Filing_book;
							SELF.mFilingPage := right.Filing_page;
						 SELF.mAmount := (string) (integer) right.Amount;		
							self.mDateFiled := (string) left.date_first_seen;
							SELF.mAgencycounty := right.Agency_County;
							SELF.mAgencystate := right.Agency_state;
       SELF.VendorDateLastSeen := right.collection_date;
							self.pdid := left.pdid;
							self.pdate_last_seen := left.pdate_last_seen;
							self.pdate_first_seen := left.pdate_first_seen;
							self.mFtdDec := right.filing_type_desc;
							self.ptmsid := if(right.tmsid='', '', left.tmsid);	
							self.prmsid := if(right.rmsid='', '', left.rmsid);
       self.PersistId := (string) right.persistent_record_id;//gets main persistentid from the right side
							self := right,
							self := [];),
					ATMOST(keyed (Left.ptmsid = Right.tmsid) and 
							keyed (Left.prmsid = Right.rmsid),
							riskwise.max_atmost))(ptmsid != '' or prmsid != ''); //cause if drop records because of
              //override check, we need to clear these values and drop to the floor

 main_override := fcra.key_Override_liensv2_main_ffid (keyed (flag_file_id IN lien_correct_ffid));   

 liens_main_overrides := JOIN(party_new, fcra.key_Override_liensv2_main_ffid,	
      keyed(right.flag_file_id IN lien_correct_ffid) and 
						trim(left.ptmsid)=trim(right.tmsid) and
						trim(left.prmsid)=trim(right.rmsid) and
					 right.filing_type_desc not in Risk_Indicators.iid_constants.setMechanicsLiens and
					 right.filing_type_desc not in Risk_Indicators.iid_constants.set_Invalid_Liens_50 and
      right.filing_type_desc not in risk_indicators.iid_constants.setSuitsFCRA,
					transform(RiskWiseFCRA.layouts.layoutMain, 
							SELF.mReleaseDate := (string) left.date_last_seen ;	
							SELF.mProcessDate := right.Process_Date;
							SELF.mFilingnumber := right.Filing_number;
							SELF.mOrigFilingNumber := right.Orig_Filing_Number;
							SELF.mcertificateNumber := right.certificate_number;
							SELF.mirsSerialNumber := right.irs_serial_number;
							SELF.mCaseNumberL := right.Case_number;
							SELF.mFilingbook := right.Filing_book;
							SELF.mFilingPage := right.Filing_page;
						 SELF.mAmount := (string) (integer) right.Amount;		
							self.mDateFiled := (string) left.date_first_seen;
							SELF.mAgencycounty := right.Agency_County;
							SELF.mAgencystate := right.Agency_state;
							self.pdid := left.pdid;
							self.pdate_last_seen := left.pdate_last_seen;
							self.pdate_first_seen := left.pdate_first_seen;
							self.mFtdDec := right.filing_type_desc;
       SELF.VendorDateLastSeen := right.collection_date;
       self.PersistId := (string) right.persistent_record_id;//gets main persistentid from the right side
							self := left,
							self := right,
							self := [];),
							ATMOST(_MAX_OVERRIDE_LIMIT));
	all_liens := liens_main + if(production_realtime_mode, liens_main_overrides);
	all_liens_filtered := all_liens(filing_type_desc != '');
//this is where we start deduping by the 4 filtering types - first one is tmsid 
 liensTmsidDF := DEDUP(SORT(all_liens_filtered, pdid, tmsid, (integer) mDateFiled), pdid, tmsid);
 
	lienswithNewDF := join(all_liens_filtered, liensTmsidDF,
		left.pdid = right.pdid and left.tmsid = right.tmsid,
		transform(RiskWiseFCRA.layouts.layoutMain,
			self.DF := (string) right.mDateFiled;
			self := left,
			self := []), 
			left outer);	
	//unique TMSID and DF will have oldest date filed
	liensTmsidDF_total := DEDUP(SORT(lienswithNewDF, pdid, tmsid,
		(integer) if((integer) mReleaseDate = 0, 99999999, (integer) mReleaseDate),
		-(integer) mDateFiled, -(integer) mProcessDate), pdid, tmsid);	

	liensWithDesc_DF2 := project(liensTmsidDF_total, 
		transform(RiskWiseFCRA.layouts.layoutMain,
			self.msort2Date := map(
				trim(left.mOrigFilingNumber, left, right) != '' => left.mOrigFilingNumber,
				trim(left.mfilingNumber, left, right) != '' => left.mfilingNumber,
				trim(left.mcertificateNumber, left, right) != '' => left.mcertificateNumber,
				trim(left.mirsSerialNumber, left, right) != '' => left.mirsSerialNumber,
				trim(left.mfilingBook, left, right) != '' and trim(left.mfilingPage, left, right) != ''=> 
							'BK' +trim(left.mfilingBook, left, right) + 'PG'+trim(left.mfilingPage, left, right),
				trim(left.mCaseNumberL, left, right) != '' => left.mCaseNumberL,
				left.tmsid);//default to tmsid over blank
				self := left,
				self := []));
	//least sort for sort2			
	liensSort2DF := DEDUP(SORT(liensWithDesc_DF2, pdid, mAgencystate, mAgencyCounty, 
			msort2Date, (integer) mdatefiled, (integer) DF), 
			pdid, mAgencystate, mAgencyCounty,msort2Date, mdatefiled);
	lienswithNewDF2 := join(liensWithDesc_DF2, liensSort2DF,
		left.pdid = right.pdid and left.mAgencyState = right.mAgencyState and 
		left.mAgencyCounty = right.mAgencyCounty and
		left.msort2Date = right.msort2Date and
		left.mdatefiled = right.mdatefiled,
		transform(RiskWiseFCRA.layouts.layoutMain,
			self.DF2 := (string) right.DF;
			self := left,
			self := []), 
			left outer);	
	//unique Agencystate, AgencyCounty, sort2Date and DF2 will have oldest date filed
	liensTmsidDF2_total := DEDUP(SORT(lienswithNewDF2, pdid, mAgencystate, mAgencyCounty, 
		msort2Date, (integer) if((integer) mReleaseDate = 0, 99999999, (integer) mReleaseDate),
		-(integer) mDateFiled, -(integer) mProcessDate), pdid, mAgencystate, mAgencyCounty, 
		msort2Date);				

	//Just sorting to get the top record with the oldest date filed
	liensSort3DF := DEDUP(SORT(liensTmsidDF2_total, pdid, (integer) mdatefiled, -mamount,
			mAgencystate, mAgencyCounty, (integer) DF2), 
			pdid, mDateFiled, mamount, mAgencystate, mAgencyCounty);
	//any matching records will get updated to have the earliest date filed		
	lienswithNewDF3 := join(liensTmsidDF2_total, liensSort3DF,
			left.pdid = right.pdid and 
			left.mDateFiled = right.mDateFiled and 
			left.mamount = right.mamount and
			left.mAgencyState = right.mAgencyState and 
			left.mAgencyCounty = right.mAgencyCounty,
		transform(RiskWiseFCRA.layouts.layoutMain,
			self.DF3 := (string) right.DF2;
			self := left,
			self := []), 
			left outer);
	//now all matching records have same date filed, so keep record by sort order for output		
	liensTmsidDF3_total := DEDUP(SORT(lienswithNewDF3, pdid,
			(integer) mdatefiled, -mamount,  mAgencystate, mAgencyCounty,
		(integer) if((integer) mReleaseDate = 0, 99999999, (integer) mReleaseDate),
			-(integer) mProcessDate), 
			pdid, mDateFiled, mamount, mAgencystate, mAgencyCounty);
		//Just sorting to get the top record with the oldest date filed		
	liensSort4DF := DEDUP(SORT(liensTmsidDF3_total, pdid, mfilingNumber, 
		mAgencystate, mAgencyCounty, (integer) DF3), 
			pdid, mfilingNumber, mAgencystate, mAgencyCounty);
	//any matching records will get updated to have the earliest date filed		
	lienswithNewDF4 := join(liensTmsidDF3_total, liensSort4DF,
			left.pdid = right.pdid and 
			left.mfilingNumber = right.mfilingNumber and 
			left.mAgencyState = right.mAgencyState and 
			left.mAgencyCounty = right.mAgencyCounty,
		transform(RiskWiseFCRA.layouts.layoutMain,
			self.DF4 := (string) right.DF3;
			self.pdid := left.pdid;
			self := left,
			self := []), 
			left outer);
	//now all matching records have same date filed, so keep record by sort order for output		
	liensTmsidDF4_total := DEDUP(SORT(lienswithNewDF4, pdid,
			mfilingNumber, mAgencystate, mAgencyCounty,
			(integer) if((integer) mReleaseDate = 0, 99999999, (integer) mReleaseDate),
			-(integer) mDateFiled, -(integer) mProcessDate), 
			pdid, mfilingNumber, mAgencystate, mAgencyCounty);	

 /*
liensTmsidDF_Final := JOIN(liensTmsidDF4_total, PcontextStId, 
   (unsigned) left.pdid = (unsigned) Right.UniqueId and
      // Right.DataGroup in [PersonContext.constants.datagroups.LIEN_MAIN, PersonContext.constants.datagroups.LIEN_PARTY] and
       Right.DataGroup in PersonContext.constants.datagroups.LIEN_MAIN   and
      // Right.StatementType in [PersonContext.constants.RecordTypes.CS, PersonContext.constants.RecordTypes.RS] and
      Right.RecIdForStId != '' and 
      (trim(left.PersistId, left, right) = trim(Right.RecIdForStId, left, right) OR
      trim(left.Party_PersistId, left, right) = trim(Right.RecIdForStId, left, right)),
    transform(RiskWiseFCRA.layouts.layoutMain,
        self.pdid := left.pdid;
        self.ConsumerStatementId := (integer) Right.statementid;
        self := left), 
        left outer);
 */
//checks for 7 year filter
	liens_filtered_DF := liensTmsidDF4_total(	ut.fn_date_is_ok(Risk_indicators.iid_constants.myGetDate(_history_date), DF4, 7));

// output(party_new, named('party_new'));
// output(liens_party, named('liens_party'));
// output(liensSort4DF, named('liensSort4DF'));
// output(lienswithNewDF4, named('lienswithNewDF4'));
	// keep only those party records with an associated main record
	//liens_party_o := sort(both_party( tmsid in set(liens_main_o, tmsid)), -date_last_seen, date_First_Seen);
// output(liens_party_o_tmp, named('liens_party_o_tmp'));
// output(liens_filtered_DF,named('liens_filtered_DF'));
// output(flag_file,named('flag_file'));
// ff_L:=flag_file(file_id = FCRA.FILE_ID.LIEN);
// output(ff_L,named('ff_L'));
// output(lien_correct_tmsid_rmsid,named('lien_correct_tmsid_rmsid'));
// output(lien_correct_ffid,named('lien_correct_ffid'));
// output(liens_party,named('liens_partyyy'));
// output(party_override,named('party_override'));
// output(party_new,named('party_new'));	
// output(both_party,named('both_party'));
// output(lienswithNewDF, named('lienswithNewDF'));
// output(liensTmsidDF_total, named('liensTmsidDF_total'));
// output(lienswithNewDF3, named('lienswithNewDF3'));
// output(liensSort4DF, named('liensSort4DF'));
// output(lienswithNewDF4, named('lienswithNewDF4'));
// output(liens_filtered_DF, named('liens_filtered_DF'));
// output(liens_main,named('liens_mainnn'));
// output(main_override,named('main_override'));	
// output(main_new,named('main_new'));	
// output(liens_main_o,named('liens_main_o'));
// output(liens_party_o,named('liens_party_o'));
// output(all_liens, named('all_liens'));
// output(NSS, named('NSS'));
// output(liens_slim, named('liens_slim'));
// output(liens_party, named('liens_party'));
// output(all_liens_filtered, named('all_liens_filtered'));
// output(liensSort3DF, named('liensSort3DF'));
// output(liensTmsidDF2_total, named('liensTmsidDF2_total'));
// output(liensTmsidDF3_total, named('liensTmsidDF3_total'));
// output(liensTmsidDF4_total, named('liensTmsidDF4_total'));
// output(liens_filtered_DF, named('liens_filtered_DF'));
// output(both_party, named('Rboth_party'));
// output(liens_main_overrides, named('Rliens_main_overrides'));
// output(party_new, named('party_new'));
// output(all_liens, named('all_liens'));
// output(main_override, named('main_override'));
// output(liens_main, named('liens_main'));
// output(production_realtime_mode, named('production_realtime_mode'));
// output(_history_date, named('_history_date'));
// output(flag_file, named('flag_file'));
// output(lien_correct_tmsid_rmsid, named('lien_correct_tmsid_rmsid'));
// output(lien_correct_ffid, named('lien_correct_ffid'));
// output(PcontextStId);
liensdata := liens_filtered_DF;

ENDMACRO;