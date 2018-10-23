IMPORT Address, doxie_files, FCRA, NID, FFD, STD, CriminalRecords_BatchService;

EXPORT Raw := MODULE

	export getPIIPunishmentRecords(dataset(CriminalRecords_BatchService.Layouts.lookup_id_pii) in_ofks,
																 boolean isFCRA = false,
																 dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
																 dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
																 integer8 inFFDOptionsMask = 0
			) := function
			
		boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
		boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask) and showConsumerStatements;
		
		ds_flags := flagfile(file_id = FCRA.FILE_ID.PUNISHMENT);
		pun_correct_rec_id := set(ds_flags, record_id);
		punishment_key := doxie_files.Key_Punishment (isFCRA);
							
		recs1 := JOIN(in_ofks, punishment_key, 
									KEYED(LEFT.offender_key = RIGHT.ok)
									and (~isFCRA or (string)right.punishment_persistent_id NOT IN pun_correct_rec_id),
									KEEP(CriminalRecords_BatchService.Constants.MAX_PUNISHMENTS_RECS_PER_OK), 
									ATMOST(CriminalRecords_BatchService.Constants.MAX_PUNISHMENTS_RECS_PER_OK_ATMOST));
	
		raw_rec := record(recordof(recs1))
			FFD.Layouts.CommonRawRecordElements; 
		end;
	
	 recs2 := project(recs1, raw_rec);	
	
		//overrides
		recs_over := join(ds_flags, FCRA.key_override_crim.punishment,
											keyed (left.flag_file_id = right.flag_file_id),
											transform(raw_rec, 
																self.did := (unsigned)left.did,
																self.ok  := right.offender_key,
																self := right,
																self := []), //acctno, matchresult, pt , StatementIds & isDisputed
											keep(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));
											
		recs_override_final := join(recs_over, in_ofks,
																left.offender_key = right.offender_key,
																transform(raw_rec, self := left), keep(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); //we only want to keep the overrides that were in the original search records
		
		recs_fcra := recs2 + recs_override_final;
		
	//---------------------------------------FCRA FFD----------------------------------------------------------------	
	// Remove or mark Disputed punishment & add StatementIDs
		raw_rec xformPunishment ( raw_rec L , FFD.Layouts.PersonContextBatchSlim R ) := transform,
		skip(~ShowDisputedRecords and r.isDisputed) 
			self.StatementIDs := r.StatementIds;
			self.isDisputed :=	r.isDisputed;
			self := L;
		end;
		recs_ds := join(recs_fcra, slim_pc_recs,
											 left.punishment_persistent_id = (unsigned) right.RecID1 and
											 right.acctno = left.acctno and 
											 right.DataGroup = FFD.Constants.DataGroups.PUNISHMENT,
											 xformPunishment(left, right), 
											 left outer,
											 keep(1),
											 limit(0));
		//----------------------------------------------------------------------------------------------------------------										 
		recs := if(isFCRA, recs_ds, recs2);

		return recs;
	end;
	
	export getPIIOffenderRecords(dataset(CriminalRecords_BatchService.Layouts.lookup_id_pii) in_ofks, 
													  boolean isFCRA = false,
													  dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
														dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
														integer8 inFFDOptionsMask = 0) := function 
														
		boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
		boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask) and showConsumerStatements;

		ds_flags := flagfile(file_id = FCRA.FILE_ID.OFFENDERS_PLUS);
		ofk_correct_rec_id := set(ds_flags, record_id);
		offender_key := doxie_files.Key_Offenders_OffenderKey (isFCRA);
		
		// BUG #97804 - Prefered Name and SSN Logic
		CriminalRecords_BatchService.Layouts.batch_pii_int_offender makeOutputOffender(offender_key R) := TRANSFORM
			SELF.pfirst := NID.PreferredFirstNew(TRIM(REGEXREPLACE('\\W', R.fname, ' '), LEFT, RIGHT), true)[1..4];
			SELF := R;
		END;
		recs1 := join(in_ofks,offender_key,
									 keyed(left.offender_key=right.ofk)
									 and (~isFCRA or (string)right.offender_persistent_id NOT IN ofk_correct_rec_id),
									 makeOutputOffender(right),
									 ATMOST(CriminalRecords_BatchService.Constants.MAX_OFFENDER_RECS_PER_OFK)); // Need to keep this below 500 otherwise we risk Memory Limit Exceeded errors on Roxie
		
		//overrides
		recs_over := join(ds_flags, fcra.key_override_crim.offenders_plus,
											keyed (left.flag_file_id = right.flag_file_id),
											transform(right), keep(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));
		recs_override_final := join(recs_over, in_ofks,
																left.offender_key = right.offender_key,
																transform(CriminalRecords_BatchService.Layouts.batch_pii_int_offender,
																					self.did := (string)right.did,
																					self.ofk := left.offender_key,
																					self := left,
																					self := []), //acctno, pfirst 
																keep(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); //we only want to keep the overrides that were in the original search records
		
		recs_fcra := (recs1 + recs_override_final)(FCRA.crim_is_ok((STRING8)STD.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));
		//---------------------------------------FCRA FFD----------------------------------------------------------------	
	  // Remove or mark Disputed punishment & add StatementIDs
		CriminalRecords_BatchService.Layouts.batch_pii_int_offender xformOffender 
							( CriminalRecords_BatchService.Layouts.batch_pii_int_offender L , 
								FFD.Layouts.PersonContextBatchSlim R 	) := transform, 
								skip(~ShowDisputedRecords and r.isDisputed) 
										self.StatementIDs := r.StatementIds;
										self.isDisputed :=	r.isDisputed;
										self := L;
		end;
		recs_ds := join(recs_fcra, slim_pc_recs,
											 left.offender_persistent_id = (unsigned) right.RecID1 and
											 (unsigned) left.did  = (unsigned) right.lexid and 
											 right.DataGroup = FFD.Constants.DataGroups.OFFENDERS_PLUS,
											 xformOffender(left, right), 
											 left outer,
											 keep(1),
											 limit(0));
		//----------------------------------------------------------------------------------------------------------------	
		recs := if(isFCRA, recs_ds, recs1);
	
		return recs;
	end;
	
	export getOffenderRecords(dataset(CriminalRecords_BatchService.Layouts.lookup_id) in_ofks,
														boolean isFCRA = false,
														boolean isCNSMR = false,
														dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
														dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
														integer8 inFFDOptionsMask = 0) := function

		boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
		boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask) and showConsumerStatements;

		ds_flags := flagfile(file_id = FCRA.FILE_ID.OFFENDERS_PLUS);
		ofk_correct_rec_id := set(ds_flags, record_id);
	  Arrest_datatype := ['5'];
		offender_key := doxie_files.Key_Offenders_OffenderKey (isFCRA);

		raw_rec := record(recordof(offender_key))
			CriminalRecords_BatchService.Layouts.batch_in.acctno;	
			FFD.Layouts.CommonRawRecordElements;
		end;
		
		recs1 := join(in_ofks,offender_key,
									 keyed(left.offender_key=right.ofk)
									 and (~isFCRA or (string)right.offender_persistent_id NOT IN ofk_correct_rec_id)
									 and (~isCNSMR or (string)right.data_type not in Arrest_datatype),
									 transform(raw_rec, self.acctno := left.acctno, self := right),
									 KEEP(CriminalRecords_BatchService.Constants.MAX_RECS_PER_OFK), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_PER_OFK_ATMOST));
									 
							 

		//overrides
		recs_over := join(ds_flags, fcra.key_override_crim.offenders_plus,
											keyed (left.flag_file_id = right.flag_file_id),
											transform(right),
											keep(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));
											
		recs_override_final := join(recs_over, in_ofks,
																left.offender_key = right.offender_key,
																transform(raw_rec, 
																					self.acctno := right.acctno,
																					self.ofk := left.offender_key,
																					self := left,
																					self.StatementIDs := [],
																					self.isDisputed :=	false),
																					// self := []),
																keep(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); //we only want to keep the overrides that were in the original search records
		
		recs_fcra := (project(recs1,raw_rec) + recs_override_final)(FCRA.crim_is_ok((STRING8)STD.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));
		
		//---------------------------------------FCRA FFD----------------------------------------------------------------	
	// Remove or mark Disputed punishment & add StatementIDs
		raw_rec xformOffendersPlus ( raw_rec L, FFD.Layouts.PersonContextBatchSlim R ) := transform,
		skip(~ShowDisputedRecords and r.isDisputed) 
			self.StatementIDs := r.StatementIds;
			self.isDisputed :=	r.isDisputed;
			self := L;
		end;
		recs_ds := join(recs_fcra, slim_pc_recs,
											 left.offender_persistent_id = (unsigned) right.RecID1 and
											 left.acctno = right.acctno and 
											 right.DataGroup = FFD.Constants.DataGroups.OFFENDERS_PLUS,
											 xformOffendersPlus(left, right), 
											 left outer,
											 keep(1),
											 limit(0));
		//----------------------------------------------------------------------------------------------------------------										 
		recs2 := if(isFCRA, recs_ds, project(recs1,raw_rec));
		
		recs_dup := dedup(sort(recs2, did, offender_key, -ssn, -lname, -fname, -mname, -prim_range, -predir, -prim_name, -addr_suffix, -postdir, -sec_range, -p_city_name, -st, -zip5),
											did, offender_key);
		
		CriminalRecords_BatchService.Layouts.batch_int makeOutputOffender(CriminalRecords_BatchService.Layouts.lookup_id L, raw_rec R) := TRANSFORM
			// SELF.did := if(L.did <> 0, L.did, (unsigned)R.did); //having this line changes the results as the alias records do not have DID or ssn_appended appended, so they don't get deduped later down the code
			SELF.did := (unsigned)R.did;
			SELF.output_type := 'O';	
			SELF.state_origin := Address.Map_State_Name_To_Abbrev(StringLib.StringToUpperCase(R.orig_state));
			SELF.offender_key := R.ofk;		
			SELF.ssn  := R.ssn_appended;
			SELF.pty_typ := R.pty_typ;
			SELF      := R; 
			SELF      := L; //get acctno, match_type, too_many_code, too_many_flag from input
			offender_statements :=  project(R.StatementIds,FFD.InitializeConsumerStatementBatch
																						(left,
																						 FFD.Constants.RecordType.RS, 
																						 'offender',FFD.Constants.DataGroups.OFFENDERS_PLUS,
																						 0,R.acctno,(unsigned) R.did ));
																						 
																									
			offender_disputes :=  if(R.isDisputed,row( FFD.InitializeConsumerStatementBatch 
																														(	FFD.Constants.BlankStatementid,
																															FFD.Constants.RecordType.DR, 
																															'offender',FFD.Constants.DataGroups.OFFENDERS_PLUS,
																															0,R.acctno,(unsigned) R.did))); 																						

																						 
			SELF.StatementsAndDisputes	:= offender_statements + offender_disputes;																		 
			SELF      := [];
		END;
		recs := join(in_ofks, recs_dup,
								 left.offender_key = right.offender_key,
								 makeOutputOffender(left, right));
								 
									 						 
		return recs;
	end;
	
	export getOffenseRecords(dataset(CriminalRecords_batchService.Layouts.lookup_id) in_ofks,
														boolean isFCRA = false,
														dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
														dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
														integer8 inFFDOptionsMask = 0) := function

		boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
		boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask) and showConsumerStatements;

		ds_flags := flagfile(file_id = FCRA.FILE_ID.OFFENSES);
		ofk_correct_rec_id := set(ds_flags, record_id);
		offenses_key := doxie_files.key_offenses (isFCRA);
		
		recs1 := JOIN(in_ofks,offenses_key, 
								  KEYED(LEFT.offender_key = RIGHT.ok)
									and (~isFCRA or (string)right.offense_persistent_id NOT IN ofk_correct_rec_id),
									transform(CriminalRecords_BatchService.Layouts.batch_int_offenses, self := left, self := right),
								  KEEP(CriminalRecords_BatchService.Constants.MAX_OFFENSES_RECS_PER_OK), ATMOST(CriminalRecords_BatchService.Constants.MAX_OFFENSES_RECS_PER_OK_ATMOST));
									
		//overrides
		recs_over := join(ds_flags, fcra.key_override_crim.offenses,
											keyed (left.flag_file_id = right.flag_file_id),
											transform(right),
											keep(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));
		recs_override_final := join(recs_over, in_ofks,
																left.offender_key = right.offender_key,
																transform(CriminalRecords_BatchService.Layouts.batch_int_offenses, 
																					self := left,
																					self := []),
																keep(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); //we only want to keep the overrides that were in the original search records
		
		recs_fcra := (recs1 + recs_override_final)(FCRA.crim_is_ok((STRING8)STD.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));
		//---------------------------------------FCRA FFD----------------------------------------------------------------	
	// Remove or mark Disputed punishment & add StatementIDs
		CriminalRecords_BatchService.Layouts.batch_int_offenses xformOffense 
		( CriminalRecords_BatchService.Layouts.batch_int_offenses L , 
			FFD.Layouts.PersonContextBatchSlim R ) := transform,
		skip(~ShowDisputedRecords and r.isDisputed) 
			self.StatementIDs := r.StatementIds;
			self.isDisputed :=	r.isDisputed;
			self := L;
		end;
		recs_ds := join(recs_fcra, slim_pc_recs,
											 left.offense_persistent_id = (unsigned) right.RecID1 and
											 left.acctno = right.acctno and 
											 right.DataGroup = FFD.Constants.DataGroups.OFFENSES,
											 xformOffense(left, right), 
											 left outer,
											 keep(1),
											 limit(0));
		//----------------------------------------------------------------------------------------------------------------										 
		recs := if(isFCRA, recs_ds, recs1);
		
		recs_grp  := GROUP(DEDUP(SORT(recs
															,acctno, did,offender_key,-off_date,-arr_date,case_num,
															off_desc_1, arr_disp_desc_1,
                              process_date)
												 ,acctno, did,offender_key,off_date,arr_date,case_num,
												 off_desc_1, arr_disp_desc_1,
                         process_date)
										,acctno, did,offender_key);
											
		recs_final :=  ROLLUP(recs_grp,group,CriminalRecords_BatchService.Transforms.makeOutputOffenses(LEFT,ROWS(LEFT)));		
		
		RETURN recs_final;
	end;
	
	export getCourtOffenseRecords(dataset(CriminalRecords_batchService.Layouts.lookup_id) in_ofks,
																boolean isFCRA = false,
																dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
																dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
																integer8 inFFDOptionsMask = 0) := function

		boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
		boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask) and showConsumerStatements;

		ds_flags := flagfile(file_id = FCRA.FILE_ID.COURT_OFFENSES);
		off_correct_rec_id := set(ds_flags, record_id);
		court_offense_key := doxie_files.Key_Court_Offenses(isFCRA);
		
		recs1 := JOIN(in_ofks, court_offense_key, 
									KEYED(LEFT.offender_key = RIGHT.ofk)
									and (~isFCRA or (string)right.offense_persistent_id NOT IN off_correct_rec_id),
									transform(CriminalRecords_BatchService.Layouts.batch_int_court_offense, self := left, self := right),
									KEEP(CriminalRecords_BatchService.Constants.MAX_COURT_OFFENSE_RECS_PER_OK), ATMOST(CriminalRecords_BatchService.Constants.MAX_COURT_OFFENSE_RECS_PER_OK_ATMOST));
		
		//overrides
		recs_over := join(ds_flags, FCRA.key_override_crim.court_offenses,
											keyed (left.flag_file_id = right.flag_file_id),
											transform(right),
											keep(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));
		recs_override_final := join(recs_over, in_ofks,
																left.offender_key = right.offender_key,
																transform(CriminalRecords_BatchService.Layouts.batch_int_court_offense, 
																					self := left,
																					self := []),
																keep(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); //we only want to keep the overrides that were in the original search records
		
		recs_fcra := (recs1 + recs_override_final)(FCRA.crim_is_ok((STRING8)STD.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));
		//---------------------------------------FCRA FFD----------------------------------------------------------------	
	// Remove or mark Disputed punishment & add StatementIDs
		CriminalRecords_BatchService.Layouts.batch_int_court_offense xformOffense 
		( CriminalRecords_BatchService.Layouts.batch_int_court_offense L , 
		  FFD.Layouts.PersonContextBatchSlim R 
		) := transform,
		skip(~ShowDisputedRecords and r.isDisputed) 
			self.StatementIDs := r.StatementIds;
			self.isDisputed :=	r.isDisputed;
			self := L;
		end;
		recs_ds := join(recs_fcra, slim_pc_recs,
											 left.offense_persistent_id = (unsigned) right.RecID1 and
											 left.acctno = right.acctno and 
											 right.DataGroup = FFD.Constants.DataGroups.COURT_OFFENSES,
											 xformOffense(left, right), 
											 left outer,
											 keep(1),
											 limit(0));
		//----------------------------------------------------------------------------------------------------------------		
		recs := if(isFCRA, recs_ds, recs1);
		
		recs_grp := GROUP(DEDUP(SORT(recs,
																 acctno, did, offender_key, -off_date, -arr_date, court_case_number, 
																 court_off_desc_1, arr_off_desc_1,sent_jail,court_disp_desc_1,
																 court_statute, process_date),
													 acctno, did, offender_key, off_date, arr_date, court_case_number, 
													 court_off_desc_1, arr_off_desc_1,sent_jail,court_disp_desc_1,
													 court_statute, process_date),
										 acctno, //this is currently missing, but shouldn't it be here???
										 // see similar coding above in getOffensesRecords GROUP(DEDUP(SORT(...
										 // plus acctno was the first field in the dedup & sort portions???
										 did,offender_key);										 
											 
		recs_final :=  ROLLUP(recs_grp,GROUP,CriminalRecords_BatchService.Transforms.makeCourtOffenseOutput(LEFT,ROWS(LEFT)));	

		RETURN recs_final;
	end;
	
	export getPunishmentRecords(dataset(CriminalRecords_batchService.Layouts.lookup_id) in_ofks,
															boolean isFCRA = false,
															dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
															dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
															integer8 inFFDOptionsMask = 0) := function

		boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
		boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask) and showConsumerStatements;

		ds_flags := flagfile(file_id = FCRA.FILE_ID.PUNISHMENT);
		pun_correct_rec_id := set(ds_flags, record_id);
		punishment_key := doxie_files.key_punishment(isFCRA);
		
		recs1 := JOIN(in_ofks,punishment_key,
									KEYED(LEFT.offender_key = RIGHT.ok)
									and (~isFCRA or (string)right.punishment_persistent_id NOT IN pun_correct_rec_id),
									transform(CriminalRecords_BatchService.Layouts.batch_int_punishment, self := left, self := right),
									KEEP(CriminalRecords_BatchService.Constants.MAX_PUNISHMENTS_RECS_PER_OK), ATMOST(CriminalRecords_BatchService.Constants.MAX_PUNISHMENTS_RECS_PER_OK_ATMOST));
		
		//overrides
		recs_over := join(ds_flags, FCRA.key_override_crim.punishment,
											keyed (left.flag_file_id = right.flag_file_id),
											transform(right), keep(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST));
		recs_override_final := join(recs_over, in_ofks,
																left.offender_key = right.offender_key,
																transform(CriminalRecords_BatchService.Layouts.batch_int_punishment,
																					self.acctno := right.acctno,
																					self.did := right.did,
																					self.ok := right.offender_key,
																					self := left,
																					self.pt := ''), 
																keep(1), ATMOST(CriminalRecords_BatchService.Constants.MAX_RECS_DEFAULT_ATMOST)); //we only want to keep the overrides that were in the original search records
		
		recs_fcra := (recs1 + recs_override_final); //TODO: find out what to do for punishment FCRA restrictions
		//---------------------------------------FCRA FFD----------------------------------------------------------------	
	// Remove or mark Disputed punishment & add StatementIDs
		CriminalRecords_BatchService.Layouts.batch_int_punishment xformPunishment 
		( CriminalRecords_BatchService.Layouts.batch_int_punishment L , 
			FFD.Layouts.PersonContextBatchSlim R 
		) := transform,
		skip(~ShowDisputedRecords and r.isDisputed) 
			self.StatementIDs := r.StatementIds;
			self.isDisputed :=	r.isDisputed;
			self := L;
		end;
		recs_ds := join(recs_fcra, slim_pc_recs,
											 left.punishment_persistent_id = (unsigned) right.RecID1 and
											 left.acctno = right.acctno and 
											 right.DataGroup = FFD.Constants.DataGroups.PUNISHMENT,
											 xformPunishment(left, right), 
											 left outer,
											 keep(1),
											 limit(0));
		//----------------------------------------------------------------------------------------------------------------		
		recs := if(isFCRA, recs_ds, recs1);
		
		recs_dup  := DEDUP(SORT(recs
											,acctno,did,offender_key,punishment_type,-event_dt,sent_length
											,cur_stat_inm,cur_loc_inm,cur_loc_sec,latest_adm_dt,act_rel_dt,ctl_rel_dt)
									,acctno,did,offender_key,punishment_type ,event_dt,sent_length
									,cur_stat_inm,cur_loc_inm,cur_loc_sec,latest_adm_dt,act_rel_dt,ctl_rel_dt);

		recs_grp  := GROUP(SORT(recs_dup
												,did,offender_key,punishment_type,-event_dt,-latest_adm_dt)
												,did,offender_key) ;		
																
		recs_final :=  ROLLUP(recs_grp,group,CriminalRecords_BatchService.Transforms.makePunishmentOutput(LEFT,ROWS(LEFT)));
		
		return recs_final;
	end;
END;