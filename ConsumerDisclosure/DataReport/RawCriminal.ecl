/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, doxie, FCRA, FFD, Corrections, doxie_files, STD;

BOOLEAN IsFCRA := TRUE;
                                  // recordof(doxie_files.Key_Offenders_OffenderKey(true))
layout_offender_raw := RECORD  // recordof(doxie_files.Key_Offenders(true))
  Corrections.layout_offender;
END;

layout_offense_raw := RECORD  // recordof(doxie_files.Key_Offenses(true))
  corrections.layout_offense_common;
END;

layout_punishment_raw := RECORD  // recordof(doxie_files.Key_Punishment(true))
  corrections.Layout_CrimPunishment;
END;

layout_court_offense_raw := RECORD  // recordof(doxie_files.key_court_offenses(true))
  corrections.Layout_CourtOffenses;
END;

layout_court_offense_rawrec := RECORD(layout_court_offense_raw)
  $.Layouts.InternalMetadata;
END;

layout_punishment_rawrec := RECORD(layout_punishment_raw)
  $.Layouts.InternalMetadata;
END;

layout_offense_rawrec := RECORD(layout_offense_raw)
  $.Layouts.InternalMetadata;
END;

layout_offender_rawrec := RECORD(layout_offender_raw)
  $.Layouts.InternalMetadata;
END;

layout_ofk_rec := RECORD
  STRING offender_key;
  UNSIGNED6 subject_did := 0;
END;

