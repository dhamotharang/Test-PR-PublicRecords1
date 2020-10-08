/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, doxie, FCRA, FFD, Marriage_Divorce_v2, Suppress;

BOOLEAN IsFCRA := TRUE;

layout_MD_party_raw := RECORD(marriage_divorce_v2.layout_mar_div_search) // RECORDOF(marriage_divorce_v2.key_mar_div_id_search)
END;

layout_MD_raw := RECORD(marriage_divorce_v2.layout_mar_div_base_slim) // RECORDOF(marriage_divorce_v2.key_mar_div_id_main)
END;

layout_MD_party_rawrec := RECORD(layout_MD_party_raw)
    $.Layouts.InternalMetadata;
END;

layout_MD_rawrec := RECORD(layout_MD_raw)
    $.Layouts.InternalMetadata;
END;

EXPORT RawMarriageDivorce := MODULE

  EXPORT layout_MD_party_out := RECORD($.Layouts.Metadata)
    layout_MD_party_raw;
  END;

  EXPORT layout_MD_main_out := RECORD($.Layouts.Metadata)
    layout_MD_raw;
  END;

  EXPORT layout_MD_out := RECORD
    UNSIGNED6 record_id;
    UNSIGNED3 dt_first_seen; // for sorting
    UNSIGNED3 dt_last_seen;  // for sorting
    STRING8   process_date;  // for sorting
    DATASET(layout_MD_main_out) Main;
    DATASET(layout_MD_party_out) Parties;
  END;


  EXPORT GetData(DATASET(doxie.layout_references) in_dids,
                 DATASET (FFD.Layouts.flag_ext_rec) flag_file,
                 DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
                 $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

    md_main_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.MARRIAGE);
    md_main_flags := flag_file(file_id = FCRA.FILE_ID.MARRIAGE);

    md_party_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.MARRIAGE_SEARCH);
    md_party_flags := flag_file(file_id = FCRA.FILE_ID.MARRIAGE_SEARCH);

    main_flag_recs :=
      JOIN(md_main_flags, FCRA.key_override_marriage.marriage_main,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_MD_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.persistent_record_id=0 OR LEFT.record_id=(STRING) RIGHT.persistent_record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    main_override_recs := main_flag_recs(compliance_flags.isOverride);
    main_suppressed_recs := main_flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    main_override_ids := SET(main_override_recs, combined_record_id);
    main_suppressed_ids := SET(main_suppressed_recs, combined_record_id);

    id_recs := JOIN(in_dids,marriage_divorce_v2.key_mar_div_did(isFCRA),
                    KEYED(left.did=right.did),
                    TRANSFORM(RIGHT),
                    LIMIT(0),KEEP($.Constants.Limits.MaxMDPerDID));

    // join to payload key.
    main_payload_recs := JOIN(id_recs,Marriage_Divorce_v2.key_mar_div_id_main(isFCRA),
                          KEYED(LEFT.record_id = RIGHT.record_id),
                          TRANSFORM(layout_MD_rawrec,
                                    SELF.compliance_flags.IsOverwritten :=
                                      (RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN main_override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (RIGHT.persistent_record_id>0 and (STRING) RIGHT.persistent_record_id IN main_suppressed_ids),
                                    SELF.subject_did := LEFT.did,
                                    SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxMDPerDID));


    main_recs_all := main_payload_recs + main_override_recs;

    main_recs_filt:= main_recs_all(
      in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed
      );   // should we filter per industry class ?


    layout_MD_rawrec xformStatements( layout_MD_rawrec l,  FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
      SKIP(~ShowDisputedRecords and r.isDisputed)
          SELF.statement_IDs := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    main_recs_final_ds := JOIN(main_recs_filt, md_main_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
                          xformStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    main_recs_out := PROJECT(main_recs_final_ds, TRANSFORM(layout_MD_main_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_IDs,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.MARRIAGE);
                        SELF := LEFT;
                        ));


    MD_party_flag_recs :=
      JOIN(md_party_flags, FCRA.key_override_marriage.marriage_search,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_MD_party_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.persistent_record_id=0 OR LEFT.record_id=(STRING) RIGHT.persistent_record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    MD_party_override_recs := MD_party_flag_recs(compliance_flags.isOverride);
    MD_party_suppressed_recs := MD_party_flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    MD_party_override_ids := SET(MD_party_override_recs, combined_record_id);
    MD_party_suppressed_ids := SET(MD_party_suppressed_recs, combined_record_id);

    MD_party_payload_recs := JOIN(id_recs, marriage_divorce_v2.key_mar_div_id_search(IsFCRA),
                          KEYED(LEFT.record_id = RIGHT.record_id),
                          TRANSFORM(layout_MD_party_rawrec,
                                    SELF.compliance_flags.IsOverwritten :=
                                      (RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN MD_party_override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (RIGHT.persistent_record_id>0 and (STRING) RIGHT.persistent_record_id IN MD_party_suppressed_ids),
                                    SELF.subject_did := LEFT.did,
                                    SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
                                    SELF := RIGHT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxMDParties));


    MD_party_recs_all := MD_party_payload_recs + MD_party_override_recs;

    MD_party_recs_filt := MD_party_recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
      in_mod.nss != Suppress.Constants.NonSubjectSuppression.returnBlank OR subject_did=did
      );

    layout_MD_party_rawrec xformPartyStatements(layout_MD_party_rawrec l,  FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_ids := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    party_recs_final_ds := JOIN(MD_party_recs_filt, md_party_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
                          xformPartyStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    //apply non-subject suppression for restricted
    layout_MD_party_rawrec xformNSS(layout_MD_party_rawrec L) := TRANSFORM
      IsSubject := (L.subject_did = (unsigned6) L.did);

      SELF.subject_did := L.subject_did;
      SELF.compliance_flags := L.compliance_flags;
      SELF.record_ids := L.record_ids;

      SELF.record_id := L.record_id;
      SELF.persistent_record_id := L.persistent_record_id;

      SELF.lname := IF (~IsSubject, FCRA.Constants.FCRA_Restricted, L.lname);
      SELF := IF (IsSubject, L);
      SELF := [];
    END;

    md_party_nss := PROJECT(party_recs_final_ds, xformNSS(LEFT));

    md_party_final_ds := IF(in_mod.nss = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription,
                        md_party_nss, party_recs_final_ds);

    party_recs_out := PROJECT(md_party_final_ds,
                            TRANSFORM(layout_MD_party_out,
                            SELF.Metadata := $.Functions.GetMetadataESDL(
                                                LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_IDs,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.MARRIAGE_SEARCH),
                            SELF := LEFT)
                          );

    // Now combining data sets for final output
    layout_MD_out xfRollMain(layout_MD_main_out le,
                        DATASET(layout_MD_main_out) main_rows) :=
    TRANSFORM
      SELF.record_id := le.record_id;
      SELF.dt_last_seen := le.dt_last_seen;
      SELF.dt_first_seen := MIN(main_rows,main_rows.dt_first_seen);
      SELF.process_date := MAX(main_rows,main_rows.process_date);
      SELF.Main := SORT(main_rows, -dt_last_seen, dt_first_seen,-process_date);
      SELF.Parties := [];
    END;

    md_main_rolled := ROLLUP(GROUP(SORT(main_recs_out, record_id, -dt_last_seen), record_id),
                                  GROUP, xfRollMain(LEFT, ROWS(LEFT)));

    layout_MD_out xfAddParties(layout_MD_out le, DATASET(layout_MD_party_out) party_rows) :=
    TRANSFORM
      SELF.Parties := SORT(party_rows, -dt_last_seen, dt_first_seen);
      SELF := le;
    END;

    recs_out := DENORMALIZE(md_main_rolled, party_recs_out,
                            LEFT.record_id = RIGHT.record_id,
                            GROUP,
                            xfAddParties(LEFT, ROWS(RIGHT)));


    IF(ConsumerDisclosure.Debug AND in_mod.IncludeMarriageDivorce,OUTPUT(id_recs, NAMED('MD_ids')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeMarriageDivorce,OUTPUT(MD_party_suppressed_recs, NAMED('MD_party_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeMarriageDivorce,OUTPUT(MD_party_override_recs, NAMED('MD_party_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeMarriageDivorce,OUTPUT(MD_party_payload_recs, NAMED('MD_party_payload_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeMarriageDivorce,OUTPUT(main_suppressed_recs, NAMED('MD_main_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeMarriageDivorce,OUTPUT(main_override_recs, NAMED('MD_main_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeMarriageDivorce,OUTPUT(main_payload_recs, NAMED('MD_main_payload_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeMarriageDivorce,OUTPUT(recs_out, NAMED('MD_combined_recs')));

    RETURN SORT(recs_out, -dt_last_seen, dt_first_seen,-process_date, record_id);
  END;

END;
