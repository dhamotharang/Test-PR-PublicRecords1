IMPORT doxie, FCRA, FFD, InfutorCID, ConsumerDisclosure;
EXPORT RawInfutor := MODULE

	SHARED Infutor_raw := RECORD //RECORDOF(InfutorCID.Key_Infutor_DID_FCRA);
		FCRA.Layout_Override_Infutor -[flag_file_id];
	END;

	SHARED Infutor_rawrec := RECORD(Infutor_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	EXPORT Infutor_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		Infutor_raw;
	END;

	EXPORT GetData(DATASET(doxie.layout_references) in_dids,
								DATASET (fcra.Layout_override_flag) flag_file,
								DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,														 
							  ConsumerDisclosure.IParams.IParam in_mod) := 
	FUNCTION

		BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
	
		pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.INFUTOR);
		all_flags := flag_file(file_id = FCRA.FILE_ID.INFUTOR);
		
		flag_recs := 
			JOIN(all_flags, FCRA.key_override_infutor_ffid, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(Infutor_rawrec,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := RIGHT.persistent_record_id;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		override_recs := flag_recs(compliance_flags.isOverride);	
		suppressed_recs := flag_recs(compliance_flags.isSuppressed);		

		override_ids := SET(override_recs, combined_record_id);	
		suppressed_ids := SET(suppressed_recs, combined_record_id);

		main_recs := JOIN(in_dids, InfutorCID.Key_Infutor_DID_FCRA,
													KEYED(LEFT.did = RIGHT.did),
													TRANSFORM(Infutor_rawrec,
																		rec_id := TRIM(RIGHT.persistent_record_id);
																		rec_id_oldway := TRIM((STRING)RIGHT.did)+TRIM(RIGHT.phone)+TRIM((STRING)RIGHT.dt_first_seen);
																		SELF.compliance_flags.IsOverwritten :=
																			(rec_id_oldway<>'' AND rec_id_oldway IN override_ids) OR 
																			(rec_id<>'' AND rec_id IN override_ids), 
																		SELF.compliance_flags.IsSuppressed :=
																			(rec_id_oldway<>'' AND rec_id_oldway IN suppressed_ids) OR 
																			(rec_id<>'' AND rec_id IN suppressed_ids), 
																		SELF.subject_did := LEFT.did,
																		SELF.record_ids.RecId1 := RIGHT.persistent_record_id,
																		SELF := RIGHT,
																		SELF := LEFT,
																		SELF := []),
																		LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxInfutorPerDID));
																	

		recs_all := main_recs + override_recs;
		
		recs_filt:= recs_all(
			in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed
			);
										
		Infutor_rawrec xformStatements(Infutor_rawrec l,	FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
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
			
		recs_out := PROJECT(recs_final_ds, TRANSFORM(Infutor_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_ids,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.INFUTOR);
												SELF := LEFT;			
												));			
												
		IF(ConsumerDisclosure.Debug,OUTPUT(suppressed_recs, NAMED('Infutor_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(override_recs, NAMED('Infutor_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(main_recs, NAMED('Infutor_main_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(recs_out, NAMED('Infutor_recs')));
		
		RETURN SORT(recs_out, -dt_last_seen, -dt_first_seen);
	END;
	
END;
