IMPORT Watercraft, ConsumerDisclosure, doxie, FCRA, FFD, MDR, Suppress;

EXPORT RawWatercraft := MODULE

	SHARED Watercraft_info_raw := RECORD(Watercraft.Layout_Watercraft_Main_Base) // RECORDOF(watercraft.key_watercraft_wid)
	END; 
	
	SHARED Watercraft_owners_raw := RECORD // RECORDOF(watercraft.key_watercraft_sid)
		Watercraft.Layout_Watercraft_Search_Base_slim -{watercraft.layout_exclusions};
	END; 

	SHARED Coastguard_raw := RECORD(Watercraft.Layout_Watercraft_Coastguard_Base) // RECORDOF(watercraft.key_watercraft_cid)
	END; 
	
	SHARED Watercraft_info_rawrec := RECORD(Watercraft_info_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	SHARED Watercraft_owners_rawrec := RECORD(Watercraft_owners_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	SHARED Coastguard_rawrec := RECORD(Coastguard_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	EXPORT Watercraft_info_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		Watercraft_info_raw;
	END;

	EXPORT Watercraft_owners_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		Watercraft_owners_raw;
	END;

	EXPORT Coastguard_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		Coastguard_raw;
	END;

	EXPORT Watercraft_out := RECORD
		STRING state_origin;
		STRING watercraft_key;
		STRING sequence_key;
		DATASET(Watercraft_owners_out) Owners;
		DATASET(Watercraft_info_out) Details;
		DATASET(Coastguard_out) Coastguard;
	END;
	
	BOOLEAN IsFCRA := TRUE;

	EXPORT GetData(DATASET(doxie.layout_references) in_dids,
									DATASET (fcra.Layout_override_flag) flag_file,
									DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,														 
									ConsumerDisclosure.IParams.IParam in_mod) := FUNCTION

		BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
		
		Watercraft_owners_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.WATERCRAFT);
		Watercraft_owners_flags := flag_file(file_id = FCRA.FILE_ID.WATERCRAFT);
		
		coastguard_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.WATERCRAFT_COASTGUARD);
		coastguard_flags := flag_file(file_id = FCRA.FILE_ID.WATERCRAFT_COASTGUARD);
		
		Watercraft_info_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.WATERCRAFT_DETAILS);
		Watercraft_info_flags := flag_file(file_id = FCRA.FILE_ID.WATERCRAFT_DETAILS);
		
		id_recs := JOIN(in_dids,watercraft.key_watercraft_did(isFCRA),
										KEYED(left.did=right.l_did),
										TRANSFORM(RIGHT),
										LIMIT(0),KEEP(ConsumerDisclosure.Constants.Limits.MaxWatercraftPerDID)); 
										
		// --------------coastguard-------------
		Watercraft_coastguard_flag_recs := 
			JOIN(coastguard_flags, FCRA.key_override_watercraft.wid, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(coastguard_rawrec,
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

		Watercraft_coastguard_override_recs := Watercraft_coastguard_flag_recs(compliance_flags.isOverride);	
		Watercraft_coastguard_suppressed_recs := Watercraft_coastguard_flag_recs(compliance_flags.isSuppressed);		

		Watercraft_coastguard_override_ids := SET(Watercraft_coastguard_override_recs, combined_record_id);	
		Watercraft_coastguard_suppressed_ids := SET(Watercraft_coastguard_suppressed_recs, combined_record_id);

		Watercraft_coastguard_payload_recs := JOIN(id_recs, watercraft.key_watercraft_wid(IsFCRA),
													KEYED(LEFT.state_origin = RIGHT.state_origin AND
																LEFT.watercraft_key = RIGHT.watercraft_key AND
																LEFT.sequence_key = RIGHT.sequence_key),
													TRANSFORM(coastguard_rawrec,
																		rec_id := (STRING)RIGHT.persistent_record_id;
																		rec_id_oldway := TRIM(RIGHT.watercraft_key)+TRIM(RIGHT.sequence_key);
																		SELF.compliance_flags.IsOverwritten :=
																			(rec_id_oldway<>'' AND rec_id_oldway IN Watercraft_coastguard_override_ids) OR 
																			(rec_id<>'' AND rec_id IN Watercraft_coastguard_override_ids), 
																		SELF.compliance_flags.IsSuppressed :=
																			(rec_id_oldway<>'' AND rec_id_oldway IN Watercraft_coastguard_suppressed_ids) OR 
																			(rec_id<>'' AND rec_id IN Watercraft_coastguard_suppressed_ids), 
																		SELF.subject_did := LEFT.l_did,
																		SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
																		SELF := RIGHT,
																		SELF := []),
																		LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxWatercraftCoastGuards));
																	

		Watercraft_coastguard_recs_all := Watercraft_coastguard_payload_recs + Watercraft_coastguard_override_recs;
		
		Watercraft_coastguard_recs_filt := Watercraft_coastguard_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
			);
										
		// translate the source code to be the header source code so it can be found in the vendor lookup service
		coastguard_source_code_corr := PROJECT(Watercraft_coastguard_recs_filt, 
																		TRANSFORM(coastguard_rawrec, 
																		SELF.source_code := MDR.sourcetools.fWatercraft(LEFT.Source_Code, LEFT.State_Origin), 
																		SELF := LEFT));

		coastguard_rawrec xformCoastguardStatements(coastguard_rawrec l,	FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		Watercraft_coastguard_final_ds := JOIN(coastguard_source_code_corr, coastguard_pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
													xformCoastguardStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		Watercraft_coastguard_recs_out := PROJECT(Watercraft_coastguard_final_ds, 
														TRANSFORM(coastguard_out,			
														SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(
																								LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_IDs,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.WATERCRAFT_COASTGUARD),
														SELF := LEFT)			
													);	
													
		//----------- Watercraft details--------------
		Watercraft_info_flag_recs := 
			JOIN(Watercraft_info_flags, FCRA.key_override_watercraft.wid, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(Watercraft_info_rawrec,
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

		Watercraft_info_override_recs := Watercraft_info_flag_recs(compliance_flags.isOverride);	
		Watercraft_info_suppressed_recs := Watercraft_info_flag_recs(compliance_flags.isSuppressed);		

		Watercraft_info_override_ids := SET(Watercraft_info_override_recs, combined_record_id);	
		Watercraft_info_suppressed_ids := SET(Watercraft_info_suppressed_recs, combined_record_id);

		Watercraft_info_payload_recs := JOIN(id_recs, watercraft.key_watercraft_wid(IsFCRA),
												KEYED(LEFT.state_origin = RIGHT.state_origin AND
															LEFT.watercraft_key = RIGHT.watercraft_key AND
															LEFT.sequence_key = RIGHT.sequence_key),
													TRANSFORM(Watercraft_info_rawrec,
																		rec_id := (STRING)RIGHT.persistent_record_id;
																		rec_id_oldway := TRIM(RIGHT.watercraft_key)+TRIM(RIGHT.sequence_key);
																		SELF.compliance_flags.IsOverwritten :=
																			(rec_id_oldway<>'' AND rec_id_oldway IN Watercraft_info_override_ids) OR 
																			(rec_id<>'' AND rec_id IN Watercraft_info_override_ids), 
																		SELF.compliance_flags.IsSuppressed :=
																			(rec_id_oldway<>'' AND rec_id_oldway IN Watercraft_info_suppressed_ids) OR 
																			(rec_id<>'' AND rec_id IN Watercraft_info_suppressed_ids), 
																		SELF.subject_did := LEFT.l_did,
																		SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
																		SELF := RIGHT,
																		SELF := []),
																		LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxWatercraftDetails));
																	

		Watercraft_info_recs_all := Watercraft_info_payload_recs + Watercraft_info_override_recs;
		
		Watercraft_info_recs_filt := Watercraft_info_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
			);
										
		// translate the source code to be the header source code so it can be found in the vendor lookup service
		Watercraft_info_source_code_corr := PROJECT(Watercraft_info_recs_filt, 
																		TRANSFORM(Watercraft_info_rawrec, 
																		SELF.source_code := MDR.sourcetools.fWatercraft(LEFT.Source_Code, LEFT.State_Origin), 
																		SELF := LEFT));
	
		Watercraft_info_rawrec xformInfoStatements(Watercraft_info_rawrec l,	FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		Watercraft_info_final_ds := JOIN(Watercraft_info_source_code_corr, Watercraft_info_pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
													xformInfoStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		Watercraft_info_recs_out := PROJECT(Watercraft_info_final_ds, 
														TRANSFORM(Watercraft_info_out,			
														SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(
																								LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_IDs,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.WATERCRAFT_DETAILS),
														SELF := LEFT)			
													);	
													
		// ------ Owners -----------
		owners_flag_recs := 
			JOIN(Watercraft_owners_flags, FCRA.Key_Override_Watercraft.sid, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(Watercraft_owners_rawrec,
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

		owners_override_recs := owners_flag_recs(compliance_flags.isOverride);	
		owners_suppressed_recs := owners_flag_recs(compliance_flags.isSuppressed);		

		owners_override_ids := SET(owners_override_recs, combined_record_id);	
		owners_suppressed_ids := SET(owners_suppressed_recs, combined_record_id);

		owners_payload_recs := JOIN(id_recs,watercraft.key_watercraft_sid(isFCRA),
													KEYED(LEFT.state_origin = RIGHT.state_origin AND
																LEFT.watercraft_key = RIGHT.watercraft_key AND
																LEFT.sequence_key = RIGHT.sequence_key),
													TRANSFORM(Watercraft_owners_rawrec,
																			rec_id := (STRING)RIGHT.persistent_record_id;
																			rec_id_oldway := TRIM(RIGHT.watercraft_key)+TRIM(RIGHT.sequence_key);
																			SELF.compliance_flags.IsOverwritten :=
																				(rec_id_oldway<>'' AND rec_id_oldway IN owners_override_ids) OR 
																				(rec_id<>'' AND rec_id IN owners_override_ids), 
																			SELF.compliance_flags.IsSuppressed :=
																				(rec_id_oldway<>'' AND rec_id_oldway IN owners_suppressed_ids) OR 
																				(rec_id<>'' AND rec_id IN owners_suppressed_ids), 
																		SELF.subject_did := LEFT.l_did,
																		SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
																		SELF := RIGHT,
																		SELF := LEFT,
																		SELF := []),
																		LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxWatercraftOwners));
																	

		owners_recs_all := owners_payload_recs + owners_override_recs;
		
		owners_recs_filt := owners_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
			// non subject suppression
			in_mod.nss <> Suppress.Constants.NonSubjectSuppression.returnBlank OR subject_did=(UNSIGNED)did OR
			((did = '') AND ((bdid != '') OR (fein != '') OR (company_name != '')))  // owner is not a person
			);   
										
			
		Watercraft_owners_rawrec xformOwnersStatements(Watercraft_owners_rawrec l,FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_IDs := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		owners_recs_with_pc := JOIN(owners_recs_filt, Watercraft_owners_pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
													xformOwnersStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
		
		// translate the source code to be the header source code so it can be found in the vendor lookup service
		owners_recs_final_ds := PROJECT(owners_recs_with_pc, 
																		TRANSFORM(Watercraft_owners_rawrec, 
																		SELF.source_code := MDR.sourcetools.fWatercraft(LEFT.Source_Code, LEFT.State_Origin), 
																		SELF := LEFT));
	
		//apply non-subject suppression as restricted 
		Watercraft_owners_rawrec xformNSS(Watercraft_owners_rawrec L) := TRANSFORM
			IsSubject := (L.subject_did = (UNSIGNED) L.did);
			NotAPerson := (L.did = '') AND ((L.bdid != '') OR (L.fein != '') OR (L.company_name != ''));
			isRestricted := ~(IsSubject OR NotAPerson);
    
      SELF.subject_did := L.subject_did;
      SELF.compliance_flags := L.compliance_flags;
      SELF.record_ids := L.record_ids;
			
      SELF.watercraft_key := L.watercraft_key;
      SELF.state_origin   := L.state_origin;
      SELF.sequence_key   := L.sequence_key;
			SELF.persistent_record_id := L.persistent_record_id;
      
      SELF.lname := IF (isRestricted, FCRA.Constants.FCRA_Restricted, L.lname);    
      SELF := IF (~isRestricted, L);
			SELF := [];
		END;
		
		Watercraft_owners_nss := PROJECT(owners_recs_final_ds, xformNSS(LEFT));
		
		// returnBlank nss was taken care of at filtering, here we apply nss for restricted mode
		Watercraft_owners_final_ds := IF(in_mod.nss = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription, 
												Watercraft_owners_nss, owners_recs_final_ds);  

		owners_recs_out := PROJECT(Watercraft_owners_final_ds, 
												TRANSFORM(Watercraft_owners_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_IDs,
																								LEFT.subject_did,
																								FFD.Constants.DataGroups.WATERCRAFT);
												SELF := LEFT;			
												));			
												
		// Now combining data sets for final output
		Watercraft_out xfRollOwners(Watercraft_owners_out le, 
												DATASET(Watercraft_owners_out) owners_rows) := 
		TRANSFORM
			SELF.state_origin := le.state_origin;
			SELF.watercraft_key := le.watercraft_key;
			SELF.sequence_key := le.sequence_key;
			SELF.Owners := owners_rows;
			SELF.Details := [];
			SELF.Coastguard := [];
		END;
			
		Watercraft_owners_rolled := ROLLUP(GROUP(SORT(owners_recs_out, state_origin,watercraft_key,sequence_key), 
																						state_origin,watercraft_key,sequence_key), 
																			GROUP, xfRollOwners(LEFT, ROWS(LEFT)));	

		Watercraft_out xfAddDetails(Watercraft_out le, DATASET(Watercraft_info_out) info_rows) := 
		TRANSFORM
			SELF.Details := info_rows;
			SELF := le;
		END;
			
		Watercraft_info_owners_recs := DENORMALIZE(Watercraft_owners_rolled, Watercraft_info_recs_out, 
														LEFT.state_origin = RIGHT.state_origin AND
														LEFT.watercraft_key = RIGHT.watercraft_key AND
														LEFT.sequence_key = RIGHT.sequence_key,
														GROUP, 
														xfAddDetails(LEFT, ROWS(RIGHT)));		

		Watercraft_out xfAddCoastguards(Watercraft_out le, DATASET(coastguard_out) c_rows) := 
		TRANSFORM
			SELF.Coastguard := c_rows;
			SELF := le;
		END;
			
		recs_out := DENORMALIZE(Watercraft_info_owners_recs, Watercraft_coastguard_recs_out, 
														LEFT.state_origin = RIGHT.state_origin AND
														LEFT.watercraft_key = RIGHT.watercraft_key AND
														LEFT.sequence_key = RIGHT.sequence_key,
														GROUP, 
														xfAddCoastguards(LEFT, ROWS(RIGHT)));		

			
			IF(ConsumerDisclosure.Debug,OUTPUT(id_recs, NAMED('Watercraft_ids')));
			IF(ConsumerDisclosure.Debug,OUTPUT(Watercraft_coastguard_suppressed_recs, NAMED('Watercraft_coastguard_suppressed_recs')));
			IF(ConsumerDisclosure.Debug,OUTPUT(Watercraft_coastguard_override_recs, NAMED('Watercraft_coastguard_override_recs')));
			IF(ConsumerDisclosure.Debug,OUTPUT(Watercraft_coastguard_payload_recs, NAMED('Watercraft_coastguard_payload_recs')));
			IF(ConsumerDisclosure.Debug,OUTPUT(Watercraft_info_suppressed_recs, NAMED('Watercraft_info_suppressed_recs')));
			IF(ConsumerDisclosure.Debug,OUTPUT(Watercraft_info_override_recs, NAMED('Watercraft_info_override_recs')));
			IF(ConsumerDisclosure.Debug,OUTPUT(Watercraft_info_payload_recs, NAMED('Watercraft_info_payload_recs')));
			IF(ConsumerDisclosure.Debug,OUTPUT(owners_suppressed_recs, NAMED('Watercraft_owners_suppressed_recs')));
			IF(ConsumerDisclosure.Debug,OUTPUT(owners_override_recs, NAMED('Watercraft_owners_override_recs')));
			IF(ConsumerDisclosure.Debug,OUTPUT(owners_payload_recs, NAMED('Watercraft_owners_payload_recs')));
			IF(ConsumerDisclosure.Debug,OUTPUT(recs_out, NAMED('Watercraft_recs')));

		RETURN recs_out;
	END;


END;