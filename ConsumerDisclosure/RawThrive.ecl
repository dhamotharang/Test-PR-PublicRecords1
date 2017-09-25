IMPORT doxie, FCRA, FFD, Thrive, ConsumerDisclosure, MDR,STD,UT;
EXPORT RawThrive := MODULE

	SHARED Thrive_raw := RECORD(Thrive.layouts.baseOld)
	END;

	SHARED Thrive_rawrec := RECORD(Thrive_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	EXPORT Thrive_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		Thrive_raw;
	END;

	EXPORT DateIsOk (STRING8 _date, STRING8 _today) := ut.DaysApart(_date, _today) < ut.DaysInNYears(7);
	
	EXPORT GetData(DATASET(doxie.layout_references) in_dids,
								DATASET (fcra.Layout_override_flag) flag_file,
								DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,														 
							  ConsumerDisclosure.IParams.IParam in_mod) := 
	FUNCTION

		BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
	
		today := (STRING8)Std.Date.Today();
		
		pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.THRIVE);
		all_flags := flag_file(file_id = FCRA.FILE_ID.THRIVE);
		
		flag_recs := 
			JOIN(all_flags, FCRA.Key_Override_Thrive_ffid.thrive, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(Thrive_rawrec,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		override_recs := flag_recs(compliance_flags.isOverride);	
		suppressed_recs := flag_recs(compliance_flags.isSuppressed);		

		override_ids := SET(override_recs, combined_record_id);	
		suppressed_ids := SET(suppressed_recs, combined_record_id);

		main_recs := JOIN(in_dids, Thrive.keys().did_fcra.qa,
													KEYED(LEFT.did = RIGHT.did),
 													TRANSFORM(Thrive_rawrec,
																		SELF.compliance_flags.IsOverwritten :=
																			(RIGHT.persistent_record_id<>'' AND (STRING)RIGHT.persistent_record_id IN override_ids), 
																		SELF.compliance_flags.IsSuppressed :=
																			(RIGHT.persistent_record_id<>'' AND (STRING)RIGHT.persistent_record_id IN suppressed_ids), 
																		SELF.subject_did := LEFT.did,
																		SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
																		SELF := RIGHT,
																		SELF := LEFT,
																		SELF := []),
																		LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxThrivePerDID));
																	

		recs_all := main_recs + override_recs;
		
		recs_filt:= recs_all(
			in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed,
			src = MDR.sourceTools.src_Thrive_PD,  // should we filter by src?
			DateIsOk((STRING8)dt_first_seen, today)
			);
										
		Thrive_rawrec xformStatements(Thrive_rawrec l,	FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		recs_final_ds := JOIN(recs_filt, pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.record_ids.RecID1 = RIGHT.RecID1,
													xformStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		recs_out := PROJECT(recs_final_ds, TRANSFORM(Thrive_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_ids,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.THRIVE);
												SELF := LEFT;			
												));			
												
		IF(ConsumerDisclosure.Debug,OUTPUT(suppressed_recs, NAMED('Thrive_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(override_recs, NAMED('Thrive_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(main_recs, NAMED('Thrive_main_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(recs_out, NAMED('Thrive_recs')));
		
		RETURN SORT(recs_out, -dt_last_seen, -dt_first_seen);
	END;
	
END;
