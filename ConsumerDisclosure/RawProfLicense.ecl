﻿IMPORT doxie, FCRA, FFD, Prof_LicenseV2, Prof_License_Mari, ConsumerDisclosure;
EXPORT RawProfLicense := MODULE

	SHARED ProfLicense_raw := RECORD
    UNSIGNED6 did;
    Prof_LicenseV2.Layouts_ProfLic.Layout_Base  -[did];  
	END;

	SHARED ProfLicense_rawrec := RECORD(ProfLicense_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	EXPORT ProfLicense_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		ProfLicense_raw;
	END;

	SHARED ProfLicenseMari_raw := RECORD
    UNSIGNED6 s_did;
    Prof_License_Mari.layouts.final  -[enh_did_src];  
	END;

	SHARED ProfLicenseMari_rawrec := RECORD(ProfLicenseMari_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	EXPORT ProfLicenseMari_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		ProfLicenseMari_raw;
	END;
	
	SHARED BOOLEAN IsFCRA := TRUE;

	EXPORT GetV2Data(DATASET(doxie.layout_references) in_dids,
								DATASET (fcra.Layout_override_flag) flag_file,
								DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,														 
							 ConsumerDisclosure.IParams.IParam in_mod) := 
	FUNCTION

		BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
	
		pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.PROFLIC);
		all_flags := flag_file(file_id = FCRA.FILE_ID.PROFLIC);
	
		flag_recs := 
			JOIN(all_flags, FCRA.key_override_proflic_ffid, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(ProfLicense_rawrec,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := RIGHT.prolic_key;
					SELF.did := (UNSIGNED) RIGHT.did;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		override_recs := flag_recs(compliance_flags.isOverride);	
		suppressed_recs := flag_recs(compliance_flags.isSuppressed);		

		override_ids := SET(override_recs, combined_record_id);	
		suppressed_ids := SET(suppressed_recs, combined_record_id);

		main_recs := JOIN(in_dids, Prof_LicenseV2.Key_Proflic_Did(IsFCRA),
													KEYED(LEFT.did = RIGHT.did),
													TRANSFORM(ProfLicense_rawrec,
																		SELF.compliance_flags.IsOverwritten :=
																			(RIGHT.prolic_key<>'' AND RIGHT.prolic_key IN override_ids), 
																		SELF.compliance_flags.IsSuppressed :=
																			(RIGHT.prolic_key<>'' and RIGHT.prolic_key IN suppressed_ids), 
																		SELF.subject_did := LEFT.did,
																		SELF.record_ids.RecId1 := RIGHT.prolic_key,
																		SELF := RIGHT,
																		SELF := LEFT,
																		SELF := []),
																		LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxProfLicensePerDID));
																	

		recs_all := main_recs + override_recs;
		
		recs_filt:= recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
			);
		
		// - no groupping/rolling of records by prolic_key
	
		ProfLicense_rawrec xformStatements(ProfLicense_rawrec l,	FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		recs_final_ds := JOIN(recs_filt, pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.record_ids.RecId1 = RIGHT.RecID1,
													xformStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		recs_out := PROJECT(recs_final_ds, TRANSFORM(ProfLicense_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_ids,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.PROFLIC);
												SELF := LEFT;			
												));			
												
		IF(ConsumerDisclosure.Debug,OUTPUT(suppressed_recs, NAMED('ProfLicense_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(override_recs, NAMED('ProfLicense_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(main_recs, NAMED('ProfLicense_main_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(recs_out, NAMED('ProfLicense_recs')));
		
		RETURN recs_out;
	END;

	EXPORT GetMariData(DATASET(doxie.layout_references) in_dids,
								DATASET (fcra.Layout_override_flag) flag_file,
								DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,														 
							  ConsumerDisclosure.IParams.IParam in_mod) := 
	FUNCTION

		BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
	
		pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.MARI);
		all_flags := flag_file(file_id = FCRA.FILE_ID.MARI);
		
		flag_recs := 
			JOIN(all_flags, FCRA.Key_Override_Proflic_Mari_ffid.proflic_mari, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(ProfLicenseMari_rawrec,
					is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
					SELF.compliance_flags.isOverride := is_override;
					SELF.compliance_flags.isSuppressed := ~is_override;
					SELF.subject_did := (UNSIGNED6) LEFT.did;
					SELF.combined_record_id := LEFT.record_id;
					SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id;
					SELF.did := (UNSIGNED) RIGHT.did;
					SELF := RIGHT;
					SELF := LEFT;
					SELF := []),
				LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0)); 

		override_recs := flag_recs(compliance_flags.isOverride);	
		suppressed_recs := flag_recs(compliance_flags.isSuppressed);		

		override_ids := SET(override_recs, combined_record_id);	
		suppressed_ids := SET(suppressed_recs, combined_record_id);

		main_recs := JOIN(in_dids, Prof_License_Mari.key_did(IsFCRA),
													KEYED(LEFT.did = RIGHT.s_did),
													TRANSFORM(ProfLicenseMari_rawrec,
																		SELF.compliance_flags.IsOverwritten :=
																			(RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN override_ids), 
																		SELF.compliance_flags.IsSuppressed :=
																			(RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN suppressed_ids), 
																		SELF.subject_did := LEFT.did,
																		SELF.record_ids.RecId1 := (STRING)RIGHT.persistent_record_id,
																		SELF := RIGHT,
																		SELF := LEFT,
																		SELF := []),
																		LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxProfLicensePerDID));
																	

		recs_all := main_recs + override_recs;
		
		recs_filt:= recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
			);
		
		ProfLicenseMari_rawrec xformStatements(ProfLicenseMari_rawrec l,	FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		recs_final_ds := JOIN(recs_filt, pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.record_ids.RecId1 = RIGHT.RecID1,
													xformStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		recs_out := PROJECT(recs_final_ds, TRANSFORM(ProfLicenseMari_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_ids,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.MARI);
												SELF := LEFT;			
												));			
												
		IF(ConsumerDisclosure.Debug,OUTPUT(suppressed_recs, NAMED('ProfLicenseMari_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(override_recs, NAMED('ProfLicenseMari_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(main_recs, NAMED('ProfLicenseMari_main_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(recs_out, NAMED('ProfLicenseMari_recs')));
		
		RETURN recs_out;
	END;

END;