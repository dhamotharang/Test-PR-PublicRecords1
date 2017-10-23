﻿IMPORT doxie, FCRA, FFD, Advo, ConsumerDisclosure;

advo_raw := RECORD  // recordof(Advo.Key_Addr1_FCRA_history)
	Advo.Layouts.Layout_Common_Out_k -[src];  
END;

advo_rawrec := RECORD(advo_raw)
	ConsumerDisclosure.Layouts.InternalMetadata;
END;
	

EXPORT RawAdvo := MODULE

	EXPORT layout_advo_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		advo_raw;
	END;

	EXPORT GetData(DATASET(ConsumerDisclosure.Layouts.address_rec) in_addresses,
								DATASET (fcra.Layout_override_flag) flag_file,
								DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,														 
							 ConsumerDisclosure.IParams.IParam in_mod) := 
	FUNCTION

	BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
	
	pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.Advo);
	all_flags := flag_file(file_id = FCRA.FILE_ID.Advo);
	
	flag_recs := 
		JOIN(all_flags, FCRA.key_override_advo_ffid, 
			KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
			TRANSFORM(advo_rawrec,
				is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
				SELF.compliance_flags.isOverride := is_override;
				SELF.compliance_flags.isSuppressed := ~is_override;
				SELF.subject_did := (UNSIGNED6) LEFT.did;
				SELF.combined_record_id := LEFT.record_id;
				SELF.record_ids.RecId1 := (STRING) RIGHT.zip;
				SELF.record_ids.RecId2 := (STRING) RIGHT.prim_range;
				SELF.record_ids.RecId3 := (STRING) RIGHT.prim_name;
				SELF.record_ids.RecId4 := (STRING) RIGHT.sec_range;
				SELF := RIGHT;
				SELF := LEFT;
				SELF := []),
			LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

	override_recs := flag_recs(compliance_flags.isOverride);	
	suppressed_recs := flag_recs(compliance_flags.isSuppressed);		

	override_ids := SET(override_recs, combined_record_id);	
	suppressed_ids := SET(suppressed_recs, combined_record_id);

	main_recs := JOIN(in_addresses, Advo.Key_Addr1_FCRA_history,
												LEFT.zip != '' and LEFT.prim_range != '' AND
												KEYED(LEFT.zip = RIGHT.zip AND
															LEFT.prim_range = RIGHT.prim_range AND
															LEFT.prim_name = RIGHT.prim_name AND
															LEFT.suffix = RIGHT.addr_suffix AND
															LEFT.predir = RIGHT.predir AND
															LEFT.postdir = RIGHT.postdir AND
															LEFT.sec_range = RIGHT.sec_range),
												TRANSFORM(advo_rawrec,
																	rec_id := TRIM(RIGHT.zip) + TRIM(RIGHT.prim_range) + TRIM(RIGHT.prim_name) + TRIM(RIGHT.sec_range);
																	SELF.compliance_flags.IsOverwritten := (rec_id IN override_ids), 
																	SELF.compliance_flags.IsSuppressed :=(rec_id IN suppressed_ids), 
																	SELF.subject_did := LEFT.subject_did,
																	SELF.record_ids.RecId1 := (STRING) RIGHT.zip,
																	SELF.record_ids.RecId2 := (STRING) RIGHT.prim_range,
																	SELF.record_ids.RecId3 := (STRING) RIGHT.prim_name,
																	SELF.record_ids.RecId4 := (STRING) RIGHT.sec_range,
																	SELF := RIGHT,
																	SELF := LEFT,
																	SELF := []),
																	LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxAdvoPerAddress));
																

	recs_all := main_recs + override_recs;
	
	recs_filt:= recs_all(
		in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
		in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed
		);
	
		advo_rawrec xformStatements(advo_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		recs_final_ds := JOIN(recs_filt, pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.record_ids.RecId1 = RIGHT.RecID1 AND
													LEFT.record_ids.RecId2 = RIGHT.RecID2 AND
													LEFT.record_ids.RecId3 = RIGHT.RecID3 AND
													LEFT.record_ids.RecId4 = RIGHT.RecID4,
													xformStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		recs_out := PROJECT(recs_final_ds, TRANSFORM(layout_advo_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_ids,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.Advo);
												SELF := LEFT;			
												));			
												
		IF(ConsumerDisclosure.Debug,OUTPUT(suppressed_recs, NAMED('Advo_Data_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(override_recs, NAMED('Advo_Data_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(main_recs, NAMED('Advo_Data_main_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(recs_out, NAMED('Advo_Data_recs')));
		
		RETURN SORT(recs_out, -date_last_seen, -date_first_seen, RECORD);
	END;

END;