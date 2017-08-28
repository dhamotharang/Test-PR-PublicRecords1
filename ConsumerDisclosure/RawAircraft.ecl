IMPORT doxie, FCRA, FFD, FAA, BIPV2,  ConsumerDisclosure;
EXPORT RawAircraft := MODULE

	SHARED aircraft_raw := RECORD //RECORDOF(FAA.key_aircraft_id)
	  UNSIGNED6 aircraft_id;
		FAA.layout_aircraft_registration_out_Persistent_ID;
		BIPV2.IDlayouts.l_xlink_ids;
	END;
	
	SHARED aircraft_engine_raw := RECORD //RECORDOF(FAA.key_engine_info)\
		STRING5 code;
		FAA.layout_engine_info;
	END;
	
	EXPORT aircraft_details_raw := RECORD //RECORDOF(FAA.key_aircraft_info)
		STRING7 code;
		FAA.layout_aircraft_info;
	END;

	SHARED aircraft_rawrec := RECORD(aircraft_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	SHARED aircraft_details_rawrec := RECORD(aircraft_details_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	SHARED aircraft_engine_rawrec := RECORD(aircraft_engine_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	EXPORT aircraft_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		aircraft_raw;
	END;

	EXPORT aircraft_engine_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		aircraft_engine_raw;
	END;

	EXPORT aircraft_details_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		aircraft_details_raw;
	END;

	EXPORT FAA_out := RECORD
    aircraft_raw.mfr_mdl_code;
    aircraft_raw.eng_mfr_mdl;
		DATASET(aircraft_out) Aircraft {xpath('Aircraft/Row')};
		DATASET(aircraft_details_out) AircraftDetails {xpath('AircraftDetails/Row')};
		DATASET(aircraft_engine_out) AircraftEngine {xpath('AircraftEngine/Row')};
	END;

  mfr_eng_codes_rec := RECORD
		UNSIGNED subject_did;
    aircraft_raw.mfr_mdl_code;
    aircraft_raw.eng_mfr_mdl;
  END;
	
	BOOLEAN IsFCRA := TRUE;

	EXPORT GetData(DATASET(doxie.layout_references) in_dids,
								DATASET (fcra.Layout_override_flag) flag_file,
								DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,														 
							 ConsumerDisclosure.IParams.IParam in_mod) := 
 FUNCTION

	BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
	
	aircraft_flags := flag_file(file_id = FCRA.FILE_ID.AIRCRAFT);
	aircraft_info_flags := flag_file(file_id = FCRA.FILE_ID.AIRCRAFT_DETAILS);
	aircraft_engine_flags := flag_file(file_id = FCRA.FILE_ID.AIRCRAFT_ENGINE);
	
	aircraft_pc := slim_pc_recs(datagroup = FFD.Constants.DataGroups.AIRCRAFT);
	aircraft_info_pc := slim_pc_recs(datagroup = FFD.Constants.DataGroups.AIRCRAFT_DETAILS);
	aircraft_engine_pc := slim_pc_recs(datagroup = FFD.Constants.DataGroups.AIRCRAFT_ENGINE);
	
	aircraft_flag_recs := 
		JOIN(aircraft_flags, FCRA.key_override_faa.aircraft, 
			KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
			TRANSFORM(aircraft_rawrec,
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

	aircraft_override_recs := aircraft_flag_recs(compliance_flags.isOverride);	
	aircraft_suppressed_recs := aircraft_flag_recs(compliance_flags.isSuppressed);		

	aircraft_override_ids := SET(aircraft_override_recs, combined_record_id);	
	aircraft_suppressed_ids := SET(aircraft_suppressed_recs, combined_record_id);

	aircraft_id_recs := JOIN(in_dids,FAA.key_aircraft_did(isFCRA),
			            KEYED(LEFT.did = RIGHT.did),
									TRANSFORM(RIGHT),
									LIMIT(ConsumerDisclosure.Constants.Limits.MaxAircraftsPerDID)); 
									
	aircraft_main_recs := JOIN(aircraft_id_recs, FAA.key_aircraft_id(IsFCRA),
												KEYED(LEFT.aircraft_id = RIGHT.aircraft_id),
												TRANSFORM(aircraft_rawrec,
																	SELF.compliance_flags.IsOverwritten :=
																		(RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN aircraft_override_ids), 
																	SELF.compliance_flags.IsSuppressed :=
																		(RIGHT.persistent_record_id>0 and (STRING) RIGHT.persistent_record_id IN aircraft_suppressed_ids), 
																	SELF.subject_did := LEFT.did,
																	SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
																	SELF := RIGHT,
																	SELF := LEFT,
																	SELF := []),
																	LIMIT(0), KEEP(1));
																

	aircraft_recs_all := aircraft_main_recs + aircraft_override_recs;
	
	aircraft_recs_filt:= aircraft_recs_all(
		in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
		in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed
		);
										
		aircraft_rawrec xformStatements(aircraft_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		aircraft_recs_final_ds := JOIN(aircraft_recs_filt, aircraft_pc,
													LEFT.record_ids.RecId1 = RIGHT.RecID1,
													xformStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		aircraft_recs_out := PROJECT(aircraft_recs_final_ds, TRANSFORM(aircraft_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_IDs,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.AIRCRAFT);
												SELF := LEFT;			
												));			

	mfr_eng_codes := PROJECT(aircraft_recs_final_ds, mfr_eng_codes_rec);
	mfr_mdl_ids := DEDUP(SORT(mfr_eng_codes, mfr_mdl_code), mfr_mdl_code);
	mfr_engine_ids := DEDUP(SORT(mfr_eng_codes, eng_mfr_mdl), eng_mfr_mdl);
	
	// aircraft info details
	aircraft_info_flag_recs := 
		JOIN(aircraft_info_flags, FCRA.key_override_faa.aircraft_details, 
			KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
			TRANSFORM(aircraft_details_rawrec,
				is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
				SELF.compliance_flags.isOverride := is_override;
				SELF.compliance_flags.isSuppressed := ~is_override;
				SELF.subject_did := (UNSIGNED6) LEFT.did;
				SELF.combined_record_id := LEFT.record_id;
				SELF.record_ids.RecId1 := RIGHT.aircraft_mfr_model_code;
				SELF.code := RIGHT.aircraft_mfr_model_code;
				SELF := RIGHT;
				SELF := LEFT;
				SELF := []),
			LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

	aircraft_info_override_recs := aircraft_info_flag_recs(compliance_flags.isOverride);	
	aircraft_info_suppressed_recs := aircraft_info_flag_recs(compliance_flags.isSuppressed);		

	aircraft_info_override_ids := SET(aircraft_info_override_recs, combined_record_id);	
	aircraft_info_suppressed_ids := SET(aircraft_info_suppressed_recs, combined_record_id);

	aircraft_info_main_recs := JOIN(mfr_mdl_ids, FAA.key_aircraft_info(IsFCRA),
												KEYED(LEFT.mfr_mdl_code = RIGHT.code),
												TRANSFORM(aircraft_details_rawrec,
																	SELF.compliance_flags.IsOverwritten :=
																		(RIGHT.code <> '' AND RIGHT.code IN aircraft_info_override_ids), 
																	SELF.compliance_flags.IsSuppressed :=
																		(RIGHT.code <> '' and RIGHT.code IN aircraft_info_suppressed_ids), 
																	SELF.subject_did := LEFT.subject_did,
																	SELF.record_ids.RecId1 := (STRING) RIGHT.code,
																	SELF := RIGHT,
																	SELF := LEFT,
																	SELF := []),
																	LIMIT(0), KEEP(1));
																

	aircraft_info_recs_all := aircraft_info_main_recs + aircraft_info_override_recs;
	
	aircraft_info_recs_filt := aircraft_info_recs_all(
		in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
		in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
		);
										
		aircraft_details_rawrec xfAircraftInfoStatements(aircraft_details_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		aircraft_info_recs_final_ds := JOIN(aircraft_info_recs_filt, aircraft_info_pc,
													LEFT.record_ids.RecId1 = RIGHT.RecID1,
													xfAircraftInfoStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		aircraft_info_recs_out := PROJECT(aircraft_info_recs_final_ds, 
																TRANSFORM(aircraft_details_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_IDs,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.AIRCRAFT_DETAILS);
												SELF := LEFT;			
												));			

	// aircraft engine dataset
	aircraft_engine_flag_recs := 
		JOIN(aircraft_engine_flags, FCRA.key_override_faa.aircraft_engine, 
			KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
			TRANSFORM(aircraft_engine_rawrec,
				is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
				SELF.compliance_flags.isOverride := is_override;
				SELF.compliance_flags.isSuppressed := ~is_override;
				SELF.subject_did := (UNSIGNED6) LEFT.did;
				SELF.combined_record_id := LEFT.record_id;
				SELF.Record_Ids.RecId1 := RIGHT.engine_mfr_model_code;
				SELF.code := RIGHT.engine_mfr_model_code;
				SELF := RIGHT;
				SELF := LEFT;
				SELF := []),
			LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

	aircraft_engine_override_recs := aircraft_engine_flag_recs(compliance_flags.isOverride);	
	aircraft_engine_suppressed_recs := aircraft_engine_flag_recs(compliance_flags.isSuppressed);		

	aircraft_engine_override_ids := SET(aircraft_engine_override_recs, combined_record_id);	
	aircraft_engine_suppressed_ids := SET(aircraft_engine_suppressed_recs, combined_record_id);

	aircraft_engine_main_recs := JOIN(mfr_engine_ids, FAA.key_engine_info(IsFCRA),
												KEYED(LEFT.eng_mfr_mdl = RIGHT.code),
												TRANSFORM(aircraft_engine_rawrec,
																	SELF.compliance_flags.IsOverwritten :=
																		(RIGHT.code <> '' AND RIGHT.code IN aircraft_engine_override_ids), 
																	SELF.compliance_flags.IsSuppressed :=
																		(RIGHT.code <> '' and RIGHT.code IN aircraft_engine_suppressed_ids), 
																	SELF.subject_did := LEFT.subject_did,
																	SELF.record_ids.RecId1 := (STRING) RIGHT.code,
																	SELF := RIGHT,
																	SELF := LEFT,
																	SELF := []),
																	LIMIT(0), KEEP(1));
																

	aircraft_engine_recs_all := aircraft_engine_main_recs + aircraft_engine_override_recs;
	
	aircraft_engine_recs_filt := aircraft_engine_recs_all(
		in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
		in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
		);
										
		aircraft_engine_rawrec xfAircraftEngineStatements(aircraft_engine_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		aircraft_engine_recs_final_ds := JOIN(aircraft_engine_recs_filt, aircraft_engine_pc,
													LEFT.record_ids.RecId1 = RIGHT.RecID1,
													xfAircraftEngineStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		aircraft_engine_recs_out := PROJECT(aircraft_engine_recs_final_ds, 
																TRANSFORM(aircraft_engine_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_IDs,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.AIRCRAFT_ENGINE);
												SELF := LEFT;			
												));			

		// Now combining data sets for final output
		FAA_out xfRollAircraft(aircraft_out le, 
												DATASET(aircraft_out) aircraft_rows) := 
		TRANSFORM
			SELF.mfr_mdl_code := le.mfr_mdl_code;
			SELF.eng_mfr_mdl := le.eng_mfr_mdl;
			SELF.Aircraft := aircraft_rows;
			SELF.AircraftEngine := [];
			SELF.AircraftDetails := [];
		END;
			
		aircraft_rolled := ROLLUP(GROUP(SORT(aircraft_recs_out, mfr_mdl_code,eng_mfr_mdl), mfr_mdl_code,eng_mfr_mdl), 
																	GROUP, xfRollAircraft(LEFT, ROWS(LEFT)));	

		FAA_out xfAddEngine(FAA_out le, DATASET(aircraft_engine_out) r_rows) := 
		TRANSFORM
			SELF.AircraftEngine := r_rows;
			SELF := le;
		END;
			
		aircraft_with_engine := DENORMALIZE(aircraft_rolled, aircraft_engine_recs_out, 
														LEFT.eng_mfr_mdl = RIGHT.code,
														GROUP, 
														xfAddEngine(LEFT, ROWS(RIGHT)));		
		
		FAA_out xfAddDetails(FAA_out le, DATASET(aircraft_details_out) r_rows) := 
		TRANSFORM
			SELF.AircraftDetails := r_rows;
			SELF := le;
		END;
			
		recs_out := DENORMALIZE(aircraft_with_engine, aircraft_info_recs_out, 
														LEFT.mfr_mdl_code = RIGHT.code,
														GROUP, 
														xfAddDetails(LEFT, ROWS(RIGHT)));		
		
		
												
		IF(ConsumerDisclosure.Debug,OUTPUT(aircraft_suppressed_recs, NAMED('aircraft_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(aircraft_override_recs, NAMED('aircraft_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(aircraft_main_recs, NAMED('aircraft_main_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(aircraft_engine_suppressed_recs, NAMED('aircraft_engine_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(aircraft_engine_override_recs, NAMED('aircraft_engine_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(aircraft_engine_main_recs, NAMED('aircraft_engine_main_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(aircraft_info_suppressed_recs, NAMED('aircraft_info_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(aircraft_info_override_recs, NAMED('aircraft_info_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(aircraft_info_main_recs, NAMED('aircraft_info_main_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(recs_out, NAMED('aircrafts_recs')));

		RETURN recs_out;
	END;
	
END;
