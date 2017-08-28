﻿IMPORT ConsumerDisclosure, doxie, Gong, FCRA, FFD;
EXPORT RawGong := MODULE 

	EXPORT Gong_raw := RECORD //RECORDOF(Gong.key_fcra_history_did)
		FCRA.Layout_Override_Gong -[flag_file_id];
	END;
	
	EXPORT Gong_rawrec := RECORD(Gong_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	EXPORT Gong_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		Gong_raw;
	END;

	EXPORT GetData(DATASET (doxie.layout_references) in_dids, 
								DATASET (fcra.Layout_override_flag) flag_file,
								DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,														 
								ConsumerDisclosure.IParams.IParam in_mod) := 
	FUNCTION
 
		BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

		pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.GONG);
		all_flags := flag_file(file_id = FCRA.FILE_ID.GONG);
		
		flag_recs := 
			JOIN(all_flags, FCRA.key_override_gong_ffid, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(Gong_rawrec,
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

		
		main_recs := JOIN (in_dids, Gong.Key_FCRA_History_did,
											KEYED(LEFT.did = RIGHT.l_did),
											TRANSFORM(Gong_rawrec,
																rec_id_oldway := TRIM((STRING12)RIGHT.did + (STRING8)RIGHT.dt_first_seen + (STRING10)RIGHT.phone10);											
																SELF.compliance_flags.IsOverwritten :=
																	(rec_id_oldway<>'' AND rec_id_oldway IN override_ids) OR 
																	(RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN override_ids), 
																SELF.compliance_flags.IsSuppressed :=
																	(rec_id_oldway<>'' AND rec_id_oldway IN suppressed_ids) OR 
																	(RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN suppressed_ids), 
																SELF.subject_did := LEFT.did,
																SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
																SELF := RIGHT,
																SELF := LEFT,
																SELF := []),
																LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxGongPerDID));
		
		// combining both -  original records and overrides
		recs_all := main_recs + override_recs;
		
		recs_filt:= recs_all(
			in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed
			);
											
		Gong_rawrec xformStatements( Gong_rawrec l,	FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
				SKIP(~ShowDisputedRecords AND r.isDisputed)
							
						SELF.statement_ids := r.StatementIDs;
						SELF.compliance_flags.IsDisputed   := r.isDisputed;
						SELF := l;
		END;
				
		recs_final_ds := JOIN(recs_filt, pc_flags,
														LEFT.subject_did = (UNSIGNED6) RIGHT.lexid AND
														LEFT.record_ids.RecId1 = RIGHT.RecID1,
														xformStatements(LEFT,RIGHT), 
														LEFT OUTER,
														KEEP(1),
														LIMIT(0));
				
		recs_out := PROJECT(recs_final_ds, TRANSFORM(Gong_out,			
													SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_IDs,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.GONG);
													SELF := LEFT;			
													));			
				
		IF(ConsumerDisclosure.Debug,OUTPUT(suppressed_recs, NAMED('Gong_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(override_recs, NAMED('Gong_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(main_recs, NAMED('Gong_main_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(recs_out, NAMED('Gong_recs')));
		
		RETURN recs_out;	
	END;
END;