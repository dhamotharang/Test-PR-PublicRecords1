/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, doxie, FCRA, FFD, Suppress, SexOffender, STD;

BOOLEAN IsFCRA := TRUE;

layout_so_offense_raw := RECORDOF(SexOffender.key_sexoffender_offenses); // neither payload nor overrides has index layout definition to reference

layout_so_offender_raw := RECORD(sexoffender.layout_out_main)  // recordof(exOffender.Key_SexOffender_DID)
  REAL lat;
  REAL long;
  STRING60 sspk;
END;

layout_so_offender_rawrec := RECORD(layout_so_offender_raw)
  $.Layouts.InternalMetadata;
END;

layout_so_offense_rawrec := RECORD(layout_so_offense_raw)
  $.Layouts.InternalMetadata;
END;


EXPORT RawOffender := MODULE

  EXPORT layout_so_offender_out := RECORD($.Layouts.Metadata)
    layout_so_offender_raw;
  END;

  EXPORT layout_so_offense_out := RECORD($.Layouts.Metadata)
    layout_so_offense_raw;
  END;

  EXPORT layout_so_out := RECORD
    STRING60 seisint_primary_key;
    STRING8	fcra_date;             // for sorting
    DATASET(layout_so_offender_out) Offenders;
    DATASET(layout_so_offense_out) Offenses;
  END;

  EXPORT GetData(
    DATASET(doxie.layout_references) in_dids,
    DATASET (FFD.Layouts.flag_ext_rec) flag_file,
    DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
    $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;
    todaysdate := (STRING8) STD.Date.Today();

    so_offender_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.SO_MAIN);
    so_offender_flags := flag_file(file_id = FCRA.FILE_ID.SO_MAIN);

    so_offense_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.SO_OFFENSES);
    so_offense_flags := flag_file(file_id = FCRA.FILE_ID.SO_OFFENSES);

    id_recs := JOIN(in_dids,SexOffender.Key_SexOffender_DID(isFCRA),
                    KEYED(LEFT.did=RIGHT.did),
                    TRANSFORM(RIGHT),
                    LIMIT(0),KEEP($.Constants.Limits.MaxSOffenderPerDID));

    id_recs_dep := DEDUP(SORT(id_recs,did,seisint_primary_key),did, seisint_primary_key);


    //-------Offenders--------
    so_offender_flag_recs :=
      JOIN(so_offender_flags, FCRA.key_override_sexoffender.so_main,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_so_offender_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.offender_persistent_id=0 OR LEFT.record_id=(STRING) RIGHT.offender_persistent_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.offender_persistent_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    so_offender_suppressed_recs := so_offender_flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);
    so_offender_override_recs_prelim := so_offender_flag_recs(compliance_flags.isOverride);

    //we only want to keep the overrides that were in the original id_recs
    so_offender_override_recs := JOIN(so_offender_override_recs_prelim, id_recs_dep,
                                LEFT.seisint_primary_key = RIGHT.seisint_primary_key,
                                TRANSFORM(LEFT), LIMIT(0), KEEP(1));

    so_offender_override_ids := SET(so_offender_override_recs, combined_record_id);
    so_offender_suppressed_ids := SET(so_offender_suppressed_recs, combined_record_id);

    so_offender_payload_recs := JOIN(id_recs_dep, SexOffender.key_SexOffender_SPK(isFCRA),
      KEYED(LEFT.seisint_primary_key = RIGHT.sspk),
      TRANSFORM(layout_so_offender_rawrec,
        SELF.compliance_flags.IsOverwritten := (RIGHT.offender_persistent_id<>0 AND (STRING) RIGHT.offender_persistent_id IN so_offender_override_ids);
        SELF.compliance_flags.IsSuppressed := (RIGHT.offender_persistent_id<>0 AND (STRING) RIGHT.offender_persistent_id IN so_offender_suppressed_ids);
        SELF.subject_did := LEFT.did;
        SELF.record_ids.RecId1 := (STRING) RIGHT.offender_persistent_id;
        SELF := RIGHT;
        SELF := LEFT;
        SELF := []), // recid2, recid3, recid4
      LIMIT(0), KEEP($.Constants.Limits.MaxSOPerSSPK));

    so_offender_recs_all := so_offender_payload_recs + so_offender_override_recs;

    so_offender_recs_filt:= so_offender_recs_all(
      in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed,
      // should we filter by fcra_conviction_flag/fcra_traffic_flag? Is it applicable to SO ?
      FCRA.crim_is_ok(todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag)
      );

    layout_so_offender_rawrec xformStatements(layout_so_offender_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords and r.isDisputed)
          SELF.statement_IDs := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    so_offender_recs_final_ds := JOIN(so_offender_recs_filt, so_offender_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.offender_persistent_id = (INTEGER) RIGHT.RecID1,
                          xformStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));


    // should we adds zero prefix to SSNs if missing ?
    so_offender_recs_out := PROJECT(so_offender_recs_final_ds,
      TRANSFORM(layout_so_offender_out,
        SELF.Metadata := $.Functions.GetMetadataESDL(
                                                      LEFT.compliance_flags,
                                                      LEFT.record_ids,
                                                      LEFT.statement_IDs,
                                                      LEFT.subject_did,
                                                      FFD.Constants.DataGroups.SO_MAIN
                                                     );
        SELF := LEFT;
        ));

    //-------Offenses------------

    so_offense_flag_recs :=
    JOIN(so_offense_flags, FCRA.key_override_sexoffender.so_offenses,
      KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
      TRANSFORM(layout_so_offense_rawrec,
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

    so_offense_suppressed_recs := so_offense_flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);
    so_offense_override_recs_prelim := so_offense_flag_recs(compliance_flags.isOverride);

    //we only want to keep the overrides that were in the original id_recs
    so_offense_override_recs := JOIN(so_offense_override_recs_prelim, id_recs_dep,
                                LEFT.seisint_primary_key = RIGHT.seisint_primary_key,
                                TRANSFORM(LEFT), LIMIT(0), KEEP(1));

    so_offense_override_ids := SET(so_offense_override_recs, combined_record_id);
    so_offense_suppressed_ids := SET(so_offense_suppressed_recs, combined_record_id);

    so_offense_payload_recs := JOIN(id_recs_dep, SexOffender.Key_SexOffender_offenses(isFCRA),
      KEYED(LEFT.seisint_primary_key = RIGHT.sspk),
      TRANSFORM(layout_so_offense_rawrec,
        SELF.compliance_flags.IsOverwritten := (RIGHT.offense_persistent_id<>0 AND (STRING) RIGHT.offense_persistent_id IN so_offense_override_ids);
        SELF.compliance_flags.IsSuppressed := (RIGHT.offense_persistent_id<>0 AND (STRING) RIGHT.offense_persistent_id IN so_offense_suppressed_ids);
        SELF.subject_did := LEFT.did;
        SELF.record_ids.RecId1 := (STRING) RIGHT.offense_persistent_id;
        SELF := RIGHT;
        SELF := LEFT;
        SELF := []), // recid2, recid3, recid4
      LIMIT(0), KEEP($.Constants.Limits.MaxSOPerSSPK));

    so_offense_recs_all := so_offense_payload_recs + so_offense_override_recs;

    so_offense_recs_filt := so_offense_recs_all(
      in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed,
      // should we filter by fcra_conviction_flag/fcra_traffic_flag ? is it applicable to SO ?
      FCRA.crim_is_ok(todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag)
      );

    layout_so_offense_rawrec xformOffenseStatements(layout_so_offense_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords and r.isDisputed)
          SELF.statement_IDs := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    so_offense_recs_final_ds := JOIN(so_offense_recs_filt, so_offender_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.offense_persistent_id = (INTEGER) RIGHT.RecID1,
                          xformOffenseStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));


    // should we adds zero prefix to SSNs if missing ?
    so_offense_recs_out := PROJECT(so_offense_recs_final_ds,
      TRANSFORM(layout_so_offense_out,
        SELF.Metadata := $.Functions.GetMetadataESDL(
                                                      LEFT.compliance_flags,
                                                      LEFT.record_ids,
                                                      LEFT.statement_IDs,
                                                      LEFT.subject_did,
                                                      FFD.Constants.DataGroups.SO_OFFENSES
                                                    );
        SELF := LEFT;
        ));

    //---------- Now combining data sets for final output
    layout_so_out xfRollMain(layout_so_offender_out le,
                        DATASET(layout_so_offender_out) main_rows) :=
    TRANSFORM
      SELF.seisint_primary_key := le.seisint_primary_key;
      SELF.fcra_date := le.fcra_date;  // for sorting
      SELF.Offenders := SORT(main_rows, -dt_last_reported, -dt_first_reported, -conviction_override_date);
      SELF.Offenses := [];
    END;

    so_offender_rolled := ROLLUP(GROUP(SORT(so_offender_recs_out, seisint_primary_key, -fcra_date), seisint_primary_key),
                                  GROUP, xfRollMain(LEFT, ROWS(LEFT)));

    layout_so_out xfAddOffenses(layout_so_out le, DATASET(layout_so_offense_out) offense_rows) :=
    TRANSFORM
      SELF.Offenses := SORT(offense_rows, -fcra_date, -conviction_date, -conviction_override_date);
      SELF := le;
    END;

    recs_out := DENORMALIZE(so_offender_rolled, so_offense_recs_out,
                            LEFT.seisint_primary_key = RIGHT.seisint_primary_key,
                            GROUP,
                            xfAddOffenses(LEFT, ROWS(RIGHT)));


    IF(ConsumerDisclosure.Debug AND in_mod.IncludeOffenders, OUTPUT(id_recs, NAMED('so_offender_ids')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeOffenders, OUTPUT(so_offender_suppressed_recs, NAMED('so_offender_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeOffenders, OUTPUT(so_offender_override_recs, NAMED('so_offender_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeOffenders, OUTPUT(so_offender_payload_recs, NAMED('so_offender_payload_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeOffenders, OUTPUT(so_offense_suppressed_recs, NAMED('so_offense_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeOffenders, OUTPUT(so_offense_override_recs, NAMED('so_offense_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeOffenders, OUTPUT(so_offense_payload_recs, NAMED('so_offense_payload_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeOffenders, OUTPUT(recs_out, NAMED('SO_combined_recs')));

    RETURN SORT(recs_out, -fcra_date, seisint_primary_key);
  END;

END;
