/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, doxie, FCRA, FFD, American_Student_List, AlloyMedia_student_list;

layout_ASL_raw := RECORD(American_student_list.layout_american_student_base_v2) //RECORDOF(American_Student_List.key_DID_FCRA)
  UNSIGNED6 l_did;
END;

layout_AlloyMS_raw := AlloyMedia_student_list.layouts.layout_base; //RECORDOF(AlloyMedia_student_list.key_DID_FCRA);

layout_ASL_rawrec := RECORD(layout_ASL_raw)
  $.Layouts.InternalMetadata;
END;

layout_AlloyMS_rawrec := RECORD(layout_AlloyMS_raw)
  $.Layouts.InternalMetadata;
END;


EXPORT RawStudent := MODULE

  EXPORT layout_ASL_out := RECORD($.Layouts.Metadata)
    layout_ASL_raw;
  END;

  EXPORT layout_AlloyMS_out := RECORD($.Layouts.Metadata)
    layout_AlloyMS_raw;
  END;

  // American student list
  EXPORT GetASLData(DATASET(doxie.layout_references) in_dids,
                DATASET (FFD.Layouts.flag_ext_rec) flag_file,
                DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
               $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

    pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.STUDENT);
    all_flags := flag_file(file_id = FCRA.FILE_ID.STUDENT);

    flag_recs :=
      JOIN(all_flags, FCRA.key_override_student_new_ffid,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_ASL_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.key=0 OR LEFT.record_id = (STRING) RIGHT.key);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.key;
          SELF.l_did := RIGHT.did;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    override_recs := flag_recs(compliance_flags.isOverride);
    suppressed_recs := flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    override_ids := SET(override_recs, combined_record_id);
    suppressed_ids := SET(suppressed_recs, combined_record_id);

    main_recs := JOIN(in_dids, American_Student_List.Key_DID_FCRA,
                          KEYED(LEFT.did = RIGHT.l_did),
                          TRANSFORM(layout_ASL_rawrec,
                                    SELF.compliance_flags.IsOverwritten :=
                                      (RIGHT.key<>0 AND (STRING) RIGHT.key IN override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (RIGHT.key<>0 AND (STRING) RIGHT.key IN suppressed_ids),
                                    SELF.subject_did := LEFT.did,
                                    SELF.record_ids.RecId1 := (STRING) RIGHT.key,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxStudentPerDID));


    recs_all := main_recs + override_recs;

    recs_filt := recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
      );

    layout_ASL_rawrec xformStatements(layout_ASL_rawrec l,  FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_ids := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    recs_final_ds := JOIN(recs_filt, pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.key = (INTEGER) RIGHT.RecID1,
                          xformStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    recs_out := PROJECT(recs_final_ds, TRANSFORM(layout_ASL_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_ids,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.STUDENT);
                        SELF := LEFT;
                        ));

    IF(ConsumerDisclosure.Debug AND in_mod.IncludeStudent,OUTPUT(suppressed_recs, NAMED('ASL_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeStudent,OUTPUT(override_recs, NAMED('ASL_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeStudent,OUTPUT(main_recs, NAMED('ASL_main_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeStudent,OUTPUT(recs_out, NAMED('AmericanStudentList_recs')));

    RETURN SORT(recs_out,-date_last_Seen, -date_first_Seen, RECORD);
  END;

  // Alloy Media Student list
  EXPORT GetAlloyMSData(DATASET(doxie.layout_references) in_dids,
                DATASET (FFD.Layouts.flag_ext_rec) flag_file,
                DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
               $.IParams.IParam in_mod) :=
  FUNCTION

  BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

    pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.STUDENT_ALLOY);
    all_flags := flag_file(file_id = FCRA.FILE_ID.STUDENT_ALLOY);

    flag_recs :=
      JOIN(all_flags, FCRA.key_override_alloy_ffid,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_AlloyMS_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          rec_id := TRIM(RIGHT.sequence_number) + TRIM(RIGHT.key_code) + (STRING) RIGHT.rawaid;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.flag_file_id='' OR rec_id=LEFT.record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := RIGHT.sequence_number;
          SELF.record_ids.RecId2 := RIGHT.key_code;
          SELF.record_ids.RecId3 := (STRING) RIGHT.rawaid;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    override_recs := flag_recs(compliance_flags.isOverride);
    suppressed_recs := flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    override_ids := SET(override_recs, combined_record_id);
    suppressed_ids := SET(suppressed_recs, combined_record_id);

    main_recs := JOIN(in_dids, AlloyMedia_student_list.Key_DID_FCRA,
                          KEYED(LEFT.did = RIGHT.did),
                          TRANSFORM(layout_AlloyMS_rawrec,
                                    rec_id := TRIM(RIGHT.sequence_number) + TRIM(RIGHT.key_code) + (STRING) RIGHT.rawaid;
                                    SELF.compliance_flags.IsOverwritten :=
                                      (rec_id<>'' AND rec_id IN override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (rec_id<>'' AND rec_id IN suppressed_ids),
                                    SELF.subject_did := LEFT.did,
                                    SELF.combined_record_id := rec_id;
                                    SELF.record_ids.RecId1 := RIGHT.sequence_number;
                                    SELF.record_ids.RecId2 := RIGHT.key_code;
                                    SELF.record_ids.RecId3 := (STRING) RIGHT.rawaid;
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxStudentPerDID));


    recs_all := main_recs + override_recs;

    recs_filt := recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
      );

    layout_AlloyMS_rawrec xformStatements(layout_AlloyMS_rawrec l,  FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_ids := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    recs_final_ds := JOIN(recs_filt, pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.record_ids.RecID1 = RIGHT.RecID1 AND
                          LEFT.record_ids.RecID2 = RIGHT.RecID2 AND
                          LEFT.record_ids.RecID3 = RIGHT.RecID3,
                          xformStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    recs_out := PROJECT(recs_final_ds, TRANSFORM(layout_AlloyMS_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_ids,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.STUDENT_ALLOY);
                        SELF := LEFT;
                        ));

    IF(ConsumerDisclosure.Debug AND in_mod.IncludeStudent,OUTPUT(suppressed_recs, NAMED('AlloyMS_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeStudent,OUTPUT(override_recs, NAMED('AlloyMS_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeStudent,OUTPUT(main_recs, NAMED('AlloyMS_main_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeStudent,OUTPUT(recs_out, NAMED('AlloyMediaStudent_recs')));

    RETURN SORT(recs_out,-date_last_Seen, -date_first_Seen, RECORD);
  END;

END;
