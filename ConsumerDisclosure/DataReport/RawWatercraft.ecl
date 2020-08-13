/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, doxie, FCRA, FFD, MDR, Suppress, Watercraft;

  BOOLEAN IsFCRA := TRUE;

  layout_watercraft_info_raw := RECORD(Watercraft.Layout_Watercraft_Main_Base) // RECORDOF(watercraft.key_watercraft_wid)
  END;

  layout_watercraft_owners_raw := RECORD // RECORDOF(watercraft.key_watercraft_sid)
    Watercraft.Layout_Watercraft_Search_Base_slim -{watercraft.layout_exclusions};
  END;

  layout_coastguard_raw := RECORD(Watercraft.Layout_Watercraft_Coastguard_Base) // RECORDOF(watercraft.key_watercraft_cid)
  END;

  layout_watercraft_info_rawrec := RECORD(layout_watercraft_info_raw)
    $.Layouts.InternalMetadata;
  END;

  layout_watercraft_owners_rawrec := RECORD(layout_watercraft_owners_raw)
    $.Layouts.InternalMetadata;
  END;

  layout_coastguard_rawrec := RECORD(layout_coastguard_raw)
    $.Layouts.InternalMetadata;
  END;


EXPORT RawWatercraft := MODULE

  EXPORT layout_watercraft_info_out := RECORD($.Layouts.Metadata)
    layout_watercraft_info_raw;
  END;

  EXPORT layout_watercraft_owners_out := RECORD($.Layouts.Metadata)
    layout_watercraft_owners_raw;
  END;

  EXPORT layout_coastguard_out := RECORD($.Layouts.Metadata)
    layout_coastguard_raw;
  END;

  EXPORT layout_watercraft_out := RECORD
    STRING state_origin;
    STRING watercraft_key;
    STRING sequence_key;
    STRING8  date_first_seen;  // for sorting
    STRING8  date_last_seen;   // for sorting
    DATASET(layout_watercraft_owners_out) Owners;
    DATASET(layout_watercraft_info_out) Details;
    DATASET(layout_coastguard_out) Coastguard;
  END;

  EXPORT GetData(DATASET(doxie.layout_references) in_dids,
                  DATASET (FFD.Layouts.flag_ext_rec) flag_file,
                  DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
                  $.IParams.IParam in_mod) := FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

    Watercraft_owners_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.WATERCRAFT);
    Watercraft_owners_flags := flag_file(file_id = FCRA.FILE_ID.WATERCRAFT);

    coastguard_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.WATERCRAFT_COASTGUARD);
    coastguard_flags := flag_file(file_id = FCRA.FILE_ID.WATERCRAFT_COASTGUARD);

    Watercraft_info_pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.WATERCRAFT_DETAILS);
    Watercraft_info_flags := flag_file(file_id = FCRA.FILE_ID.WATERCRAFT_DETAILS);

    id_recs := JOIN(in_dids,watercraft.key_watercraft_did(isFCRA),
                    KEYED(left.did=right.l_did),
                    TRANSFORM(RIGHT),
                    LIMIT(0),KEEP($.Constants.Limits.MaxWatercraftPerDID));

    // --------------coastguard-------------
    Watercraft_coastguard_flag_recs :=
      JOIN(coastguard_flags, FCRA.key_override_watercraft.cid,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_coastguard_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          rec_id_oldway := TRIM(RIGHT.watercraft_key)+TRIM(RIGHT.sequence_key);
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.persistent_record_id=0 OR LEFT.record_id=(STRING) RIGHT.persistent_record_id OR rec_id_oldway=LEFT.record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    Watercraft_coastguard_override_recs := Watercraft_coastguard_flag_recs(compliance_flags.isOverride);
    Watercraft_coastguard_suppressed_recs := Watercraft_coastguard_flag_recs(compliance_flags.isSuppressed ANd ~compliance_flags.isOverride);

    Watercraft_coastguard_override_ids := SET(Watercraft_coastguard_override_recs, combined_record_id);
    Watercraft_coastguard_suppressed_ids := SET(Watercraft_coastguard_suppressed_recs, combined_record_id);

    Watercraft_coastguard_payload_recs := JOIN(id_recs, watercraft.key_watercraft_cid(IsFCRA),
                          KEYED(LEFT.state_origin = RIGHT.state_origin AND
                                LEFT.watercraft_key = RIGHT.watercraft_key AND
                                LEFT.sequence_key = RIGHT.sequence_key),
                          TRANSFORM(layout_coastguard_rawrec,
                                    rec_id := (STRING)RIGHT.persistent_record_id;
                                    rec_id_oldway := TRIM(RIGHT.watercraft_key)+TRIM(RIGHT.sequence_key);
                                    SELF.compliance_flags.IsOverwritten :=
                                      (rec_id_oldway<>'' AND rec_id_oldway IN Watercraft_coastguard_override_ids) OR
                                      (rec_id<>'' AND rec_id IN Watercraft_coastguard_override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (rec_id_oldway<>'' AND rec_id_oldway IN Watercraft_coastguard_suppressed_ids) OR
                                      (rec_id<>'' AND rec_id IN Watercraft_coastguard_suppressed_ids),
                                    SELF.subject_did := LEFT.l_did,
                                    SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
                                    SELF := RIGHT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxWatercraftCoastGuards));


    Watercraft_coastguard_recs_all := Watercraft_coastguard_payload_recs + Watercraft_coastguard_override_recs;

    Watercraft_coastguard_recs_filt := Watercraft_coastguard_recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
      );

    // translate the source code to be the header source code so it can be found in the vendor lookup service
    coastguard_source_code_corr := PROJECT(Watercraft_coastguard_recs_filt,
                                    TRANSFORM(layout_coastguard_rawrec,
                                    SELF.source_code := MDR.sourcetools.fWatercraft(LEFT.Source_Code, LEFT.State_Origin),
                                    SELF := LEFT));

    layout_coastguard_rawrec xformCoastguardStatements(layout_coastguard_rawrec l,  FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_ids := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    Watercraft_coastguard_final_ds := JOIN(coastguard_source_code_corr, coastguard_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
                          xformCoastguardStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    Watercraft_coastguard_recs_out := PROJECT(Watercraft_coastguard_final_ds,
                            TRANSFORM(layout_coastguard_out,
                            SELF.Metadata := $.Functions.GetMetadataESDL(
                                                LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_IDs,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.WATERCRAFT_COASTGUARD),
                            SELF := LEFT)
                          );

    //----------- Watercraft details--------------
    Watercraft_info_flag_recs :=
      JOIN(Watercraft_info_flags, FCRA.key_override_watercraft.wid,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_watercraft_info_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          rec_id_oldway := TRIM(RIGHT.watercraft_key)+TRIM(RIGHT.sequence_key);
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND
                                               (RIGHT.persistent_record_id=0
                                                OR LEFT.record_id = (STRING) RIGHT.persistent_record_id
                                                OR LEFT.record_id=rec_id_oldway);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    Watercraft_info_override_recs := Watercraft_info_flag_recs(compliance_flags.isOverride);
    Watercraft_info_suppressed_recs := Watercraft_info_flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    Watercraft_info_override_ids := SET(Watercraft_info_override_recs, combined_record_id);
    Watercraft_info_suppressed_ids := SET(Watercraft_info_suppressed_recs, combined_record_id);

    Watercraft_info_payload_recs := JOIN(id_recs, watercraft.key_watercraft_wid(IsFCRA),
                        KEYED(LEFT.state_origin = RIGHT.state_origin AND
                              LEFT.watercraft_key = RIGHT.watercraft_key AND
                              LEFT.sequence_key = RIGHT.sequence_key),
                          TRANSFORM(layout_watercraft_info_rawrec,
                                    rec_id := (STRING)RIGHT.persistent_record_id;
                                    rec_id_oldway := TRIM(RIGHT.watercraft_key)+TRIM(RIGHT.sequence_key);
                                    SELF.compliance_flags.IsOverwritten :=
                                      (rec_id_oldway<>'' AND rec_id_oldway IN Watercraft_info_override_ids) OR
                                      (rec_id<>'' AND rec_id IN Watercraft_info_override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (rec_id_oldway<>'' AND rec_id_oldway IN Watercraft_info_suppressed_ids) OR
                                      (rec_id<>'' AND rec_id IN Watercraft_info_suppressed_ids),
                                    SELF.subject_did := LEFT.l_did,
                                    SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
                                    SELF := RIGHT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxWatercraftDetails));


    Watercraft_info_recs_all := Watercraft_info_payload_recs + Watercraft_info_override_recs;

    Watercraft_info_recs_filt := Watercraft_info_recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
      );

    // translate the source code to be the header source code so it can be found in the vendor lookup service
    Watercraft_info_source_code_corr := PROJECT(Watercraft_info_recs_filt,
                                    TRANSFORM(layout_watercraft_info_rawrec,
                                    SELF.source_code := MDR.sourcetools.fWatercraft(LEFT.Source_Code, LEFT.State_Origin),
                                    SELF := LEFT));

    layout_watercraft_info_rawrec xformInfoStatements(layout_watercraft_info_rawrec l,  FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_ids := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    Watercraft_info_final_ds := JOIN(Watercraft_info_source_code_corr, Watercraft_info_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
                          xformInfoStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    Watercraft_info_recs_out := PROJECT(Watercraft_info_final_ds,
                            TRANSFORM(layout_watercraft_info_out,
                            SELF.Metadata := $.Functions.GetMetadataESDL(
                                                LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_IDs,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.WATERCRAFT_DETAILS),
                            SELF := LEFT)
                          );

    // ------ Owners -----------
    owners_flag_recs :=
      JOIN(Watercraft_owners_flags, FCRA.Key_Override_Watercraft.sid,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_watercraft_owners_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          rec_id_oldway := TRIM(RIGHT.watercraft_key)+TRIM(RIGHT.sequence_key);
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.persistent_record_id=0 OR LEFT.record_id=(STRING) RIGHT.persistent_record_id OR LEFT.record_id=rec_id_oldway);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    owners_override_recs := owners_flag_recs(compliance_flags.isOverride);
    owners_suppressed_recs := owners_flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    owners_override_ids := SET(owners_override_recs, combined_record_id);
    owners_suppressed_ids := SET(owners_suppressed_recs, combined_record_id);

    owners_payload_recs := JOIN(id_recs,watercraft.key_watercraft_sid(isFCRA),
                          KEYED(LEFT.state_origin = RIGHT.state_origin AND
                                LEFT.watercraft_key = RIGHT.watercraft_key AND
                                LEFT.sequence_key = RIGHT.sequence_key),
                          TRANSFORM(layout_watercraft_owners_rawrec,
                                      rec_id := (STRING)RIGHT.persistent_record_id;
                                      rec_id_oldway := TRIM(RIGHT.watercraft_key)+TRIM(RIGHT.sequence_key);
                                      SELF.compliance_flags.IsOverwritten :=
                                        (rec_id_oldway<>'' AND rec_id_oldway IN owners_override_ids) OR
                                        (rec_id<>'' AND rec_id IN owners_override_ids),
                                      SELF.compliance_flags.IsSuppressed :=
                                        (rec_id_oldway<>'' AND rec_id_oldway IN owners_suppressed_ids) OR
                                        (rec_id<>'' AND rec_id IN owners_suppressed_ids),
                                    SELF.subject_did := LEFT.l_did,
                                    SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxWatercraftOwners));


    owners_recs_all := owners_payload_recs + owners_override_recs;

    owners_recs_filt := owners_recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
      // non subject suppression
      in_mod.nss <> Suppress.Constants.NonSubjectSuppression.returnBlank OR subject_did=(UNSIGNED)did OR
      ((did = '') AND ((bdid != '') OR (fein != '') OR (company_name != '')))  // owner is not a person
      );


    layout_watercraft_owners_rawrec xformOwnersStatements(layout_watercraft_owners_rawrec l,FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_IDs := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    owners_recs_with_pc := JOIN(owners_recs_filt, Watercraft_owners_pc_flags,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
                          xformOwnersStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    // translate the source code to be the header source code so it can be found in the vendor lookup service
    owners_recs_final_ds := PROJECT(owners_recs_with_pc,
                                    TRANSFORM(layout_watercraft_owners_rawrec,
                                    SELF.source_code := MDR.sourcetools.fWatercraft(LEFT.Source_Code, LEFT.State_Origin),
                                    SELF := LEFT));

    //apply non-subject suppression as restricted
    layout_watercraft_owners_rawrec xformNSS(layout_watercraft_owners_rawrec L) := TRANSFORM
      IsSubject := (L.subject_did = (UNSIGNED) L.did);
      NotAPerson := (L.did = '') AND ((L.bdid != '') OR (L.fein != '') OR (L.company_name != ''));
      isRestricted := ~(IsSubject OR NotAPerson);

      SELF.subject_did := L.subject_did;
      SELF.compliance_flags := L.compliance_flags;
      SELF.record_ids := L.record_ids;

      SELF.watercraft_key := L.watercraft_key;
      SELF.state_origin   := L.state_origin;
      SELF.sequence_key   := L.sequence_key;
      SELF.persistent_record_id := L.persistent_record_id;

      SELF.lname := IF (isRestricted, FCRA.Constants.FCRA_Restricted, L.lname);
      SELF := IF (~isRestricted, L);
      SELF := [];
    END;

    Watercraft_owners_nss := PROJECT(owners_recs_final_ds, xformNSS(LEFT));

    // returnBlank nss was taken care of at filtering, here we apply nss for restricted mode
    Watercraft_owners_final_ds := IF(in_mod.nss = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription,
                        Watercraft_owners_nss, owners_recs_final_ds);

    owners_recs_out := PROJECT(Watercraft_owners_final_ds,
                        TRANSFORM(layout_watercraft_owners_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_IDs,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.WATERCRAFT);
                        SELF := LEFT;
                        ));

    // Now combining data sets for final output
    layout_watercraft_out xfRollOwners(layout_watercraft_owners_out le,
                        DATASET(layout_watercraft_owners_out) owners_rows) :=
    TRANSFORM
      SELF.state_origin := le.state_origin;
      SELF.watercraft_key := le.watercraft_key;
      SELF.sequence_key := le.sequence_key;
      SELF.date_last_seen := le.date_last_seen;   // for sorting purpose
      SELF.date_first_seen := MAX(owners_rows, owners_rows.date_first_seen);  // for sorting
      SELF.Owners := owners_rows;
      SELF.Details := [];
      SELF.Coastguard := [];
    END;

    Watercraft_owners_rolled := ROLLUP(GROUP(SORT(owners_recs_out, state_origin,watercraft_key,sequence_key, -date_last_seen, -date_first_seen),
                                            state_origin,watercraft_key,sequence_key),
                                      GROUP, xfRollOwners(LEFT, ROWS(LEFT)));

    layout_watercraft_out xfAddDetails(layout_watercraft_out le, DATASET(layout_watercraft_info_out) info_rows) :=
    TRANSFORM
      SELF.Details := SORT(info_rows, -registration_renewal_date, -registration_date, -registration_expiration_date);
      SELF := le;
    END;

    Watercraft_info_owners_recs := DENORMALIZE(Watercraft_owners_rolled, Watercraft_info_recs_out,
                            LEFT.state_origin = RIGHT.state_origin AND
                            LEFT.watercraft_key = RIGHT.watercraft_key AND
                            LEFT.sequence_key = RIGHT.sequence_key,
                            GROUP,
                            xfAddDetails(LEFT, ROWS(RIGHT)));

    layout_watercraft_out xfAddCoastguards(layout_watercraft_out le, DATASET(layout_coastguard_out) c_rows) :=
    TRANSFORM
      SELF.Coastguard := SORT(c_rows, -date_expires, -date_issued);
      SELF := le;
    END;

    recs_out := DENORMALIZE(Watercraft_info_owners_recs, Watercraft_coastguard_recs_out,
                            LEFT.state_origin = RIGHT.state_origin AND
                            LEFT.watercraft_key = RIGHT.watercraft_key AND
                            LEFT.sequence_key = RIGHT.sequence_key,
                            GROUP,
                            xfAddCoastguards(LEFT, ROWS(RIGHT)));


      IF(ConsumerDisclosure.Debug AND in_mod.IncludeWatercraft,OUTPUT(id_recs, NAMED('Watercraft_ids')));
      IF(ConsumerDisclosure.Debug AND in_mod.IncludeWatercraft,OUTPUT(Watercraft_coastguard_suppressed_recs, NAMED('Watercraft_coastguard_suppressed_recs')));
      IF(ConsumerDisclosure.Debug AND in_mod.IncludeWatercraft,OUTPUT(Watercraft_coastguard_override_recs, NAMED('Watercraft_coastguard_override_recs')));
      IF(ConsumerDisclosure.Debug AND in_mod.IncludeWatercraft,OUTPUT(Watercraft_coastguard_payload_recs, NAMED('Watercraft_coastguard_payload_recs')));
      IF(ConsumerDisclosure.Debug AND in_mod.IncludeWatercraft,OUTPUT(Watercraft_info_suppressed_recs, NAMED('Watercraft_info_suppressed_recs')));
      IF(ConsumerDisclosure.Debug AND in_mod.IncludeWatercraft,OUTPUT(Watercraft_info_override_recs, NAMED('Watercraft_info_override_recs')));
      IF(ConsumerDisclosure.Debug AND in_mod.IncludeWatercraft,OUTPUT(Watercraft_info_payload_recs, NAMED('Watercraft_info_payload_recs')));
      IF(ConsumerDisclosure.Debug AND in_mod.IncludeWatercraft,OUTPUT(owners_suppressed_recs, NAMED('Watercraft_owners_suppressed_recs')));
      IF(ConsumerDisclosure.Debug AND in_mod.IncludeWatercraft,OUTPUT(owners_override_recs, NAMED('Watercraft_owners_override_recs')));
      IF(ConsumerDisclosure.Debug AND in_mod.IncludeWatercraft,OUTPUT(owners_payload_recs, NAMED('Watercraft_owners_payload_recs')));
      IF(ConsumerDisclosure.Debug AND in_mod.IncludeWatercraft,OUTPUT(recs_out, NAMED('Watercraft_recs')));

    RETURN SORT(recs_out,  -date_last_seen, -date_first_seen, state_origin, watercraft_key, sequence_key);
  END;

END;
