/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, doxie, FCRA, FFD, PAW;

layout_PAW_raw := PAW.Layout.Employment_Out;  // recordof(PAW.Key_DID_FCRA)

layout_PAW_rawrec := RECORD(layout_PAW_raw)
  $.Layouts.InternalMetadata;
END;

EXPORT RawPeopleAtWork := MODULE

  EXPORT layout_PAW_out := RECORD($.Layouts.Metadata)
    layout_PAW_raw;
  END;

  EXPORT GetData(DATASET(doxie.layout_references) in_dids,
                DATASET (FFD.Layouts.flag_ext_rec) flagfile,
                DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
                $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

    pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.PAW);
    all_flags := flagfile(file_id = FCRA.FILE_ID.PAW);

    flag_recs :=
      JOIN(all_flags, FCRA.key_override_paw_ffid,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_PAW_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.contact_id=0 OR LEFT.record_id=(STRING) RIGHT.contact_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.contact_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    override_recs := flag_recs(Compliance_Flags.isOverride);
    suppressed_recs := flag_recs(Compliance_Flags.isSuppressed AND ~Compliance_Flags.isOverride);

    override_ids := SET(override_recs, combined_record_id);
    suppressed_ids := SET(suppressed_recs, combined_record_id);

    main_recs := JOIN(in_dids, PAW.Key_DID_FCRA,
                          KEYED(LEFT.did = RIGHT.did),
                          TRANSFORM(layout_PAW_rawrec,
                                    SELF.compliance_flags.IsOverwritten :=
                                      (RIGHT.contact_id>0 AND (STRING) RIGHT.contact_id IN override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (RIGHT.contact_id>0 and (STRING) RIGHT.contact_id IN suppressed_ids),
                                    SELF.subject_did := LEFT.did,
                                    SELF.Record_Ids.RecId1 := (STRING) RIGHT.contact_id,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxPAWPerDID));


    recs_all := main_recs + override_recs;

    recs_filt:= recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
      );

    //add statementids  & add dispute indicators/remove disputed records

    layout_PAW_rawrec xformStatements( layout_PAW_rawrec l,  FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
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

    recs_out := PROJECT(recs_final_ds, TRANSFORM(layout_PAW_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_IDs,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.PAW);
                        SELF := LEFT;
                        ));

    IF(ConsumerDisclosure.Debug AND in_mod.IncludePAW,OUTPUT(suppressed_recs, NAMED('PAW_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludePAW,OUTPUT(override_recs, NAMED('PAW_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludePAW,OUTPUT(main_recs, NAMED('PAW_main_recs')));

    RETURN SORT(recs_out, -dt_last_seen, -dt_first_seen, RECORD);
  END;

END;
