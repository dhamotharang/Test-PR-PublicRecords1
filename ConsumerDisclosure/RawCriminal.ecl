IMPORT ConsumerDisclosure, doxie, FCRA, FFD, Suppress, Corrections, doxie_files, STD;

	BOOLEAN IsFCRA := TRUE;
	
	offender_raw := RECORD  // recordof(doxie_files.Key_Offenders(true))
		Corrections.layout_offender;
	END; 
	
	offenderplus_raw := RECORD  // recordof(doxie_files.Key_Offenders_OffenderKey(true))
		corrections.layout_Offender;
	END; 
	
	offense_raw := RECORD  // recordof(doxie_files.Key_Offenses(true))
		corrections.layout_offense_common;
	END; 
	
	punishment_raw := RECORD  // recordof(doxie_files.Key_Punishment(true))
		corrections.Layout_CrimPunishment;
	END; 
	
	activity_raw := RECORD  // recordof(doxie_files.key_activity (true))
		corrections.layout_activity;
	END; 
	
	court_offense_raw := RECORD  // recordof(doxie_files.key_court_offenses(true))
		corrections.Layout_CourtOffenses;
	END; 
	
	court_offense_rawrec := RECORD(court_offense_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	activity_rawrec := RECORD(activity_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	punishment_rawrec := RECORD(punishment_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	offense_rawrec := RECORD(offense_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	offender_rawrec := RECORD(offender_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;

	ofk_rec := RECORD
		STRING offender_key;
		UNSIGNED6 subject_did := 0;
	END;

EXPORT RawCriminal := MODULE

/*
fcra.key_override_crim.offenders
fcra.key_override_crim.offenses
fcra.key_override_crim.punishment
fcra.key_override_crim.offenders_plus
fcra.key_override_crim.court_offenses
fcra.key_override_crim.activity
*/

	EXPORT court_offense_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		court_offense_raw;
	END;
	
	EXPORT activity_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		activity_raw;
	END;
	
	EXPORT punishment_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		punishment_raw;
	END;
	
	EXPORT offense_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		offense_raw;
	END;
	
	EXPORT offender_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		offender_raw;
	END;
	
	EXPORT criminal_rec_out := RECORD
		string offender_key;
		DATASET(offender_out) Offenders;
		DATASET(offender_out) OffenderPlus;
		DATASET(offense_out)  Offenses;
		DATASET(activity_out) Activities;
		DATASET(court_offense_out) CourtOffenses;
		DATASET(punishment_out) Punishments;
	END;
	
	EXPORT GetData(
		DATASET(doxie.layout_references) in_dids,
		DATASET (fcra.Layout_override_flag) flag_file,
		DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,														 
		ConsumerDisclosure.IParams.IParam in_mod) := 
  FUNCTION

		BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
		todaysdate := (STRING8) STD.Date.Today();
		
		//-----OFFENDERS------------------
		offenders_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.OFFENDERS);
		offenders_all_flags := flag_file(file_id = FCRA.FILE_ID.OFFENDERS);
		
		offenders_flag_recs := 
			JOIN(offenders_all_flags, FCRA.key_override_crim.offenders, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(offender_rawrec,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := (STRING) RIGHT.offender_key;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		offenders_override_recs := offenders_flag_recs(compliance_flags.isOverride);	
		offenders_suppressed_recs := offenders_flag_recs(compliance_flags.isSuppressed);		

		offenders_override_ids := SET(offenders_override_recs, combined_record_id);	
		offenders_suppressed_ids := SET(offenders_suppressed_recs, combined_record_id);

		offenders_main_recs := JOIN(in_dids, doxie_files.Key_Offenders(isFCRA),
			KEYED(LEFT.did = RIGHT.sdid) AND
			FCRA.crim_is_ok (todaysdate, RIGHT.fcra_date, RIGHT.fcra_conviction_flag, RIGHT.fcra_traffic_flag),
			TRANSFORM(offender_rawrec,
				SELF.compliance_flags.IsOverwritten := (RIGHT.offender_key<>'' AND RIGHT.offender_key IN offenders_override_ids);
				SELF.compliance_flags.IsSuppressed := (RIGHT.offender_key<>'' AND RIGHT.offender_key IN offenders_suppressed_ids);
				SELF.subject_did := LEFT.did;
				SELF.record_ids.RecId1 := (STRING) RIGHT.offender_key;
				SELF := RIGHT;
				SELF := LEFT;
				SELF := []), // recid2, recid3, recid4
			LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxCrimOffendersPerDID));
																	
		offenders_recs_all := offenders_main_recs + offenders_override_recs;
		
		offender_recs_filt := offenders_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
			FCRA.crim_is_ok (todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag)
			);
											
		offender_rawrec xformOffenderStatements(offender_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_IDs := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
				
		offender_recs_with_pc := JOIN(offender_recs_filt, offenders_pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.offender_key = RIGHT.RecID1,
													xformOffenderStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
		
		offender_recs_out := PROJECT(offender_recs_with_pc,
																	TRANSFORM(offender_out,
																		SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(
																											LEFT.compliance_flags, 
																											LEFT.record_ids, 
																											LEFT.statement_IDs, 
																											LEFT.subject_did, 
																											FFD.Constants.DataGroups.OFFENDERS),
																		SELF := LEFT));

		id_recs := DEDUP(PROJECT(offender_recs_with_pc,ofk_rec),ALL);

  // -------------  OFFENSES  -------------

		offense_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.OFFENSES);
		offense_all_flags := flag_file(file_id = FCRA.FILE_ID.OFFENSES);
		
		offense_flag_recs := 
			JOIN(offense_all_flags, FCRA.key_override_crim.offenses, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(offense_rawrec,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := (STRING) RIGHT.offense_persistent_id;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		offense_override_recs := offense_flag_recs(compliance_flags.isOverride);	
		offense_suppressed_recs := offense_flag_recs(compliance_flags.isSuppressed);		

		offense_override_ids := SET(offense_override_recs, combined_record_id);	
		offense_suppressed_ids := SET(offense_suppressed_recs, combined_record_id);

		offense_main_recs := JOIN(id_recs, doxie_files.Key_Offenses(isFCRA),
			KEYED(LEFT.offender_key = RIGHT.ok),
			TRANSFORM(offense_rawrec,
				SELF.compliance_flags.IsOverwritten := (RIGHT.offense_persistent_id<>0 AND (STRING) RIGHT.offense_persistent_id IN offense_override_ids);
				SELF.compliance_flags.IsSuppressed := (RIGHT.offense_persistent_id<>0 AND (STRING) RIGHT.offense_persistent_id IN offense_suppressed_ids)
																							OR (RIGHT.offender_key IN offenders_suppressed_ids);
				SELF.subject_did := LEFT.subject_did;
				SELF.record_ids.RecId1 := (STRING) RIGHT.offense_persistent_id;
				SELF := RIGHT;
				SELF := LEFT;
				SELF := []), // recid2, recid3, recid4
			LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxCrimOffenses));
																	
		offense_recs_all := offense_main_recs + offense_override_recs;
		
		offense_recs_filt := offense_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
			FCRA.crim_is_ok (todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag)
			);

		offense_rawrec xformOffenseStatements(offense_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_IDs := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
				
		offense_recs_final_ds := JOIN(offense_recs_filt, offense_pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.offense_persistent_id = (UNSIGNED) RIGHT.RecID1,
													xformOffenseStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
		
		offense_recs_out := PROJECT(offense_recs_final_ds, 
																	TRANSFORM(offense_out,
																		SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(
																											LEFT.compliance_flags, 
																											LEFT.record_ids, 
																											LEFT.statement_IDs, 
																											LEFT.subject_did, 
																											FFD.Constants.DataGroups.OFFENSES),
																		SELF := LEFT));

	// -------- PUNISHMENT ---------

		punishment_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.PUNISHMENT);
		punishment_all_flags := flag_file(file_id = FCRA.FILE_ID.PUNISHMENT);
		
		punishment_flag_recs := 
			JOIN(punishment_all_flags, FCRA.key_override_crim.punishment, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(punishment_rawrec,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := (STRING) RIGHT.punishment_persistent_id;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		punishment_override_recs := punishment_flag_recs(compliance_flags.isOverride);	
		punishment_suppressed_recs := punishment_flag_recs(compliance_flags.isSuppressed);		

		punishment_override_ids := SET(punishment_override_recs, combined_record_id);	
		punishment_suppressed_ids := SET(punishment_suppressed_recs, combined_record_id);

		punishment_main_recs := JOIN(id_recs, doxie_files.Key_Punishment(isFCRA),
			KEYED(LEFT.offender_key = RIGHT.ok),
			TRANSFORM(punishment_rawrec,
				SELF.compliance_flags.IsOverwritten := (RIGHT.punishment_persistent_id<>0 AND (STRING) RIGHT.punishment_persistent_id IN punishment_override_ids);
				SELF.compliance_flags.IsSuppressed := (RIGHT.punishment_persistent_id<>0 AND (STRING) RIGHT.punishment_persistent_id IN punishment_suppressed_ids)
																							OR (RIGHT.offender_key IN offenders_suppressed_ids);
				SELF.subject_did := LEFT.subject_did;
				SELF.record_ids.RecId1 := (STRING) RIGHT.punishment_persistent_id;
				SELF := RIGHT;
				SELF := LEFT;
				SELF := []), // recid2, recid3, recid4
			LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxCrimPunishments));
																	
		punishment_recs_all := punishment_main_recs + punishment_override_recs;
		
		punishment_recs_filt := punishment_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed 
			);
											
		punishment_rawrec xformPunishmentStatements(punishment_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_IDs := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
				
		punishment_recs_final_ds := JOIN(punishment_recs_filt, punishment_pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.punishment_persistent_id = (UNSIGNED) RIGHT.RecID1,
													xformPunishmentStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
		
		punishment_recs_out := PROJECT(punishment_recs_final_ds, 
																	TRANSFORM(punishment_out,
																		SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(
																											LEFT.compliance_flags, 
																											LEFT.record_ids, 
																											LEFT.statement_IDs, 
																											LEFT.subject_did, 
																											FFD.Constants.DataGroups.PUNISHMENT),
																		SELF := LEFT));			

  // -------------  COURT_OFFENSES  -------------

		court_offenses_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.COURT_OFFENSES);
		court_offenses_all_flags := flag_file(file_id = FCRA.FILE_ID.COURT_OFFENSES);
		
		court_offenses_flag_recs := 
			JOIN(court_offenses_all_flags, FCRA.key_override_crim.court_offenses, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(court_offense_rawrec,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := (STRING) RIGHT.offense_persistent_id;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		court_offenses_override_recs := court_offenses_flag_recs(compliance_flags.isOverride);	
		court_offenses_suppressed_recs := court_offenses_flag_recs(compliance_flags.isSuppressed);		

		court_offenses_override_ids := SET(court_offenses_override_recs, combined_record_id);	
		court_offenses_suppressed_ids := SET(court_offenses_suppressed_recs, combined_record_id);

		court_offenses_main_recs := JOIN(id_recs, doxie_files.key_court_offenses(isFCRA),
			KEYED(LEFT.offender_key = RIGHT.ofk),
			TRANSFORM(court_offense_rawrec,
				SELF.compliance_flags.IsOverwritten := (RIGHT.offense_persistent_id<>0 AND (STRING) RIGHT.offense_persistent_id IN court_offenses_override_ids);
				SELF.compliance_flags.IsSuppressed := (RIGHT.offense_persistent_id<>0 AND (STRING) RIGHT.offense_persistent_id IN court_offenses_suppressed_ids)
																							OR (RIGHT.offender_key IN offenders_suppressed_ids);
				SELF.subject_did := LEFT.subject_did;
				SELF.record_ids.RecId1 := (STRING) RIGHT.offense_persistent_id;
				SELF := RIGHT;
				SELF := LEFT;
				SELF := []), // recid2, recid3, recid4
			LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxCrimCourtOffenses));
																	
		court_offenses_recs_all := court_offenses_main_recs + court_offenses_override_recs;
		
		court_offenses_recs_filt := court_offenses_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
			FCRA.crim_is_ok (todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag)
			);
											
		court_offense_rawrec xformCourtOffenseStatements(court_offense_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_IDs := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
				
		court_offenses_recs_final_ds := JOIN(court_offenses_recs_filt, court_offenses_pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.offense_persistent_id = (UNSIGNED) RIGHT.RecID1,
													xformCourtOffenseStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
		
		court_offenses_recs_out := PROJECT(court_offenses_recs_final_ds, 
																	TRANSFORM(court_offense_out,
																		SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(
																											LEFT.compliance_flags, 
																											LEFT.record_ids, 
																											LEFT.statement_IDs, 
																											LEFT.subject_did, 
																											FFD.Constants.DataGroups.COURT_OFFENSES),
																		SELF := LEFT));			

  // -------------  ACTIVITY / EVENTS -------------

		activity_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.ACTIVITY);
		activity_all_flags := flag_file(file_id = FCRA.FILE_ID.ACTIVITY);
		
		activity_flag_recs := 
			JOIN(activity_all_flags, FCRA.key_override_crim.activity, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(activity_rawrec,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := (STRING) RIGHT.activity_persistent_id;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		activity_override_recs := activity_flag_recs(compliance_flags.isOverride);	
		activity_suppressed_recs := activity_flag_recs(compliance_flags.isSuppressed);		

		activity_override_ids := SET(activity_override_recs, combined_record_id);	
		activity_suppressed_ids := SET(activity_suppressed_recs, combined_record_id);

		activity_main_recs := JOIN(id_recs, doxie_files.key_activity(isFCRA),
			KEYED(LEFT.offender_key = RIGHT.ok),
			TRANSFORM(activity_rawrec,
				SELF.compliance_flags.IsOverwritten := (RIGHT.activity_persistent_id<>0 AND (STRING) RIGHT.activity_persistent_id IN activity_override_ids);
				SELF.compliance_flags.IsSuppressed := (RIGHT.activity_persistent_id<>0 AND (STRING) RIGHT.activity_persistent_id IN activity_suppressed_ids)
																							OR (RIGHT.offender_key IN offenders_suppressed_ids);
				SELF.subject_did := LEFT.subject_did;
				SELF.record_ids.RecId1 := (STRING) RIGHT.activity_persistent_id;
				SELF := RIGHT;
				SELF := LEFT;
				SELF := []), // recid2, recid3, recid4
			LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxCrimEvents));
																	
		activity_recs_all := activity_main_recs + activity_override_recs;
		
		activity_recs_filt := activity_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
			FCRA.crim_is_ok (todaysdate, event_date, 'Y', 'N')
			);
											
		activity_rawrec xformActivityStatements(activity_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_IDs := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
				
		activity_recs_final_ds := JOIN(activity_recs_filt, activity_pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.activity_persistent_id = (UNSIGNED) RIGHT.RecID1,
													xformActivityStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
		
		activity_recs_out := PROJECT(activity_recs_final_ds, 
																	TRANSFORM(activity_out,
																		SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(
																											LEFT.compliance_flags, 
																											LEFT.record_ids, 
																											LEFT.statement_IDs, 
																											LEFT.subject_did, 
																											FFD.Constants.DataGroups.ACTIVITY),
																		SELF := LEFT));			

  // -------------  OFFENDERS_PLUS  -------------

		offenderplus_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.OFFENDERS_PLUS);
		offenderplus_all_flags := flag_file(file_id = FCRA.FILE_ID.OFFENDERS_PLUS);
		
		offenderplus_flag_recs := 
			JOIN(offenderplus_all_flags, FCRA.key_override_crim.offenders_plus, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(offender_rawrec,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := (STRING) RIGHT.offender_persistent_id;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		offenderplus_override_recs := offenderplus_flag_recs(compliance_flags.isOverride);	
		offenderplus_suppressed_recs := offenderplus_flag_recs(compliance_flags.isSuppressed);		

		offenderplus_override_ids := SET(offenderplus_override_recs, combined_record_id);	
		offenderplus_suppressed_ids := SET(offenderplus_suppressed_recs, combined_record_id);

		offenderplus_main_recs := JOIN(id_recs, doxie_files.Key_Offenders_OffenderKey(isFCRA),
			KEYED(LEFT.offender_key = RIGHT.ofk),
			TRANSFORM(offender_rawrec,
				SELF.compliance_flags.IsOverwritten := (RIGHT.offender_persistent_id<>0 AND (STRING) RIGHT.offender_persistent_id IN offenderplus_override_ids);
				SELF.compliance_flags.IsSuppressed := (RIGHT.offender_persistent_id<>0 AND (STRING) RIGHT.offender_persistent_id IN offenderplus_suppressed_ids)
																							OR (RIGHT.offender_key IN offenders_suppressed_ids);
				SELF.subject_did := LEFT.subject_did;
				SELF.record_ids.RecId1 := (STRING) RIGHT.offender_persistent_id;
				SELF := RIGHT;
				SELF := LEFT;
				SELF := []), // recid2, recid3, recid4
			LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxCrimOffendersPerOFK));
																	
		offenderplus_recs_all := offenderplus_main_recs + offenderplus_override_recs;
		
		offenderplus_recs_filt := offenderplus_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
			FCRA.crim_is_ok (todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag)
			);
											
		offender_rawrec xformOffenderPlusStatements(offender_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_IDs := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
				
		offenderplus_recs_final_ds := JOIN(offenderplus_recs_filt, offenderplus_pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.offender_persistent_id = (UNSIGNED) RIGHT.RecID1,
													xformOffenderPlusStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
		
		offenderplus_recs_out := PROJECT(offenderplus_recs_final_ds, 
																	TRANSFORM(offender_out,
																		SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(
																											LEFT.compliance_flags, 
																											LEFT.record_ids, 
																											LEFT.statement_IDs, 
																											LEFT.subject_did, 
																											FFD.Constants.DataGroups.OFFENDERS_PLUS),
																		SELF := LEFT));			

		//----- Combine all results for output---------

		criminal_rec_out xfRollOffenders(offender_out le, 
												DATASET(offender_out) ri) := 
		TRANSFORM
			SELF.offender_key := le.offender_key;
			SELF.Offenders := ri;
			SELF.OffenderPlus := [];
			SELF.Offenses := [];
			SELF.CourtOffenses := [];
			SELF.Activities := [];
			SELF.Punishments := [];
		END;
			
		offenders_rolled := ROLLUP(GROUP(SORT(offender_recs_out, offender_key), offender_key), 
																	GROUP, xfRollOffenders(LEFT, ROWS(LEFT)));	

		criminal_rec_out xfAddOffense(criminal_rec_out le, DATASET(offense_out) ri) := 
		TRANSFORM
			SELF.Offenses := ri;
			SELF := le;
		END;
			
		offender_with_offense := DENORMALIZE(offenders_rolled, offense_recs_out, 
														LEFT.offender_key = RIGHT.offender_key,
														GROUP, 
														xfAddOffense(LEFT, ROWS(RIGHT)));		

		criminal_rec_out xfAddCourtOffense(criminal_rec_out le, DATASET(court_offense_out) ri) := 
		TRANSFORM
			SELF.CourtOffenses := ri;
			SELF := le;
		END;
			
		crim_with_court_offenses := DENORMALIZE(offender_with_offense, court_offenses_recs_out, 
														LEFT.offender_key = RIGHT.offender_key,
														GROUP, 
														xfAddCourtOffense(LEFT, ROWS(RIGHT)));		

		criminal_rec_out xfAddActivity(criminal_rec_out le, DATASET(activity_out) ri) := 
		TRANSFORM
			SELF.Activities := ri;
			SELF := le;
		END;
			
		crim_with_activities := DENORMALIZE(crim_with_court_offenses, activity_recs_out, 
														LEFT.offender_key = RIGHT.offender_key,
														GROUP, 
														xfAddActivity(LEFT, ROWS(RIGHT)));		

		criminal_rec_out xfAddPunishment(criminal_rec_out le, DATASET(punishment_out) ri) := 
		TRANSFORM
			SELF.Punishments := ri;
			SELF := le;
		END;
			
		crim_with_punishments := DENORMALIZE(crim_with_activities, punishment_recs_out, 
														LEFT.offender_key = RIGHT.offender_key,
														GROUP, 
														xfAddPunishment(LEFT, ROWS(RIGHT)));		

		criminal_rec_out xfAddOffenderPlus(criminal_rec_out le, DATASET(offender_out) ri) := 
		TRANSFORM
			SELF.OffenderPlus := ri;
			SELF := le;
		END;
			
		recs_out := DENORMALIZE(crim_with_punishments, offenderplus_recs_out, 
														LEFT.offender_key = RIGHT.offender_key,
														GROUP, 
														xfAddOffenderPlus(LEFT, ROWS(RIGHT)));		


												
	IF(ConsumerDisclosure.Debug, OUTPUT(id_recs, NAMED('offender_ids')));
	IF(ConsumerDisclosure.Debug, OUTPUT(offenders_suppressed_recs, NAMED('offender_suppressed_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(offenders_override_recs, NAMED('offender_override_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(offenders_main_recs, NAMED('offender_main_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(offender_recs_out, NAMED('offender_recs_out')));
	IF(ConsumerDisclosure.Debug, OUTPUT(offense_suppressed_recs, NAMED('offense_suppressed_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(offense_override_recs, NAMED('offense_override_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(offense_main_recs, NAMED('offense_main_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(offense_recs_out, NAMED('offense_recs_out')));
	IF(ConsumerDisclosure.Debug, OUTPUT(court_offenses_suppressed_recs, NAMED('court_offense_suppressed_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(court_offenses_override_recs, NAMED('court_offense_override_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(court_offenses_main_recs, NAMED('court_offense_main_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(court_offenses_recs_out, NAMED('court_offense_recs_out')));
	IF(ConsumerDisclosure.Debug, OUTPUT(activity_suppressed_recs, NAMED('activity_suppressed_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(activity_override_recs, NAMED('activity_override_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(activity_main_recs, NAMED('activity_main_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(activity_recs_out, NAMED('activity_recs_out')));
	IF(ConsumerDisclosure.Debug, OUTPUT(punishment_suppressed_recs, NAMED('punishment_suppressed_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(punishment_override_recs, NAMED('punishment_override_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(punishment_main_recs, NAMED('punishment_main_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(punishment_recs_out, NAMED('punishment_recs_out')));
	IF(ConsumerDisclosure.Debug, OUTPUT(offenderplus_suppressed_recs, NAMED('offenderplus_suppressed_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(offenderplus_override_recs, NAMED('offenderplus_override_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(offenderplus_main_recs, NAMED('offenderplus_main_recs')));
	IF(ConsumerDisclosure.Debug, OUTPUT(offenderplus_recs_out, NAMED('offenderplus_recs_out')));
	IF(ConsumerDisclosure.Debug, OUTPUT(recs_out, NAMED('criminal_combined_recs')));

	RETURN recs_out;
	END;

END;