﻿IMPORT doxie, FCRA, FFD, PAW, ConsumerDisclosure;
EXPORT RawPeopleAtWork := MODULE

	EXPORT PAW_raw := PAW.Layout.Employment_Out;

	EXPORT PAW_rawrec := RECORD(PAW_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	EXPORT PAW_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		PAW_raw;
	END;

	EXPORT GetData(DATASET(doxie.layout_references) in_dids,
								DATASET (fcra.Layout_override_flag) flagfile,
								DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,														 
							  ConsumerDisclosure.IParams.IParam in_mod) := 
	FUNCTION

		BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
		
		pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.PAW);
		all_flags := flagfile(file_id = FCRA.FILE_ID.PAW);
		
		flag_recs := 
			JOIN(all_flags, FCRA.key_override_paw_ffid, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(PAW_rawrec,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := (STRING) RIGHT.contact_id;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		override_recs := flag_recs(Compliance_Flags.isOverride);	
		suppressed_recs := flag_recs(Compliance_Flags.isSuppressed);		

		override_ids := SET(override_recs, combined_record_id);	
		suppressed_ids := SET(suppressed_recs, combined_record_id);

		main_recs := JOIN(in_dids, PAW.Key_DID_FCRA,
													KEYED(LEFT.did = RIGHT.did),
													TRANSFORM(PAW_rawrec,
																		SELF.compliance_flags.IsOverwritten :=
																			(RIGHT.contact_id>0 AND (STRING) RIGHT.contact_id IN override_ids), 
																		SELF.compliance_flags.IsSuppressed :=
																			(RIGHT.contact_id>0 and (STRING) RIGHT.contact_id IN suppressed_ids), 
																		SELF.subject_did := LEFT.did,
																		SELF.Record_Ids.RecId1 := (STRING) RIGHT.contact_id,
																		SELF := RIGHT,
																		SELF := LEFT,
																		SELF := []),
																		LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxPAWPerDID));
																	

		recs_all := main_recs + override_recs;
		
		recs_filt:= recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
			);
										
		//add statementids  & add dispute indicators/remove disputed records
			
		PAW_rawrec xformStatements( PAW_rawrec l,	FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		recs_final_ds := JOIN(recs_filt, pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.lexid AND
													LEFT.contact_id = (INTEGER) RIGHT.RecID1,
													xformStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		recs_out := PROJECT(recs_final_ds, TRANSFORM(PAW_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_IDs,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.PAW);
												SELF := LEFT;			
												));			
												
		IF(ConsumerDisclosure.Debug,OUTPUT(suppressed_recs, NAMED('PAW_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(override_recs, NAMED('PAW_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(main_recs, NAMED('PAW_main_recs')));
		RETURN recs_out;
	END;
	
END;
