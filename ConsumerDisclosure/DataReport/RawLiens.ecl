/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, BIPV2, ConsumerDisclosure, doxie, FCRA, FFD, LiensV2, Suppress, STD;

todaysdate := (STRING8) STD.Date.Today();

layout_liens_main_raw := RECORD(LiensV2.Layout_liens_main_module.layout_liens_main) // RECORDOF(liensv2.key_liens_main_id_FCRA)
END; 
	
layout_liens_party_raw := RECORD // RECORDOF(liensv2.key_liens_party_id_FCRA)
    liensv2.layout_liens_party;
    BIPV2.IDlayouts.l_xlink_ids;
    unsigned4 global_sid;
    unsigned8 record_sid;
    string10 orig_rmsid;
END; 
	
layout_liens_party_rawrec := RECORD(layout_liens_party_raw)
		$.Layouts.InternalMetadata;
END;
	
layout_liens_main_rawrec := RECORD(layout_liens_main_raw)
		$.Layouts.InternalMetadata;
END;
	
EXPORT RawLiens := MODULE

	EXPORT layout_liens_party_out := RECORD($.Layouts.Metadata)
		layout_liens_party_raw;
	END;

	EXPORT layout_liens_main_out := RECORD($.Layouts.Metadata)
		layout_liens_main_raw;
	END;

	EXPORT layout_liens_out := RECORD
		STRING50 tmsid;
		STRING50 rmsid;
		STRING orig_filing_date := '';
		DATASET(layout_liens_main_out) Main;
		DATASET(layout_liens_party_out) Parties;
	END;
	
	BOOLEAN IsFCRA := TRUE;

	EXPORT GetData(DATASET(doxie.layout_references) in_dids,
								DATASET (fcra.Layout_override_flag) flag_file,
								DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,														 
							 $.IParams.IParam in_mod) := 
 FUNCTION

	BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
	
	liens_main_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.LIEN_MAIN);
	liens_party_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.LIEN_PARTY);
	liens_flags := flag_file(file_id = FCRA.FILE_ID.LIEN);
	
	main_flag_recs := 
		JOIN(liens_flags, FCRA.key_Override_liensv2_main_ffid, 
			KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
			TRANSFORM(layout_liens_main_rawrec,
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

	main_override_recs := main_flag_recs(compliance_flags.isOverride);	
	main_suppressed_recs := main_flag_recs(compliance_flags.isSuppressed);		

	main_override_ids := SET(main_override_recs, combined_record_id);	
	main_suppressed_ids := SET(main_suppressed_recs, combined_record_id);

	id_recs := JOIN(in_dids,liensv2.key_liens_DID_FCRA,
			            KEYED(left.did=right.did),
									TRANSFORM(RIGHT),
									LIMIT(0),KEEP($.Constants.Limits.MaxLiensPerDID)); 
									
	// join to payload key.
	main_payload_recs := JOIN(id_recs,liensv2.key_liens_main_id_FCRA,
												KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid=RIGHT.rmsid),
												TRANSFORM(layout_liens_main_rawrec,
																	rec_id_oldway := TRIM((STRING50)RIGHT.tmsid + (STRING50)RIGHT.rmsid);											
																	SELF.compliance_flags.IsOverwritten :=
																		(rec_id_oldway<>'' AND rec_id_oldway IN main_override_ids) OR 
																		(RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN main_override_ids), 
																	SELF.compliance_flags.IsSuppressed :=
																		(rec_id_oldway<>'' AND rec_id_oldway IN main_suppressed_ids) OR 
																		(RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN main_suppressed_ids), 
																	SELF.subject_did := LEFT.did,
																	SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
																	SELF := RIGHT,
																	SELF := LEFT,
																	SELF := []),
																	LIMIT(0), KEEP($.Constants.Limits.MaxLiens));
																

	main_recs_all := main_payload_recs + main_override_recs;
	
	main_recs_filt:= main_recs_all(
		in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
		in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed,
		$.Functions.FCRADateIsOk(orig_filing_date, todaysdate)
		);   
										
			
		layout_liens_main_rawrec xformStatements( layout_liens_main_rawrec l,	FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
			SKIP(~ShowDisputedRecords and r.isDisputed)
					SELF.statement_IDs := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		main_recs_final_ds := JOIN(main_recs_filt, liens_main_pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
													xformStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
		
		main_recs_out := PROJECT(main_recs_final_ds, TRANSFORM(layout_liens_main_out,			
												SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_IDs,
																								LEFT.subject_did,
																								FFD.Constants.DataGroups.LIEN_MAIN);
												SELF := LEFT;			
												));			
												
		
		liens_party_flag_recs := 
			JOIN(liens_flags, FCRA.key_Override_liensv2_party_ffid, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(layout_liens_party_rawrec,
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

		liens_party_override_recs := liens_party_flag_recs(compliance_flags.isOverride);	
		liens_party_suppressed_recs := liens_party_flag_recs(compliance_flags.isSuppressed);		

		liens_party_override_ids := SET(liens_party_override_recs, combined_record_id);	
		liens_party_suppressed_ids := SET(liens_party_suppressed_recs, combined_record_id);

		liens_party_payload_recs := JOIN(id_recs, liensv2.key_liens_party_id_FCRA,
													KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid), 
													TRANSFORM(layout_liens_party_rawrec,
																		rec_id_oldway := TRIM((STRING50)RIGHT.tmsid + (STRING50)RIGHT.rmsid);											
																		SELF.compliance_flags.IsOverwritten :=
																			(rec_id_oldway<>'' AND rec_id_oldway IN liens_party_override_ids) OR 
																			(RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN liens_party_override_ids), 
																		SELF.compliance_flags.IsSuppressed :=
																			(rec_id_oldway<>'' AND rec_id_oldway IN liens_party_suppressed_ids) OR 
																			(RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN liens_party_suppressed_ids), 
																		SELF.subject_did := LEFT.did,
																		SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
																		SELF := RIGHT,
																		SELF := []),
																		LIMIT(0), KEEP($.Constants.Limits.MaxLiens));
																	

		liens_party_recs_all := liens_party_payload_recs + liens_party_override_recs;
		
		liens_party_recs_filt := liens_party_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
			in_mod.nss <> Suppress.Constants.NonSubjectSuppression.returnBlank OR subject_did=(UNSIGNED)did OR (did='' AND (bdid <> '' OR cname <> ''))
			);
										
		layout_liens_party_rawrec xformPartyStatements(layout_liens_party_rawrec l,	FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		party_recs_final_ds := JOIN(liens_party_recs_filt, liens_party_pc_flags,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
													xformPartyStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		//apply non-subject suppression for restricted
		layout_liens_party_rawrec xformNSS(layout_liens_party_rawrec L) := TRANSFORM
			IsSubject := (L.subject_did = (unsigned6) L.did);
			NotAPerson := (L.did = '') AND ((L.bdid != '') OR (L.cname != ''));
			isRestricted := ~(IsSubject OR NotAPerson);
			// nss restriction is applied to all parties -> name_type=A/C/T/D
      SELF.subject_did := L.subject_did;
      SELF.compliance_flags := L.compliance_flags;
      SELF.record_ids := L.record_ids;
			
      SELF.tmsid := L.tmsid;
      SELF.rmsid := L.rmsid;
      SELF.orig_rmsid := L.orig_rmsid;
      SELF.global_sid := L.global_sid;
      SELF.record_sid := L.record_sid;
      SELF.persistent_record_id := L.persistent_record_id;
      
      SELF.lname := IF (isRestricted, FCRA.Constants.FCRA_Restricted, L.lname);    
      SELF := IF (~isRestricted, L);
			SELF := [];
		END;
		
		liens_party_nss := PROJECT(party_recs_final_ds, xformNSS(LEFT));
		
		liens_party_final_ds := IF(in_mod.nss = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription, 
												liens_party_nss, party_recs_final_ds);  

		party_recs_out := PROJECT(liens_party_final_ds, 
														TRANSFORM(layout_liens_party_out,			
														SELF.Metadata := $.Functions.GetMetadataESDL(
																								LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_IDs,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.LIEN_PARTY),
														SELF := LEFT)			
													);	
													
		// Now combining data sets for final output
		layout_liens_out xfRollMain(layout_liens_main_out le, 
												DATASET(layout_liens_main_out) main_rows) := 
		TRANSFORM
			SELF.tmsid := le.tmsid;
			SELF.rmsid := le.rmsid;
			SELF.orig_filing_date := le.orig_filing_date;
			SELF.Main := main_rows;
			SELF.Parties := [];
		END;
			
		liens_main_rolled := ROLLUP(GROUP(SORT(main_recs_out, tmsid,rmsid,-Orig_Filing_date), tmsid,rmsid), 
																	GROUP, xfRollMain(LEFT, ROWS(LEFT)));	

		layout_liens_out xfAddParties(layout_liens_out le, DATASET(layout_liens_party_out) party_rows) := 
		TRANSFORM
			SELF.Parties := SORT(party_rows, -date_last_seen, date_First_Seen, persistent_record_id);
			SELF := le;
		END;
			
		recs_out := DENORMALIZE(liens_main_rolled, party_recs_out, 
														LEFT.tmsid = RIGHT.tmsid AND
														LEFT.rmsid = RIGHT.rmsid,
														GROUP, 
														xfAddParties(LEFT, ROWS(RIGHT)));		

			
			IF(ConsumerDisclosure.Debug AND in_mod.IncludeLiens,OUTPUT(id_recs, NAMED('liens_id_recs')));
			IF(ConsumerDisclosure.Debug AND in_mod.IncludeLiens,OUTPUT(liens_party_suppressed_recs, NAMED('liens_party_suppressed_recs')));
			IF(ConsumerDisclosure.Debug AND in_mod.IncludeLiens,OUTPUT(liens_party_override_recs, NAMED('liens_party_override_recs')));
			IF(ConsumerDisclosure.Debug AND in_mod.IncludeLiens,OUTPUT(liens_party_payload_recs, NAMED('liens_party_payload_recs')));
			IF(ConsumerDisclosure.Debug AND in_mod.IncludeLiens,OUTPUT(main_suppressed_recs, NAMED('liens_main_suppressed_recs')));
			IF(ConsumerDisclosure.Debug AND in_mod.IncludeLiens,OUTPUT(main_override_recs, NAMED('liens_main_override_recs')));
			IF(ConsumerDisclosure.Debug AND in_mod.IncludeLiens,OUTPUT(main_payload_recs, NAMED('liens_main_payload_recs')));
			IF(ConsumerDisclosure.Debug AND in_mod.IncludeLiens,OUTPUT(recs_out, NAMED('Liens_combined_recs')));

		RETURN SORT(recs_out(EXISTS(Parties)), -orig_filing_date, tmsid, rmsid, RECORD);
	END;

END;