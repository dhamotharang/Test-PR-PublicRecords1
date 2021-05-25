/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, data_services, doxie, dx_prof_License_Mari, FCRA, FFD, Prof_LicenseV2;

BOOLEAN isFCRA := TRUE;

layout_ProfLicense_raw := RECORD
  UNSIGNED6 did;
  Prof_LicenseV2.Layouts_ProfLic.Layout_Base  -[did];
END;

layout_ProfLicense_rawrec := RECORD(layout_ProfLicense_raw)
  $.Layouts.InternalMetadata;
END;

layout_ProfLicenseMari_rawrec := RECORD(dx_prof_License_Mari.layouts.i_did)
  $.Layouts.InternalMetadata;
END;

EXPORT RawProfLicense := MODULE

  EXPORT layout_ProfLicense_out := RECORD($.Layouts.Metadata)
    layout_ProfLicense_raw;
  END;

  EXPORT layout_ProfLicenseMari_out := RECORD($.Layouts.Metadata)
    dx_prof_License_Mari.layouts.i_did;
  END;

  EXPORT GetV2Data(DATASET(doxie.layout_references) in_dids,
                DATASET (FFD.Layouts.flag_ext_rec) flag_file,
                DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
               $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

    pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.PROFLIC);
    all_flags := flag_file(file_id = FCRA.FILE_ID.PROFLIC);

    flag_recs :=
      JOIN(all_flags, FCRA.key_override_proflic_ffid,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_ProfLicense_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.prolic_key='' OR RIGHT.prolic_key=LEFT.record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := RIGHT.prolic_key;
          SELF.did := (UNSIGNED) RIGHT.did;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    override_recs := flag_recs(compliance_flags.isOverride);
    suppressed_recs := flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    override_ids := SET(override_recs, combined_record_id);
    suppressed_ids := SET(suppressed_recs, combined_record_id);

    main_recs := JOIN(in_dids, Prof_LicenseV2.Key_Proflic_Did(data_services.data_env.GetEnvFCRA(isFCRA)),
                          KEYED(LEFT.did = RIGHT.did),
                          TRANSFORM(layout_ProfLicense_rawrec,
                                    SELF.compliance_flags.IsOverwritten :=
                                      (RIGHT.prolic_key<>'' AND RIGHT.prolic_key IN override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (RIGHT.prolic_key<>'' and RIGHT.prolic_key IN suppressed_ids),
                                    SELF.subject_did := LEFT.did,
                                    SELF.record_ids.RecId1 := RIGHT.prolic_key,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxProfLicensePerDID));


    recs_all := main_recs + override_recs;

    recs_filt:= recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
      );

    // - no groupping/rolling of records by prolic_key

    layout_ProfLicense_rawrec xformStatements(layout_ProfLicense_rawrec l,  FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
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

    recs_out := PROJECT(recs_final_ds, TRANSFORM(layout_ProfLicense_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_ids,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.PROFLIC);
                        SELF := LEFT;
                        ));

    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProfLicense,OUTPUT(suppressed_recs, NAMED('ProfLicense_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProfLicense,OUTPUT(override_recs, NAMED('ProfLicense_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProfLicense,OUTPUT(main_recs, NAMED('ProfLicense_main_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProfLicense,OUTPUT(recs_out, NAMED('ProfLicense_recs')));

    RETURN SORT(recs_out, -date_last_Seen, -date_first_seen, RECORD);
  END;

  EXPORT GetMariData(DATASET(doxie.layout_references) in_dids,
                DATASET (FFD.Layouts.flag_ext_rec) flag_file,
                DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
                $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

    pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.MARI);
    all_flags := flag_file(file_id = FCRA.FILE_ID.MARI);

    flag_recs :=
      JOIN(all_flags, FCRA.Key_Override_Proflic_Mari_ffid.proflic_mari,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_ProfLicenseMari_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.persistent_record_id=0 OR LEFT.record_id = (STRING) RIGHT.persistent_record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id;
          SELF.did := (UNSIGNED) RIGHT.did;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    override_recs := flag_recs(compliance_flags.isOverride);
    suppressed_recs := flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    override_ids := SET(override_recs, combined_record_id);
    suppressed_ids := SET(suppressed_recs, combined_record_id);

    main_recs := JOIN(in_dids, dx_prof_license_mari.key_did(data_services.data_env.GetEnvFCRA(isFCRA)),
                          KEYED(LEFT.did = RIGHT.s_did),
                          TRANSFORM(layout_ProfLicenseMari_rawrec,
                                    SELF.compliance_flags.IsOverwritten :=
                                      (RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN suppressed_ids),
                                    SELF.subject_did := LEFT.did,
                                    SELF.record_ids.RecId1 := (STRING)RIGHT.persistent_record_id,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxProfLicensePerDID));


    recs_all := main_recs + override_recs;

    recs_filt:= recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
      );

    layout_ProfLicenseMari_rawrec xformStatements(layout_ProfLicenseMari_rawrec l,  FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
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

    recs_out := PROJECT(recs_final_ds, TRANSFORM(layout_ProfLicenseMari_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_ids,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.MARI);
                        SELF := LEFT;
                        ));

    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProfLicense,OUTPUT(suppressed_recs, NAMED('ProfLicenseMari_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProfLicense,OUTPUT(override_recs, NAMED('ProfLicenseMari_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProfLicense,OUTPUT(main_recs, NAMED('ProfLicenseMari_main_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeProfLicense,OUTPUT(recs_out, NAMED('ProfLicenseMari_recs')));

    RETURN SORT(recs_out, -date_first_seen, -date_last_seen, -persistent_record_id, RECORD);
  END;

END;
