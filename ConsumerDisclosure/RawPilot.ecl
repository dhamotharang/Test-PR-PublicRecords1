IMPORT doxie, FCRA, FFD, FAA, ConsumerDisclosure;
EXPORT RawPilot := MODULE

	SHARED Pilot_reg_raw := RECORD(FAA.layout_airmen_Persistent_ID)
		UNSIGNED6 airmen_id;
		UNSIGNED8 did := 0;
  END;
	
	SHARED Pilot_cert_raw := RECORD(FAA.layout_airmen_certificate_out) 
		STRING7 uid;
	END;

	SHARED Pilot_reg_rawrec := RECORD(Pilot_reg_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	SHARED Pilot_cert_rawrec := RECORD(Pilot_cert_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	EXPORT Pilot_reg_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		Pilot_reg_raw;
	END;
	
	EXPORT Pilot_cert_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		Pilot_cert_raw;
	END;
	
	EXPORT Pilot_out := RECORD
    TYPEOF(FAA.layout_airmen_Persistent_ID.unique_id) unique_id;
		DATASET(Pilot_cert_out) Certificate {xpath('Certificate/Row')};
		DATASET(Pilot_reg_out) Registration {xpath('Registration/Row')};
	END;
	
	certificate_uid_rec := RECORD
		UNSIGNED6 subject_did;
    faa.layout_airmen_Persistent_ID.unique_id;
    faa.layout_airmen_Persistent_ID.letter_code;
  END;		 

	BOOLEAN IsFCRA := TRUE;

	EXPORT GetData(DATASET(doxie.layout_references) in_dids,
								DATASET (fcra.Layout_override_flag) flag_file,
								DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,														 
							 ConsumerDisclosure.IParams.IParam in_mod) := 
	FUNCTION

		BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
		
		pc_pilot_cert := slim_pc_recs(datagroup = FFD.Constants.DataGroups.PILOT_CERTIFICATE);
		pilot_cert_flags := flag_file(file_id = FCRA.FILE_ID.PILOT_CERTIFICATE);
		pc_pilot_reg := slim_pc_recs(datagroup = FFD.Constants.DataGroups.PILOT_REGISTRATION);
		pilot_reg_flags := flag_file(file_id = FCRA.FILE_ID.PILOT_REGISTRATION);
		
		pilot_reg_flag_recs := 
			JOIN(pilot_reg_flags, FCRA.key_override_faa.airmen_reg, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(Pilot_reg_rawrec,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id;
					SELF.did := (UNSIGNED8) RIGHT.did_out;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		pilot_reg_override_recs := pilot_reg_flag_recs(Compliance_Flags.isOverride);	
		pilot_reg_suppressed_recs := pilot_reg_flag_recs(Compliance_Flags.isSuppressed);		

		pilot_reg_override_ids := SET(pilot_reg_override_recs, combined_record_id);	
		pilot_reg_suppressed_ids := SET(pilot_reg_suppressed_recs, combined_record_id);

		pilot_reg_main_recs := JOIN(in_dids, FAA.key_airmen_did(isFCRA),
													KEYED(LEFT.did = RIGHT.did),
													TRANSFORM(Pilot_reg_rawrec,
																		SELF.compliance_flags.IsOverwritten :=
																			(RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN pilot_reg_override_ids), 
																		SELF.compliance_flags.IsSuppressed :=
																			(RIGHT.persistent_record_id>0 and (STRING) RIGHT.persistent_record_id IN pilot_reg_suppressed_ids), 
																		SELF.subject_did := LEFT.did,
																		SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
																		SELF := RIGHT,
																		SELF := LEFT,
																		SELF := []),
																		LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxAirmenPerDID));
																	

		pilot_reg_recs_all := pilot_reg_main_recs + pilot_reg_override_recs;
		
		pilot_reg_recs_filt:= pilot_reg_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
			);
										
		//add statementids  & add dispute indicators/remove disputed records
			
		Pilot_reg_rawrec xformStatements(Pilot_reg_rawrec l,	FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		pilot_reg_recs_final_ds := JOIN(pilot_reg_recs_filt, pc_pilot_reg,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
													xformStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		pilot_reg_recs_out := PROJECT(pilot_reg_recs_final_ds, TRANSFORM(Pilot_reg_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_IDs,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.PILOT_REGISTRATION);
												SELF := LEFT;			
												));			
		
		// Pilot Certificates:
		cert_uids := DEDUP(PROJECT(pilot_reg_recs_final_ds, certificate_uid_rec), ALL);

		pilot_cert_flag_recs := 
			JOIN(pilot_cert_flags, FCRA.key_override_faa.airmen_cert, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(Pilot_cert_rawrec,
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

		pilot_cert_override_recs := pilot_cert_flag_recs(compliance_flags.isOverride);	
		pilot_cert_suppressed_recs := pilot_cert_flag_recs(compliance_flags.isSuppressed);		

		pilot_cert_override_ids := SET(pilot_cert_override_recs, combined_record_id);	
		pilot_cert_suppressed_ids := SET(pilot_cert_suppressed_recs, combined_record_id);

		pilot_cert_main_recs := JOIN(cert_uids, FAA.key_airmen_certs(IsFCRA),
													KEYED(LEFT.unique_id = RIGHT.uid) 
													AND LEFT.letter_code = RIGHT.letter,
													TRANSFORM(Pilot_cert_rawrec,
																		SELF.compliance_flags.IsOverwritten :=
																			(RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN pilot_cert_override_ids), 
																		SELF.compliance_flags.IsSuppressed :=
																			(RIGHT.persistent_record_id>0 and (STRING) RIGHT.persistent_record_id IN pilot_cert_suppressed_ids), 
																		SELF.subject_did := LEFT.subject_did,
																		SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
																		SELF := RIGHT,
																		SELF := []),
																		LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxAirmanCertificates));
																	

		pilot_cert_recs_all := pilot_cert_main_recs + pilot_cert_override_recs;
		
		pilot_cert_recs_filt := pilot_cert_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
			);
										
		Pilot_cert_rawrec xformCertStatements(Pilot_cert_rawrec l,	FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		pilot_cert_recs_final_ds := JOIN(pilot_cert_recs_filt, pc_pilot_cert,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
													xformCertStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		pilot_cert_recs_out := PROJECT(pilot_cert_recs_final_ds, 
														TRANSFORM(Pilot_cert_out,			
														SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(
																								LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_IDs,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.PILOT_CERTIFICATE),
														SELF := LEFT)			
													);	
													
		// Now combining data sets for final output
		Pilot_out xfRollCert(Pilot_cert_out le, 
												DATASET(Pilot_cert_out) cert_rows) := 
		TRANSFORM
			SELF.unique_id := le.uid;
			SELF.Certificate := cert_rows;
			SELF.Registration := [];
		END;
			
		pilot_cert_rolled := ROLLUP(GROUP(SORT(pilot_cert_recs_out, uid), uid), 
																	GROUP, xfRollCert(LEFT, ROWS(LEFT)));	

		Pilot_out xfAddRegistration(Pilot_out le, DATASET(Pilot_reg_out) reg_rows) := 
		TRANSFORM
			SELF.Registration := reg_rows;
			SELF := le;
		END;
			
		recs_out := DENORMALIZE(pilot_cert_rolled, pilot_reg_recs_out, 
														LEFT.unique_id = RIGHT.unique_id,
														GROUP, 
														xfAddRegistration(LEFT, ROWS(RIGHT)));		

		IF(ConsumerDisclosure.Debug,OUTPUT(pilot_reg_suppressed_recs, NAMED('Pilot_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(pilot_reg_override_recs, NAMED('Pilot_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(pilot_reg_main_recs, NAMED('Pilot_main_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(pilot_cert_suppressed_recs, NAMED('PilotCertificate_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(pilot_cert_override_recs, NAMED('PilotCertificate_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(pilot_cert_main_recs, NAMED('PilotCertificate_main_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(recs_out, NAMED('Pilot_recs')));
		
		RETURN recs_out;
	END;

END;