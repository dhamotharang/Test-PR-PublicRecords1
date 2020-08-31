/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, doxie, FCRA, FFD, Thrive, MDR,STD,UT;

layout_thrive_raw := RECORD(Thrive.layouts.baseOld)  //recordof(Thrive.keys().did_fcra.qa)
END;

layout_thrive_rawrec := RECORD(layout_thrive_raw)
  $.Layouts.InternalMetadata;
END;


EXPORT RawThrive := MODULE

  EXPORT layout_thrive_out := RECORD($.Layouts.Metadata)
    layout_thrive_raw;
  END;

  EXPORT GetData(DATASET(doxie.layout_references) in_dids,
                DATASET (FFD.Layouts.flag_ext_rec) flag_file,
                DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
                $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
    todaysdate := (STRING8) STD.Date.Today();

    pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.THRIVE);
    all_flags := flag_file(file_id = FCRA.FILE_ID.THRIVE);

    flag_recs :=
      JOIN(all_flags, FCRA.Key_Override_Thrive_ffid.thrive,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_thrive_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.persistent_record_id='' OR RIGHT.persistent_record_id=LEFT.record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    override_recs := flag_recs(compliance_flags.isOverride);
    suppressed_recs := flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    override_ids := SET(override_recs, combined_record_id);
    suppressed_ids := SET(suppressed_recs, combined_record_id);

    main_recs := JOIN(in_dids, Thrive.keys().did_fcra.qa,
                          KEYED(LEFT.did = RIGHT.did),
                           TRANSFORM(layout_thrive_rawrec,
                                    SELF.compliance_flags.IsOverwritten :=
                                      (RIGHT.persistent_record_id<>'' AND (STRING)RIGHT.persistent_record_id IN override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (RIGHT.persistent_record_id<>'' AND (STRING)RIGHT.persistent_record_id IN suppressed_ids),
                                    SELF.subject_did := LEFT.did,
                                    SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxThrivePerDID));


    recs_all := main_recs + override_recs;

    recs_filt:= recs_all(
      in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed,
      src = MDR.sourceTools.src_Thrive_PD,  // should we filter by src?
      $.Functions.FCRADateIsOk((STRING8)dt_first_seen, todaysdate)
      );

    layout_thrive_rawrec xformStatements(layout_thrive_rawrec l,  FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_ids := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    recs_final_ds := JOIN(recs_filt, pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.record_ids.RecID1 = RIGHT.RecID1,
                          xformStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    recs_out := PROJECT(recs_final_ds, TRANSFORM(layout_thrive_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_ids,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.THRIVE);
                        SELF := LEFT;
                        ));

    IF(ConsumerDisclosure.Debug AND in_mod.IncludeThrive,OUTPUT(suppressed_recs, NAMED('Thrive_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeThrive,OUTPUT(override_recs, NAMED('Thrive_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeThrive,OUTPUT(main_recs, NAMED('Thrive_main_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeThrive,OUTPUT(recs_out, NAMED('Thrive_recs')));

    RETURN SORT(recs_out, -dt_last_seen, -dt_first_seen, RECORD);
  END;

END;
