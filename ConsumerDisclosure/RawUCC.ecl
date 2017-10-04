﻿IMPORT doxie, FCRA, FFD, UCCV2, BIPV2, ConsumerDisclosure, MDR, STD, UT, Suppress;
EXPORT RawUCC := MODULE

	SHARED UCC_main_raw := RECORD(UCCV2.Layout_UCC_Common.Layout_ucc_new)
	END;
	
	SHARED UCC_party_raw := RECORD
		UCCV2.Layout_UCC_Common.Layout_party;
		BIPV2.IDlayouts.l_xlink_ids;
		UNSIGNED8 persistent_record_id := 0;	
	END;

	SHARED UCC_main_rawrec := RECORD(UCC_main_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	SHARED UCC_party_rawrec := RECORD(UCC_party_raw)
		ConsumerDisclosure.Layouts.InternalMetadata;
	END;
	
	EXPORT UCC_main_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		UCC_main_raw;
	END;

	EXPORT UCC_party_out := RECORD(ConsumerDisclosure.Layouts.Metadata)
		UCC_party_raw;
	END;

	EXPORT UCC_out := RECORD
    STRING50 tmsid;
		DATASET(UCC_main_out) UCCMain {xpath('UCCMain/Row')};
		DATASET(UCC_party_out) UCCParty {xpath('UCCParty/Row')};
	END;
	
	uid_rec := RECORD
		UNSIGNED6 subject_did;
    STRING50 tmsid;
  END;		 

	BOOLEAN isFCRA := TRUE;
	
	EXPORT GetData(DATASET(doxie.layout_references) in_dids,
								DATASET (fcra.Layout_override_flag) flag_file,
								DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,														 
							  ConsumerDisclosure.IParams.IParam in_mod) := 
	FUNCTION

		BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
	
		pc_flags_main := slim_pc_recs(datagroup = FFD.Constants.DataGroups.UCC);
		flags_main := flag_file(file_id = FCRA.FILE_ID.UCC);
		pc_flags_party := slim_pc_recs(datagroup = FFD.Constants.DataGroups.UCC_PARTY);
		flags_party := flag_file(file_id = FCRA.FILE_ID.UCC_PARTY);
		
		party_flag_recs := 
			JOIN(flags_party, FCRA.key_override_ucc.party, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(UCC_party_rawrec,
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

		party_override_recs := party_flag_recs(compliance_flags.isOverride);	
		party_suppressed_recs := party_flag_recs(compliance_flags.isSuppressed);		

		party_override_ids := SET(party_override_recs, combined_record_id);	
		party_suppressed_ids := SET(party_suppressed_recs, combined_record_id);

		id_recs := JOIN(in_dids,UCCV2.key_did_w_Type(IsFCRA),
			            KEYED(LEFT.did = RIGHT.did),
									TRANSFORM(RIGHT),
									LIMIT(0),KEEP(ConsumerDisclosure.Constants.Limits.MaxUCCPerDID)); 
									
		id_recs_ddp := DEDUP(SORT(id_recs, did,tmsid,rmsid,party_type), did,tmsid,rmsid);
									
		party_payload_recs := JOIN(id_recs_ddp, UCCV2.key_rmsid_party(isFCRA),
													KEYED(LEFT.tmsid = RIGHT.tmsid AND LEFT.rmsid = RIGHT.rmsid),
 													TRANSFORM(UCC_party_rawrec,
																		SELF.compliance_flags.IsOverwritten :=
																			(RIGHT.persistent_record_id>0 AND (STRING)RIGHT.persistent_record_id IN party_override_ids), 
																		SELF.compliance_flags.IsSuppressed :=
																			(RIGHT.persistent_record_id>0 AND (STRING)RIGHT.persistent_record_id IN party_suppressed_ids), 
																		SELF.subject_did := LEFT.did,
																		SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
																		SELF := RIGHT,
																		SELF := LEFT,
																		SELF := []),
																		LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxUCCPerDID));
																	

		party_recs_all := party_payload_recs + party_override_recs;
		
		party_recs_filt := party_recs_all(
			in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed,
		// non subject suppression
		in_mod.nss <> Suppress.Constants.NonSubjectSuppression.returnBlank OR subject_did=(UNSIGNED)did OR
		((did = 0) AND ((bdid != 0) OR (fein != '') OR (company_name != '')))  //party is not a person
			);
										
		UCC_party_rawrec xformPartyStatements(UCC_party_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		party_recs_final_ds := JOIN(party_recs_filt, pc_flags_party,
													LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
													LEFT.record_ids.RecID1 = RIGHT.RecID1,
													xformPartyStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		//apply non-subject suppression for restricted
		UCC_party_rawrec xformNSS(UCC_party_rawrec L) := TRANSFORM
			IsSubject := (L.subject_did = L.did);
 			NotAPerson := (L.did = 0) AND ((L.bdid != 0) OR (L.fein != '') OR (L.company_name != ''));
   
      SELF.subject_did := L.subject_did;
      SELF.compliance_flags := L.compliance_flags;
      SELF.record_ids := L.record_ids;
			
      SELF.tmsid := L.tmsid;
      SELF.persistent_record_id := L.persistent_record_id;
      
      SELF.lname := IF (~(IsSubject OR NotAPerson), FCRA.Constants.FCRA_Restricted, L.lname);    
      SELF := IF (IsSubject OR NotAPerson, L);
			SELF := [];
		END;
		
		party_nss := PROJECT(party_recs_final_ds, xformNSS(LEFT));
		
		party_recs_with_nss := IF(in_mod.nss = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription, 
												party_nss, party_recs_final_ds);  
												
		party_recs_out := PROJECT(party_recs_with_nss, TRANSFORM(UCC_party_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_ids,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.UCC_PARTY);
												SELF := LEFT;			
												));			
	
		party_tmsids := DEDUP(SORT(PROJECT(party_recs_final_ds, uid_rec), subject_did, tmsid), subject_did, tmsid);	
	
		main_flag_recs := 
			JOIN(flags_main, FCRA.key_override_ucc.main, 
				KEYED (LEFT.flag_file_id = RIGHT.flag_file_id), 
				TRANSFORM(UCC_main_rawrec,
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

		main_override_recs := main_flag_recs(Compliance_Flags.isOverride);	
		main_suppressed_recs := main_flag_recs(Compliance_Flags.isSuppressed);		

		main_override_ids := SET(main_override_recs, combined_record_id);	
		main_suppressed_ids := SET(main_suppressed_recs, combined_record_id);

		main_payload_recs := JOIN(party_tmsids, UCCV2.Key_Rmsid_Main(IsFCRA),
													KEYED(LEFT.tmsid = RIGHT.tmsid),
 													TRANSFORM(UCC_main_rawrec,
																		SELF.compliance_flags.IsOverwritten :=
																			(RIGHT.persistent_record_id>0 AND (STRING)RIGHT.persistent_record_id IN main_override_ids), 
																		SELF.compliance_flags.IsSuppressed :=
																			(RIGHT.persistent_record_id>0 AND (STRING)RIGHT.persistent_record_id IN main_suppressed_ids), 
																		SELF.subject_did := LEFT.subject_did,
																		SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
																		SELF := RIGHT,
																		SELF := LEFT,
																		SELF := []),
																		LIMIT(0), KEEP(ConsumerDisclosure.Constants.Limits.MaxUCCPerDID));
																	

		main_recs_all := main_payload_recs + main_override_recs;
	
		main_recs_filt := main_recs_all(
			in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
			in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
			FCRA.compliance.ucc.is_ok((STRING8)Std.Date.Today(), orig_filing_date)
			);
										
		UCC_main_rawrec xformStatements(UCC_main_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
			SKIP(~ShowDisputedRecords AND r.isDisputed)
					SELF.statement_ids := r.StatementIDs;
					SELF.compliance_flags.IsDisputed := r.isDisputed;
					SELF := l;
		END;
			
		main_recs_final_ds := JOIN(main_recs_filt, pc_flags_main,
													LEFT.subject_did = (UNSIGNED6) RIGHT.lexid AND
													LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
													xformStatements(LEFT,RIGHT), 
													LEFT OUTER,
													KEEP(1),
													LIMIT(0));
			
		main_recs_out := PROJECT(main_recs_final_ds, TRANSFORM(UCC_main_out,			
												SELF.Metadata := ConsumerDisclosure.Functions.GetMetadataESDL(LEFT.compliance_flags,
																								LEFT.record_ids,
																								LEFT.statement_ids,
																								LEFT.subject_did, 
																								FFD.Constants.DataGroups.UCC);
												SELF := LEFT;			
												));			

		// Now combining data sets for final output
		UCC_out xfRollMain(UCC_main_out le, 
												DATASET(UCC_main_out) ri) := 
		TRANSFORM
			SELF.tmsid := le.tmsid;
			SELF.UCCmain := ri;
			SELF.UCCparty := [];
		END;
			
		main_recs_rolled := ROLLUP(GROUP(SORT(main_recs_out, tmsid), tmsid), 
																	GROUP, xfRollMain(LEFT, ROWS(LEFT)));	

		UCC_out xfAddParty(UCC_out le, DATASET(UCC_party_out) ri) := 
		TRANSFORM
			SELF.UCCparty := ri;
			SELF := le;
		END;
			
		recs_out := DENORMALIZE(main_recs_rolled, party_recs_out, 
														LEFT.tmsid = RIGHT.tmsid,
														GROUP, 
														xfAddParty(LEFT, ROWS(RIGHT)));		
												
	
		IF(ConsumerDisclosure.Debug,OUTPUT(party_suppressed_recs, NAMED('UCC_party_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(party_override_recs, NAMED('UCC_party_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(party_payload_recs, NAMED('UCC_party_payload_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(party_recs_out, NAMED('UCC_party_recs_out')));
		IF(ConsumerDisclosure.Debug,OUTPUT(main_suppressed_recs, NAMED('UCC_main_suppressed_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(main_override_recs, NAMED('UCC_main_override_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(main_payload_recs, NAMED('UCC_main_payload_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(main_recs_out, NAMED('UCC_main_recs')));
		IF(ConsumerDisclosure.Debug,OUTPUT(recs_out, NAMED('UCC_recs')));
		
		RETURN recs_out;
	END;
	
END;
