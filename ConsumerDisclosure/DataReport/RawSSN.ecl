/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, Death_Master, FCRA, FFD, Risk_Indicators;

BOOLEAN IsFCRA := TRUE;

layout_SSN_raw := RECORD
  RECORDOF(Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA);
  STRING30 death_sources;
END;

layout_SSN_rawrec := RECORD(layout_SSN_raw)
  $.Layouts.InternalMetadata;
  BOOLEAN inquiry_source := FALSE;
  BOOLEAN header_source := FALSE;
END;

layout_ssn_internal := RECORD
  STRING9 ssn;
  STRING30 death_sources;
  BOOLEAN isDeceased;
END;

EXPORT RawSSN := MODULE

  EXPORT layout_ssn_out := RECORD($.Layouts.Metadata)
    layout_SSN_raw;
    BOOLEAN isInquirySource := FALSE;
    BOOLEAN isHeaderSource := FALSE;
  END;

  EXPORT GetData(DATASET($.Layouts.ssn_rec) in_ssn,
                DATASET (FFD.Layouts.flag_ext_rec) flag_file,
                DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
               $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

    pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.SSN);
    all_flags := flag_file(file_id = FCRA.FILE_ID.SSN);

    ssn_deduped := ROLLUP(SORT(in_ssn, subject_did,ssn,-dt_last_seen),
                          LEFT.subject_did=RIGHT.subject_did AND LEFT.ssn=RIGHT.ssn,
                          TRANSFORM($.Layouts.ssn_rec,
                          // to keep track of whether the ssn came from inquiry, header or both
                            SELF.inquiry_source := LEFT.inquiry_source OR RIGHT.inquiry_source,
                            SELF.header_source := LEFT.header_source OR RIGHT.header_source,
                            SELF := LEFT));

    flag_recs :=
      JOIN(all_flags, FCRA.Key_Override_SSN_Table_FFID,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_SSN_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed ANd (RIGHT.ssn='' OR RIGHT.ssn=LEFT.record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.ssn;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    override_recs_prelim := flag_recs(compliance_flags.isOverride);
    suppressed_recs := flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    // filtering to keep only overrides for input ssn
    override_recs := JOIN(override_recs_prelim, ssn_deduped,
                            LEFT.ssn = RIGHT.ssn AND
                            LEFT.subject_did = RIGHT.subject_did,
                            TRANSFORM(layout_SSN_rawrec,
                            SELF.inquiry_source := RIGHT.inquiry_source,
                            SELF.header_source := RIGHT.header_source,
                            SELF := LEFT),
                            KEEP(1), LIMIT(0));

    override_ids := SET(override_recs, combined_record_id);
    suppressed_ids := SET(suppressed_recs, combined_record_id);

    main_recs := JOIN(ssn_deduped, Risk_Indicators.Key_SSN_Table_v4_filtered_FCRA,
                          KEYED(LEFT.ssn = RIGHT.ssn),
                          TRANSFORM(layout_SSN_rawrec,
                                    rec_id := TRIM(RIGHT.ssn);
                                    SELF.compliance_flags.IsOverwritten := (rec_id IN override_ids),
                                    SELF.compliance_flags.IsSuppressed :=(rec_id IN suppressed_ids),
                                    SELF.subject_did := LEFT.subject_did,
                                    SELF.record_ids.RecId1 := (STRING) RIGHT.ssn,
                                    SELF.isDeceased := RIGHT.isDeceased,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxSSN));


    recs_all := main_recs + override_recs;

    recs_filt:= recs_all(
      in_mod.ReturnOverwritten or ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed or ~compliance_flags.isSuppressed
      );

    // Now pull the death_sources for ssn
    unique_ssn := DEDUP(SORT(PROJECT(recs_filt, layout_ssn_internal), ssn, -isDeceased), ssn);

    with_death_sources := JOIN(unique_ssn, Death_Master.key_ssn_ssa(IsFCRA),
                              LEFT.isDeceased AND
                              KEYED(LEFT.ssn=RIGHT.ssn),
                              TRANSFORM(layout_ssn_internal,
                                SELF.death_sources := RIGHT.death_rec_src;
                                SELF := LEFT),
                              LIMIT(0), KEEP($.Constants.Limits.MaxSSN));

    // first, get rid of all duplicates per source
    death_sources_deduped := DEDUP(SORT(with_death_sources, ssn, death_sources), ssn, death_sources);

    // then rollup to 1 record per SSN of comma delimited death_sources
    death_sources_rolled := ROLLUP(death_sources_deduped, LEFT.ssn=RIGHT.ssn,
                                  TRANSFORM(layout_ssn_internal,
                                      SELF.death_sources := TRIM(LEFT.death_sources) + ',' + TRIM(RIGHT.death_sources);
                                      SELF := LEFT));

    // Now add the death_sources to the ssn_table result
    recs_with_death_sources := JOIN(recs_filt, death_sources_rolled,
                                    LEFT.isDeceased AND LEFT.ssn=RIGHT.ssn,
                                    TRANSFORM(layout_SSN_rawrec,
                                              SELF.death_sources := RIGHT.death_sources,
                                              SELF := LEFT),
                                    LEFT OUTER, KEEP(1), LIMIT(0));


    layout_SSN_rawrec xformStatements(layout_SSN_rawrec l, FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_ids := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    recs_final_ds := JOIN(recs_with_death_sources, pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.record_ids.RecId1 = RIGHT.RecID1,
                          xformStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    recs_out := PROJECT(recs_final_ds, TRANSFORM(layout_ssn_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_ids,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.SSN);
                        SELF.isInquirySource := LEFT.inquiry_source,
                        SELF.isHeaderSource := LEFT.header_source,
                        SELF := LEFT;
                        ));

    IF(ConsumerDisclosure.Debug AND in_mod.IncludeSSN,OUTPUT(suppressed_recs, NAMED('SSN_Data_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeSSN,OUTPUT(override_recs, NAMED('SSN_Data_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeSSN,OUTPUT(unique_ssn, NAMED('SSN_unique_list')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeSSN,OUTPUT(death_sources_deduped, NAMED('SSN_death_sources_deduped')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeSSN,OUTPUT(death_sources_rolled, NAMED('SSN_death_sources_rolled')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeSSN,OUTPUT(main_recs, NAMED('SSN_Data_main_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeSSN,OUTPUT(recs_with_death_sources, NAMED('SSN_recs_with_death_sources')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeSSN,OUTPUT(recs_out, NAMED('SSN_Data_recs_out')));

    RETURN SORT(recs_out, -official_last_seen, -official_first_seen, ssn, RECORD);
  END;

END;