EXPORT RawCriminal := MODULE

  EXPORT layout_court_offense_out := RECORD($.Layouts.Metadata)
    layout_court_offense_raw;
  END;

  EXPORT layout_punishment_out := RECORD($.Layouts.Metadata)
    layout_punishment_raw;
  END;

  EXPORT layout_offense_out := RECORD($.Layouts.Metadata)
    layout_offense_raw;
  END;

  EXPORT layout_offender_out := RECORD($.Layouts.Metadata)
    layout_offender_raw;
  END;

  EXPORT layout_criminal_rec_out := RECORD
    STRING60 offender_key;
    STRING8  process_date;  // for sorting purpose
    DATASET(layout_offender_out) Offenders;
    DATASET(layout_offender_out) OffenderPlus;
    DATASET(layout_offense_out)  Offenses;
    DATASET(layout_court_offense_out) CourtOffenses;
    DATASET(layout_punishment_out) Punishments;
  END;

  EXPORT GetData(
    DATASET(doxie.layout_references) in_dids,
    DATASET (FFD.Layouts.flag_ext_rec) flag_file,
    DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
    $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
    todaysdate := (STRING8) STD.Date.Today();

    //-----OFFENDERS------------------
    offenders_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.OFFENDERS);
    offenders_all_flags := flag_file(file_id = FCRA.FILE_ID.OFFENDERS);

    offenders_flag_recs :=
      JOIN(offenders_all_flags, FCRA.key_override_crim.offenders,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_offender_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          offender_key := (STRING) RIGHT.offender_key;
          RecId1 := offender_key[1..50];
          RecId2 := offender_key[51..]; // Offender keys with over 50 chars are split into RecId1 & RecId2
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.offender_key='' OR LEFT.record_id=RIGHT.offender_key);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := RecId1;
          SELF.record_ids.RecId2 := RecId2;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    offenders_override_recs := offenders_flag_recs(compliance_flags.isOverride);
    offenders_suppressed_recs := offenders_flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    offenders_override_ids := SET(offenders_override_recs, combined_record_id);
    offenders_suppressed_ids := SET(offenders_suppressed_recs, combined_record_id);

    offenders_main_recs := JOIN(in_dids, doxie_files.Key_Offenders(isFCRA),
      KEYED(LEFT.did = RIGHT.sdid) AND
      FCRA.crim_is_ok (todaysdate, RIGHT.fcra_date, RIGHT.fcra_conviction_flag, RIGHT.fcra_traffic_flag),
      TRANSFORM(layout_offender_rawrec,
        offender_key := (STRING) RIGHT.offender_key;
        RecId1 := offender_key[1..50];
        RecId2 := offender_key[51..]; // Offender keys with over 50 chars are split into RecId1 & RecId2
        SELF.compliance_flags.IsOverwritten := (RIGHT.offender_key<>'' AND RIGHT.offender_key IN offenders_override_ids);
        SELF.compliance_flags.IsSuppressed := (RIGHT.offender_key<>'' AND RIGHT.offender_key IN offenders_suppressed_ids);
        SELF.subject_did := LEFT.did;
        SELF.record_ids.RecId1 := RecId1;
        SELF.record_ids.RecId2 := RecId2;
        SELF := RIGHT;
        SELF := LEFT;
        SELF := []), // recid3, recid4
      LIMIT(0), KEEP($.Constants.Limits.MaxCrimOffendersPerDID));

    offenders_recs_all := offenders_main_recs + offenders_override_recs;

    offender_recs_filt := offenders_recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
      FCRA.crim_is_ok (todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag)
      );

    layout_offender_rawrec xformOffenderStatements(layout_offender_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_IDs := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    offender_recs_with_pc := JOIN(offender_recs_filt, offenders_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.offender_key = RIGHT.RecID1,
                          xformOffenderStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    offender_recs_out := PROJECT(offender_recs_with_pc,
                                  TRANSFORM(layout_offender_out,
                                    SELF.Metadata := $.Functions.GetMetadataESDL(
                                                      LEFT.compliance_flags,
                                                      LEFT.record_ids,
                                                      LEFT.statement_IDs,
                                                      LEFT.subject_did,
                                                      FFD.Constants.DataGroups.OFFENDERS),
                                    SELF := LEFT));

    id_recs := DEDUP(PROJECT(offender_recs_with_pc,layout_ofk_rec),ALL);

  // -------------  OFFENSES  -------------

    offense_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.OFFENSES);
    offense_all_flags := flag_file(file_id = FCRA.FILE_ID.OFFENSES);

    offense_flag_recs :=
      JOIN(offense_all_flags, FCRA.key_override_crim.offenses,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_offense_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.offense_persistent_id=0 OR LEFT.record_id=(STRING) RIGHT.offense_persistent_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.offense_persistent_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    offense_override_recs := offense_flag_recs(compliance_flags.isOverride);
    offense_suppressed_recs := offense_flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    offense_override_ids := SET(offense_override_recs, combined_record_id);
    offense_suppressed_ids := SET(offense_suppressed_recs, combined_record_id);

    offense_main_recs := JOIN(id_recs, doxie_files.Key_Offenses(isFCRA),
      KEYED(LEFT.offender_key = RIGHT.ok),
      TRANSFORM(layout_offense_rawrec,
        SELF.compliance_flags.IsOverwritten := (RIGHT.offense_persistent_id<>0 AND (STRING) RIGHT.offense_persistent_id IN offense_override_ids);
        SELF.compliance_flags.IsSuppressed := (RIGHT.offense_persistent_id<>0 AND (STRING) RIGHT.offense_persistent_id IN offense_suppressed_ids)
                                              OR (RIGHT.offender_key IN offenders_suppressed_ids);
        SELF.subject_did := LEFT.subject_did;
        SELF.record_ids.RecId1 := (STRING) RIGHT.offense_persistent_id;
        SELF := RIGHT;
        SELF := LEFT;
        SELF := []), // recid2, recid3, recid4
      LIMIT(0), KEEP($.Constants.Limits.MaxCrimOffenses));

    offense_recs_all := offense_main_recs + offense_override_recs;

    offense_recs_filt := offense_recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
      FCRA.crim_is_ok (todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag)
      );

    layout_offense_rawrec xformOffenseStatements(layout_offense_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_IDs := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    offense_recs_final_ds := JOIN(offense_recs_filt, offense_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.offense_persistent_id = (UNSIGNED) RIGHT.RecID1,
                          xformOffenseStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    offense_recs_out := PROJECT(offense_recs_final_ds,
                                  TRANSFORM(layout_offense_out,
                                    SELF.Metadata := $.Functions.GetMetadataESDL(
                                                      LEFT.compliance_flags,
                                                      LEFT.record_ids,
                                                      LEFT.statement_IDs,
                                                      LEFT.subject_did,
                                                      FFD.Constants.DataGroups.OFFENSES),
                                    SELF := LEFT));

  // -------- PUNISHMENT ---------

    punishment_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.PUNISHMENT);
    punishment_all_flags := flag_file(file_id = FCRA.FILE_ID.PUNISHMENT);

    punishment_flag_recs :=
      JOIN(punishment_all_flags, FCRA.key_override_crim.punishment,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_punishment_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.punishment_persistent_id=0 OR LEFT.record_id=(STRING) RIGHT.punishment_persistent_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.punishment_persistent_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    punishment_override_recs := punishment_flag_recs(compliance_flags.isOverride);
    punishment_suppressed_recs := punishment_flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    punishment_override_ids := SET(punishment_override_recs, combined_record_id);
    punishment_suppressed_ids := SET(punishment_suppressed_recs, combined_record_id);

    punishment_main_recs := JOIN(id_recs, doxie_files.Key_Punishment(isFCRA),
      KEYED(LEFT.offender_key = RIGHT.ok),
      TRANSFORM(layout_punishment_rawrec,
        SELF.compliance_flags.IsOverwritten := (RIGHT.punishment_persistent_id<>0 AND (STRING) RIGHT.punishment_persistent_id IN punishment_override_ids);
        SELF.compliance_flags.IsSuppressed := (RIGHT.punishment_persistent_id<>0 AND (STRING) RIGHT.punishment_persistent_id IN punishment_suppressed_ids)
                                              OR (RIGHT.offender_key IN offenders_suppressed_ids);
        SELF.subject_did := LEFT.subject_did;
        SELF.record_ids.RecId1 := (STRING) RIGHT.punishment_persistent_id;
        SELF := RIGHT;
        SELF := LEFT;
        SELF := []), // recid2, recid3, recid4
      LIMIT(0), KEEP($.Constants.Limits.MaxCrimPunishments));

    punishment_recs_all := punishment_main_recs + punishment_override_recs;

    punishment_recs_filt := punishment_recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
      );

    layout_punishment_rawrec xformPunishmentStatements(layout_punishment_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_IDs := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    punishment_recs_final_ds := JOIN(punishment_recs_filt, punishment_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.punishment_persistent_id = (UNSIGNED) RIGHT.RecID1,
                          xformPunishmentStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    punishment_recs_out := PROJECT(punishment_recs_final_ds,
                                  TRANSFORM(layout_punishment_out,
                                    SELF.Metadata := $.Functions.GetMetadataESDL(
                                                      LEFT.compliance_flags,
                                                      LEFT.record_ids,
                                                      LEFT.statement_IDs,
                                                      LEFT.subject_did,
                                                      FFD.Constants.DataGroups.PUNISHMENT),
                                    SELF := LEFT));

  // -------------  COURT_OFFENSES  -------------

    court_offenses_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.COURT_OFFENSES);
    court_offenses_all_flags := flag_file(file_id = FCRA.FILE_ID.COURT_OFFENSES);

    court_offenses_flag_recs :=
      JOIN(court_offenses_all_flags, FCRA.key_override_crim.court_offenses,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_court_offense_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.offense_persistent_id=0 OR LEFT.record_id=(STRING) RIGHT.offense_persistent_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.offense_persistent_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    court_offenses_override_recs := court_offenses_flag_recs(compliance_flags.isOverride);
    court_offenses_suppressed_recs := court_offenses_flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    court_offenses_override_ids := SET(court_offenses_override_recs, combined_record_id);
    court_offenses_suppressed_ids := SET(court_offenses_suppressed_recs, combined_record_id);

    court_offenses_main_recs := JOIN(id_recs, doxie_files.key_court_offenses(isFCRA),
      KEYED(LEFT.offender_key = RIGHT.ofk),
      TRANSFORM(layout_court_offense_rawrec,
        SELF.compliance_flags.IsOverwritten := (RIGHT.offense_persistent_id<>0 AND (STRING) RIGHT.offense_persistent_id IN court_offenses_override_ids);
        SELF.compliance_flags.IsSuppressed := (RIGHT.offense_persistent_id<>0 AND (STRING) RIGHT.offense_persistent_id IN court_offenses_suppressed_ids)
                                              OR (RIGHT.offender_key IN offenders_suppressed_ids);
        SELF.subject_did := LEFT.subject_did;
        SELF.record_ids.RecId1 := (STRING) RIGHT.offense_persistent_id;
        SELF := RIGHT;
        SELF := LEFT;
        SELF := []), // recid2, recid3, recid4
      LIMIT(0), KEEP($.Constants.Limits.MaxCrimCourtOffenses));

    court_offenses_recs_all := court_offenses_main_recs + court_offenses_override_recs;

    court_offenses_recs_filt := court_offenses_recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
      FCRA.crim_is_ok (todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag)
      );

    layout_court_offense_rawrec xformCourtOffenseStatements(layout_court_offense_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_IDs := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    court_offenses_recs_final_ds := JOIN(court_offenses_recs_filt, court_offenses_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.offense_persistent_id = (UNSIGNED) RIGHT.RecID1,
                          xformCourtOffenseStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    court_offenses_recs_out := PROJECT(court_offenses_recs_final_ds,
                                  TRANSFORM(layout_court_offense_out,
                                    SELF.Metadata := $.Functions.GetMetadataESDL(
                                                      LEFT.compliance_flags,
                                                      LEFT.record_ids,
                                                      LEFT.statement_IDs,
                                                      LEFT.subject_did,
                                                      FFD.Constants.DataGroups.COURT_OFFENSES),
                                    SELF := LEFT));


  // -------------  OFFENDERS_PLUS  -------------

    offenderplus_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.OFFENDERS_PLUS);
    offenderplus_all_flags := flag_file(file_id = FCRA.FILE_ID.OFFENDERS_PLUS);

    offenderplus_flag_recs :=
      JOIN(offenderplus_all_flags, FCRA.key_override_crim.offenders_plus,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_offender_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.offender_persistent_id=0 OR LEFT.record_id=(STRING) RIGHT.offender_persistent_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.offender_persistent_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    offenderplus_override_recs := offenderplus_flag_recs(compliance_flags.isOverride);
    offenderplus_suppressed_recs := offenderplus_flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    offenderplus_override_ids := SET(offenderplus_override_recs, combined_record_id);
    offenderplus_suppressed_ids := SET(offenderplus_suppressed_recs, combined_record_id);

    offenderplus_main_recs := JOIN(id_recs, doxie_files.Key_Offenders_OffenderKey(isFCRA),
      KEYED(LEFT.offender_key = RIGHT.ofk),
      TRANSFORM(layout_offender_rawrec,
        SELF.compliance_flags.IsOverwritten := (RIGHT.offender_persistent_id<>0 AND (STRING) RIGHT.offender_persistent_id IN offenderplus_override_ids);
        SELF.compliance_flags.IsSuppressed := (RIGHT.offender_persistent_id<>0 AND (STRING) RIGHT.offender_persistent_id IN offenderplus_suppressed_ids)
                                              OR (RIGHT.offender_key IN offenders_suppressed_ids);
        SELF.subject_did := LEFT.subject_did;
        SELF.record_ids.RecId1 := (STRING) RIGHT.offender_persistent_id;
        SELF := RIGHT;
        SELF := LEFT;
        SELF := []), // recid2, recid3, recid4
      LIMIT(0), KEEP($.Constants.Limits.MaxCrimOffendersPerOFK));

    offenderplus_recs_all := offenderplus_main_recs + offenderplus_override_recs;

    offenderplus_recs_filt := offenderplus_recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
      FCRA.crim_is_ok (todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag)
      );

    layout_offender_rawrec xformOffenderPlusStatements(layout_offender_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_IDs := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    offenderplus_recs_final_ds := JOIN(offenderplus_recs_filt, offenderplus_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.offender_persistent_id = (UNSIGNED) RIGHT.RecID1,
                          xformOffenderPlusStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    offenderplus_recs_out := PROJECT(offenderplus_recs_final_ds,
                                  TRANSFORM(layout_offender_out,
                                    SELF.Metadata := $.Functions.GetMetadataESDL(
                                                      LEFT.compliance_flags,
                                                      LEFT.record_ids,
                                                      LEFT.statement_IDs,
                                                      LEFT.subject_did,
                                                      FFD.Constants.DataGroups.OFFENDERS_PLUS),
                                    SELF := LEFT));

    //----- Combine all results for output---------

    layout_criminal_rec_out xfRollOffenders(layout_offender_out le,
                        DATASET(layout_offender_out) ri) :=
    TRANSFORM
      SELF.offender_key := le.offender_key;
      SELF.process_date := le.process_date;
      SELF.Offenders := SORT(ri, process_date, -file_date, RECORD);
      SELF.OffenderPlus := [];
      SELF.Offenses := [];
      SELF.CourtOffenses := [];
      SELF.Punishments := [];
    END;

    offenders_rolled := ROLLUP(GROUP(SORT(offender_recs_out, offender_key, -process_date), offender_key),
                                  GROUP, xfRollOffenders(LEFT, ROWS(LEFT)));

    layout_criminal_rec_out xfAddOffense(layout_criminal_rec_out le, DATASET(layout_offense_out) ri) :=
    TRANSFORM
      SELF.Offenses := SORT(ri, process_date, RECORD);
      SELF := le;
    END;

    offender_with_offense := DENORMALIZE(offenders_rolled, offense_recs_out,
                            LEFT.offender_key = RIGHT.offender_key,
                            GROUP,
                            xfAddOffense(LEFT, ROWS(RIGHT)));

    layout_criminal_rec_out xfAddCourtOffense(layout_criminal_rec_out le, DATASET(layout_court_offense_out) ri) :=
    TRANSFORM
      SELF.CourtOffenses := SORT(ri, -appeal_date, process_date, RECORD);
      SELF := le;
    END;

    crim_with_court_offenses := DENORMALIZE(offender_with_offense, court_offenses_recs_out,
                            LEFT.offender_key = RIGHT.offender_key,
                            GROUP,
                            xfAddCourtOffense(LEFT, ROWS(RIGHT)));

    layout_criminal_rec_out xfAddPunishment(layout_criminal_rec_out le, DATASET(layout_punishment_out) ri) :=
    TRANSFORM
      SELF.Punishments := SORT(ri, process_date, RECORD);
      SELF := le;
    END;

    crim_with_punishments := DENORMALIZE(crim_with_court_offenses, punishment_recs_out,
                            LEFT.offender_key = RIGHT.offender_key,
                            GROUP,
                            xfAddPunishment(LEFT, ROWS(RIGHT)));

    layout_criminal_rec_out xfAddOffenderPlus(layout_criminal_rec_out le, DATASET(layout_offender_out) ri) :=
    TRANSFORM
      SELF.OffenderPlus := SORT(ri, -file_date, RECORD);
      SELF := le;
    END;

    recs_out := DENORMALIZE(crim_with_punishments, offenderplus_recs_out,
                            LEFT.offender_key = RIGHT.offender_key,
                            GROUP,
                            xfAddOffenderPlus(LEFT, ROWS(RIGHT)));



  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(id_recs, NAMED('offender_ids')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(offenders_suppressed_recs, NAMED('offender_suppressed_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(offenders_override_recs, NAMED('offender_override_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(offenders_main_recs, NAMED('offender_main_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(offender_recs_out, NAMED('offender_recs_out')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(offense_suppressed_recs, NAMED('offense_suppressed_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(offense_override_recs, NAMED('offense_override_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(offense_main_recs, NAMED('offense_main_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(offense_recs_out, NAMED('offense_recs_out')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(court_offenses_suppressed_recs, NAMED('court_offense_suppressed_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(court_offenses_override_recs, NAMED('court_offense_override_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(court_offenses_main_recs, NAMED('court_offense_main_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(court_offenses_recs_out, NAMED('court_offense_recs_out')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(punishment_suppressed_recs, NAMED('punishment_suppressed_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(punishment_override_recs, NAMED('punishment_override_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(punishment_main_recs, NAMED('punishment_main_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(punishment_recs_out, NAMED('punishment_recs_out')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(offenderplus_suppressed_recs, NAMED('offenderplus_suppressed_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(offenderplus_override_recs, NAMED('offenderplus_override_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(offenderplus_main_recs, NAMED('offenderplus_main_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(offenderplus_recs_out, NAMED('offenderplus_recs_out')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeCriminal, OUTPUT(recs_out, NAMED('criminal_combined_recs')));

  RETURN SORT(recs_out, -process_date, offender_key);
  END;

END;
