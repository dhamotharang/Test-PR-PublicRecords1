IMPORT CriminalRecords_Services, Autokey_batch, Address, doxie, FFD;

Layout_PII_In := CriminalRecords_BatchService.Layouts.batch_pii_in;
Layout_PII_Out := CriminalRecords_BatchService.Layouts.batch_pii_out;


EXPORT Possible_Incarceration_Indicator_Batch_Service_Records(CriminalRecords_BatchService.IParam.batch_params configData,
																															dataset(Layout_PII_In) ds_batch_in, 
																															boolean isFCRA = false) := FUNCTION

	//perform address cleaning here since the full address field might come from stAddr (old field used)
	Autokey_batch.Layouts.rec_inBatchMaster xformCommonBatchLayout(Layout_PII_In L) := transform
		addr1 := if(L.addr <> '', L.addr, L.stAddr);	
		city_in :=  if(L.p_city_name <> '', L.p_city_name, L.city);
		state_in := if(L.st <> '', L. st, IF(LENGTH(TRIM(L.state, LEFT, RIGHT)) > 2, Address.Map_State_Name_To_Abbrev(L.state), L.state));
		zip_in := TRIM(L.zip, LEFT, RIGHT);
		z5 := if(L.z5 <> '', L.z5, REGEXFIND(Constants.ZIP_PATTERN, zip_in, 1));
		z4 := if(L.zip4 <> '', L.zip4, REGEXFIND(Constants.ZIP_PATTERN, zip_in, 3));
		addr2 := city_in + ', ' + state_in + ' ' + zip_in;
		tmp := Address.GetCleanAddress(addr1, addr2, Address.Components.Country.US).results;
		SELF.prim_range := tmp.prim_range;
		SELF.predir := tmp.predir;
		SELF.prim_name := tmp.prim_name;
		SELF.addr_suffix := tmp.suffix;
		SELF.postdir := tmp.postdir;
		SELF.unit_desig := tmp.unit_desig;
		SELF.sec_range := tmp.sec_range;
		SELF.p_city_name := city_in;
		SELF.st := state_in;
		SELF.z5 := z5;
		SELF.zip4 := z4;
		SELF.ssn := REGEXREPLACE(Constants.NOT_NUMBER, L.ssn, Constants.BLNK);
		SELF.dob := (STRING8) IF((unsigned)L.dob > 0, INTFORMAT((unsigned)L.dob, 8, 1), Constants.BLNK);
		SELF := L;
	end;
	ds_batch_in_common 	:= project(ds_batch_in, xformCommonBatchLayout(left));		
	
	// Search via AutoKey
	fromAK := CriminalRecords_BatchService.batchIds.PII_Ids(configData).AutokeyIds(ds_batch_in_common);
	
	notFoundAccts := JOIN(ds_batch_in_common, fromAK, LEFT.acctno = RIGHT.acctno, TRANSFORM(LEFT), LEFT ONLY);
	fromDID := CriminalRecords_BatchService.BatchIds.PII_Ids(configData).IdsPIIByDID(if(isFCRA, ds_batch_in_common, notFoundAccts), isFCRA);
	
	// Find out possible incarcerations
	// if isFCRA skip autokey search
	acctNos := if(isFCRA, fromDID, fromAK + fromDID);
	acctNos_final := DEDUP(SORT(acctNos, acctno, did, offender_key), acctno, did, offender_key);
	
	// overrides for FCRA
	ds_best  := project(ds_batch_in(did <> 0),transform(doxie.layout_best,self.did:=left.did, self:=[])); //using input to create dataset for getting the flag file (overrides). For FCRA we only use DID to get overrides.
	
	//FCRA FFD  
	dids := project(ds_batch_in(did <> 0),FFD.Layouts.DidBatch); 
	data_groups := [
		// FFD.Constants.DataGroups.OFFENDERS  is a DID search key not really a payload key so not needed
		FFD.Constants.DataGroups.OFFENDERS_PLUS,  
		FFD.Constants.DataGroups.PUNISHMENT,  
		FFD.Constants.DataGroups.PERSON
		];
	pc_recs := if(isFCRA, FFD.FetchPersonContext(dids, configData.gateways, data_groups, configData.FFDOptionsMask));																								 
	slim_pc_recs := FFD.SlimPersonContext(pc_recs);
			
	ds_flags := if(isFCRA, FFD.GetFlagFile (ds_best, pc_recs)); //this is for more than one person

	alert_flags := if(isFCRA, FFD.ConsumerFlag.getAlertIndicators(pc_recs, configData.FCRAPurpose, configData.FFDOptionsMask));

	// Fetch all punishment records and set incarceration flags accordingly.
	Layout_PII_Temp := RECORD
		 CriminalRecords_BatchService.Layouts.batch_pii_out_pre;
		CriminalRecords_BatchService.Layouts.lookup_id_pii.offender_key;
		UNSIGNED6	did;
	END;
	
	punishment_rec := CriminalRecords_BatchService.Raw.getPIIPunishmentRecords(acctNos_final, isFCRA, ds_flags, slim_pc_recs, configData.FFDOptionsMask);
	
	Layout_PII_Temp makeOutputPunishment(punishment_rec l) := TRANSFORM
		matchStr := IF(l.matchResult & Constants.V_MATCH_INTERNAL <> 0, Constants.STR_MATCH_INTERNAL, Constants.BLNK) +
								IF(l.matchResult & Constants.V_MATCH_NAME <> 0, Constants.STR_MATCH_NAME, Constants.BLNK) +
								IF(l.matchResult & Constants.V_MATCH_ADDR <> 0, Constants.STR_MATCH_ADDR, Constants.BLNK) +
								IF(l.matchResult & Constants.V_MATCH_CITY <> 0, Constants.STR_MATCH_CITY, Constants.BLNK) +
								IF(l.matchResult & Constants.V_MATCH_STATE <> 0, Constants.STR_MATCH_STATE, Constants.BLNK) +
								IF(l.matchResult & Constants.V_MATCH_ZIP <> 0, Constants.STR_MATCH_ZIP, Constants.BLNK) +
								IF(l.matchResult & Constants.V_MATCH_SSN <> 0, Constants.STR_MATCH_SSN, Constants.BLNK) +
								IF(l.matchResult & Constants.V_MATCH_DOB <> 0, Constants.STR_MATCH_DOB, Constants.BLNK);
		SELF.match_type := matchStr;
		punishment_disputes := if(L.isDisputed,row(FFD.InitializeConsumerStatementBatch(
																									FFD.Constants.BlankStatementid,
																									FFD.Constants.RecordType.DR,
																									'',
																									FFD.Constants.DataGroups.PUNISHMENT,
																									0,'',
																									L.did)));
		punishment_statements :=  PROJECT (L.StatementIds,FFD.InitializeConsumerStatementBatch( 
																									left, 
																									FFD.Constants.RecordType.RS, 
																									'',
																									FFD.Constants.DataGroups.PUNISHMENT,
																									0,'',
																									L.did )); 
		SELF.StatementsAndDisputes := punishment_disputes + punishment_statements;																							
		SELF := l;
		SELF := [];
	END;
	punishments := project(punishment_rec, makeOutputPunishment(left));//JOIN(acctNos_final, keyPunishment, KEYED(LEFT.offender_key = RIGHT.ok), makeOutputPunishment(left, right));	
	CriminalRecords_Services.MAC_Incarceration_Filter(punishments, punishments_flagged, true, true, true);	
	punishments_inc := punishments_flagged(Incarceration_Flag='1');
	
	// BUG #97804 - Return Name and SSN
	Layout_PII_OffenderPNameSSN := CriminalRecords_batchService.Layouts.batch_pii_int_offender;

	// BUG #97804 - Return Name and SSN
	BOOLEAN is_Return_SSN := FALSE : STORED('Return_SSN');
	BOOLEAN is_Return_DOC_Name := FALSE : STORED('Return_DOC_Name');
	UNSIGNED1 KeepN := if(is_Return_DOC_Name, 10, 1);
	
	 CriminalRecords_BatchService.Layouts.batch_pii_out_pre makeOutputOffender(Layout_PII_Temp l, Layout_PII_OffenderPNameSSN r) := TRANSFORM
		SELF.INCR_doc_num := r.doc_num;
		SELF.INCR_state_origin := r.orig_state;
		SELF.INCR_dob := r.dob;
		SELF.INCR_did := r.did;
		SELF.INCR_ssn := if(is_Return_SSN,if(r.ssn = '', r.ssn_appended, r.ssn),'');
		SELF.INCR_fname := if(is_Return_DOC_Name,r.fname,'');
		SELF.INCR_lname := if(is_Return_DOC_Name,r.lname,'');
																													
		offender_disputes := if(R.isDisputed,row(FFD.InitializeConsumerStatementBatch(
																									FFD.Constants.BlankStatementid,
																									FFD.Constants.RecordType.DR,
																									'incr',
																									FFD.Constants.DataGroups.OFFENDERS_PLUS,
																									0,'',
																									(unsigned)R.did)));
		offender_statements := PROJECT(R.StatementIds,FFD.InitializeConsumerStatementBatch( 
																									left, 
																									FFD.Constants.RecordType.RS, 
																									'incr',
																									FFD.Constants.DataGroups.OFFENDERS_PLUS,
																									0,'',
																									(unsigned)R.did )); 																											
																											
		SELF.StatementsAndDisputes := offender_disputes + offender_statements + L.StatementsAndDisputes;
		SELF := l;
	END;

	// BUG #97804 - Prefered Name and SSN Logic
	Layout_PII_OffenderPNameSSN rollOutputOffenderPNameSSN(Layout_PII_OffenderPNameSSN L, Layout_PII_OffenderPNameSSN R) := TRANSFORM
		SELF.ssn := if(L.ssn = '',R.ssn,L.ssn);
		SELF.ssn_appended := if(L.ssn_appended = '',R.ssn_appended,L.ssn_appended);
		SELF.did := if(L.did = '',R.did,L.did);
		use_L := L.ssn <> '' OR L.ssn_appended <> '';
		SELF.isDisputed := R.isDisputed OR (use_L  and L.isDisputed);
		SELF.StatementIds := R.StatementIds + if(use_L,L.StatementIds);
		SELF := R;
	END;
																								 
	// BUG #97804 - Prefered Name and SSN Rollup Logic
	fn_OffenderPNameSSN_Rollup(dataset(Layout_PII_OffenderPNameSSN) in_ds) := FUNCTION
		out_ds := rollup(in_ds, 
										 LEFT.ofk = RIGHT.ofk 
										 and (LEFT.lname = RIGHT.lname or (trim(LEFT.lname) != '' and StringLib.StringFind(trim(RIGHT.lname),trim(LEFT.lname),1) > 0))
										 and (LEFT.pfirst = RIGHT.pfirst
													or (length(trim(LEFT.pfirst)) = 1
											 	      and LEFT.pfirst[1] = RIGHT.pfirst[1])),
										 rollOutputOffenderPNameSSN(LEFT,RIGHT));
		RETURN out_ds;
	END;
	// Send 
	OffenderPNameSSN_Temp := CriminalRecords_BatchService.Raw.getPIIOffenderRecords(acctNos_final, isFCRA, ds_flags, slim_pc_recs, configData.FFDOptionsMask);
	OffenderPNameSSN_Rollup_LName := fn_OffenderPNameSSN_Rollup(sort(OffenderPNameSSN_Temp, ofk, lname, pfirst, ssn, ssn_appended));
	OffenderPNameSSN_Rollup_FName := fn_OffenderPNameSSN_Rollup(sort(OffenderPNameSSN_Rollup_LName, ofk, pfirst, lname, ssn, ssn_appended));
	OffenderPNameSSN := sort(project(OffenderPNameSSN_Rollup_FName, recordof(OffenderPNameSSN_Temp)), ofk, -process_date, -ssn, -ssn_appended);
	
	// Change for RR-12139
	
	rslt_tmp := if(is_Return_DOC_Name or is_Return_SSN,
								JOIN(punishments_inc, OffenderPNameSSN, LEFT.offender_key = RIGHT.ofk, makeOutputOffender(LEFT, RIGHT), KEEP(KeepN), LIMIT(0)),
								JOIN(punishments_inc, OffenderPNameSSN_Temp, LEFT.offender_key = RIGHT.ofk, makeOutputOffender(LEFT, RIGHT), KEEP(1), LIMIT(0)));
								
	rslt_grp := group(sort(rslt_tmp,except match_type),except match_type);
	rslt_ungrp := ungroup(dedup(rslt_grp, 
															trim(RIGHT.match_type) != '' and StringLib.StringContains(trim(LEFT.match_type), trim(RIGHT.match_type), true),
															ALL));
	rslt_srt := sort(rslt_ungrp,acctno,Incarceration_Flag,INCR_state_origin,INCR_doc_num,INCR_dob,event_dt,punishment_type,sent_length,sent_length_desc,cur_stat_inm,cur_stat_inm_desc,cur_loc_inm,cur_sec_class_dt,cur_loc_sec,gain_time,gain_time_eff_dt,latest_adm_dt,sch_rel_dt,act_rel_dt,ctl_rel_dt,presump_par_rel_dt,match_type,-INCR_ssn,INCR_fname,INCR_lname);
															
  //FFD 
  ds_flat_with_alerts := FFD.Mac.ApplyConsumerAlertsBatch(rslt_srt, alert_flags, StatementsAndDisputes, CriminalRecords_BatchService.Layouts.batch_pii_out_pre, configData.FFDOptionsMask);
	            
	// add resolved LexId to the results for inquiry history logging support                    
  ds_flat_with_inquiry := FFD.Mac.InquiryLexidBatch(ds_batch_in, ds_flat_with_alerts, CriminalRecords_BatchService.Layouts.batch_pii_out_pre, 0);

  rslt := if(isFCRA, ds_flat_with_inquiry, rslt_srt);

	sequenced_out := PROJECT(rslt, TRANSFORM(CriminalRecords_BatchService.Layouts.batch_pii_out_pre, SELF.SequenceNumber := COUNTER, SELF := LEFT));
	out := project(sequenced_out,CriminalRecords_BatchService.Layouts.batch_pii_out);
	
	consumer_statements := NORMALIZE(sequenced_out, LEFT.StatementsAndDisputes, 
	  TRANSFORM(FFD.Layouts.ConsumerStatementBatch, 
		  SELF.Acctno := left.Acctno,
			SELF.SequenceNumber := left.SequenceNumber,
			SELF := RIGHT));
													 
	consumer_statements_prep := IF(isFCRA, FFD.prepareConsumerStatementsBatch(consumer_statements, pc_recs, configData.FFDOptionsMask));	
 consumer_alerts  := IF(isFCRA, FFD.ConsumerFlag.prepareAlertMessagesBatch(pc_recs, alert_flags, configData.FFDOptionsMask));                                               
 consumer_statements_alerts := consumer_statements_prep + consumer_alerts;

	FFD.MAC.PrepareResultRecordBatch(out, record_out, consumer_statements_alerts, CriminalRecords_BatchService.Layouts.batch_pii_out);	
	
	return record_out;	

END;
