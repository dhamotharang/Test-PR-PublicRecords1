/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ConsumerDisclosure, doxie, FCRA, FFD, FAA;

BOOLEAN IsFCRA := TRUE;

layout_certificate_uid := RECORD
  UNSIGNED6 subject_did;
  faa.layout_airmen_Persistent_ID.unique_id;
  faa.layout_airmen_Persistent_ID.letter_code;
END;

layout_Pilot_reg_raw := RECORD(FAA.layout_airmen_Persistent_ID)
  UNSIGNED6 airmen_id;
  UNSIGNED8 did := 0;
 END;

layout_Pilot_cert_raw := RECORD(FAA.layout_airmen_certificate_out)
  STRING7 uid;
END;

layout_Pilot_reg_rawrec := RECORD(layout_Pilot_reg_raw)
  $.Layouts.InternalMetadata;
END;

layout_Pilot_cert_rawrec := RECORD(layout_Pilot_cert_raw)
  $.Layouts.InternalMetadata;
END;

EXPORT RawPilot := MODULE

  EXPORT layout_Pilot_reg_out := RECORD($.Layouts.Metadata)
    layout_Pilot_reg_raw;
  END;

  EXPORT layout_Pilot_cert_out := RECORD($.Layouts.Metadata)
    layout_Pilot_cert_raw;
  END;

  EXPORT layout_Pilot_out := RECORD
    STRING7 unique_id;
    STRING8 date_last_seen;  // for sorting
    DATASET(layout_Pilot_cert_out) Certificate {xpath('Certificate/Row')};
    DATASET(layout_Pilot_reg_out) Registration {xpath('Registration/Row')};
  END;

  EXPORT GetData(DATASET(doxie.layout_references) in_dids,
                DATASET (FFD.Layouts.flag_ext_rec) flag_file,
                DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
               $.IParams.IParam in_mod) :=
  FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

    pc_pilot_cert := slim_pc_recs(datagroup = FFD.Constants.DataGroups.PILOT_CERTIFICATE);
    pilot_cert_flags := flag_file(file_id = FCRA.FILE_ID.PILOT_CERTIFICATE);
    pc_pilot_reg := slim_pc_recs(datagroup = FFD.Constants.DataGroups.PILOT_REGISTRATION);
    pilot_reg_flags := flag_file(file_id = FCRA.FILE_ID.PILOT_REGISTRATION);

    pilot_reg_flag_recs :=
      JOIN(pilot_reg_flags, FCRA.key_override_faa.airmen_reg,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_Pilot_reg_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.persistent_record_id=0 OR LEFT.record_id=(STRING) RIGHT.persistent_record_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id;
          SELF.did := (UNSIGNED8) RIGHT.did_out;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

    pilot_reg_override_recs := pilot_reg_flag_recs(Compliance_Flags.isOverride);
    pilot_reg_suppressed_recs := pilot_reg_flag_recs(Compliance_Flags.isSuppressed AND ~Compliance_Flags.isOverride);

    pilot_reg_override_ids := SET(pilot_reg_override_recs, combined_record_id);
    pilot_reg_suppressed_ids := SET(pilot_reg_suppressed_recs, combined_record_id);

    pilot_reg_main_recs := JOIN(in_dids, FAA.key_airmen_did(isFCRA),
                          KEYED(LEFT.did = RIGHT.did),
                          TRANSFORM(layout_Pilot_reg_rawrec,
                                    SELF.compliance_flags.IsOverwritten :=
                                      (RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN pilot_reg_override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (RIGHT.persistent_record_id>0 and (STRING) RIGHT.persistent_record_id IN pilot_reg_suppressed_ids),
                                    SELF.subject_did := LEFT.did,
                                    SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
                                    SELF := RIGHT,
                                    SELF := LEFT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxAirmenPerDID));


    pilot_reg_recs_all := pilot_reg_main_recs + pilot_reg_override_recs;

    pilot_reg_recs_filt:= pilot_reg_recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
      );

    //add statementids  & add dispute indicators/remove disputed records

    layout_Pilot_reg_rawrec xformStatements(layout_Pilot_reg_rawrec l,  FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_ids := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    pilot_reg_recs_final_ds := JOIN(pilot_reg_recs_filt, pc_pilot_reg,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
                          xformStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    pilot_reg_recs_out := PROJECT(pilot_reg_recs_final_ds, TRANSFORM(layout_Pilot_reg_out,
                        SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_IDs,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.PILOT_REGISTRATION);
                        SELF := LEFT;
                        ));

    // Pilot Certificates:
    cert_uids := DEDUP(PROJECT(pilot_reg_recs_final_ds, layout_certificate_uid), ALL);

    pilot_cert_flag_recs :=
      JOIN(pilot_cert_flags, FCRA.key_override_faa.airmen_cert,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_Pilot_cert_rawrec,
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

    pilot_cert_override_recs := pilot_cert_flag_recs(compliance_flags.isOverride);
    pilot_cert_suppressed_recs := pilot_cert_flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    pilot_cert_override_ids := SET(pilot_cert_override_recs, combined_record_id);
    pilot_cert_suppressed_ids := SET(pilot_cert_suppressed_recs, combined_record_id);

    pilot_cert_main_recs := JOIN(cert_uids, FAA.key_airmen_certs(IsFCRA),
                          KEYED(LEFT.unique_id = RIGHT.uid)
                          AND LEFT.letter_code = RIGHT.letter,
                          TRANSFORM(layout_Pilot_cert_rawrec,
                                    SELF.compliance_flags.IsOverwritten :=
                                      (RIGHT.persistent_record_id>0 AND (STRING) RIGHT.persistent_record_id IN pilot_cert_override_ids),
                                    SELF.compliance_flags.IsSuppressed :=
                                      (RIGHT.persistent_record_id>0 and (STRING) RIGHT.persistent_record_id IN pilot_cert_suppressed_ids),
                                    SELF.subject_did := LEFT.subject_did,
                                    SELF.record_ids.RecId1 := (STRING) RIGHT.persistent_record_id,
                                    SELF := RIGHT,
                                    SELF := []),
                                    LIMIT(0), KEEP($.Constants.Limits.MaxAirmanCertificates));


    pilot_cert_recs_all := pilot_cert_main_recs + pilot_cert_override_recs;

    pilot_cert_recs_filt := pilot_cert_recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
      );

    layout_Pilot_cert_rawrec xformCertStatements(layout_Pilot_cert_rawrec l,  FFD.Layouts.PersonContextBatchSlim r) := TRANSFORM,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
          SELF.statement_ids := r.StatementIDs;
          SELF.compliance_flags.IsDisputed := r.isDisputed;
          SELF := l;
    END;

    pilot_cert_recs_final_ds := JOIN(pilot_cert_recs_filt, pc_pilot_cert,
                          LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                          LEFT.persistent_record_id = (INTEGER) RIGHT.RecID1,
                          xformCertStatements(LEFT,RIGHT),
                          LEFT OUTER,
                          KEEP(1),
                          LIMIT(0));

    pilot_cert_recs_out := PROJECT(pilot_cert_recs_final_ds,
                            TRANSFORM(layout_Pilot_cert_out,
                            SELF.Metadata := $.Functions.GetMetadataESDL(
                                                LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_IDs,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.PILOT_CERTIFICATE),
                            SELF := LEFT)
                          );

    // Now combining data sets for final output
    layout_Pilot_out xfRollCert(layout_Pilot_cert_out le,
                        DATASET(layout_Pilot_cert_out) cert_rows) :=
    TRANSFORM
      SELF.unique_id := le.uid;
      SELF.date_last_seen := le.date_last_seen;
      SELF.Certificate := cert_rows;
      SELF.Registration := [];
    END;

    pilot_cert_rolled := ROLLUP(GROUP(SORT(pilot_cert_recs_out, uid, -date_last_seen, date_first_seen), uid),
                                  GROUP, xfRollCert(LEFT, ROWS(LEFT)));

    layout_Pilot_out xfAddRegistration(layout_Pilot_out le, DATASET(layout_Pilot_reg_out) reg_rows) :=
    TRANSFORM
      SELF.Registration := SORT(reg_rows, -date_last_seen, date_first_seen);
      SELF := le;
    END;

    recs_out := DENORMALIZE(pilot_cert_rolled, pilot_reg_recs_out,
                            LEFT.unique_id = RIGHT.unique_id,
                            GROUP,
                            xfAddRegistration(LEFT, ROWS(RIGHT)));

    IF(ConsumerDisclosure.Debug AND in_mod.IncludePilot,OUTPUT(pilot_reg_suppressed_recs, NAMED('Pilot_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludePilot,OUTPUT(pilot_reg_override_recs, NAMED('Pilot_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludePilot,OUTPUT(pilot_reg_main_recs, NAMED('Pilot_main_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludePilot,OUTPUT(pilot_cert_suppressed_recs, NAMED('PilotCertificate_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludePilot,OUTPUT(pilot_cert_override_recs, NAMED('PilotCertificate_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludePilot,OUTPUT(pilot_cert_main_recs, NAMED('PilotCertificate_main_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludePilot,OUTPUT(recs_out, NAMED('Pilot_recs')));

    RETURN SORT(recs_out, -date_last_seen, unique_id);
  END;

END;
