/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, ATF, ATF_Services, ConsumerDisclosure, doxie, FCRA, FFD, Suppress;

BOOLEAN IsFCRA := TRUE;

layout_ATF_raw := RECORD
    ATF.ATF_Layout_SearchFile AND NOT [persistent_record_id, lf];
END;

layout_ATF_rawrec := RECORD(layout_ATF_raw)
    $.Layouts.InternalMetadata;
END;

EXPORT RawATF := MODULE
  //Alcohol, Tobacco & Firearms (ATF) - Firearms and Explosives

  EXPORT layout_ATF_out := RECORD($.Layouts.Metadata)
    layout_ATF_raw;
  END;

  EXPORT GetData(
    DATASET(doxie.layout_references) in_dids,
    DATASET (FFD.Layouts.flag_ext_rec) flag_file,
    DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
    $.IParams.IParam in_mod) :=
  FUNCTION

  BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

  pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.ATF);
  all_flags := flag_file(file_id = FCRA.FILE_ID.ATF);

  flag_recs :=
    JOIN(all_flags, FCRA.key_override_atf.atf,
      KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
      TRANSFORM(layout_ATF_rawrec,
        is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
        SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
        SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.atf_id=0 OR LEFT.record_id=(STRING) RIGHT.atf_id);
        SELF.subject_did := (UNSIGNED6) LEFT.did;
        SELF.did := (UNSIGNED6) LEFT.did;
        SELF.combined_record_id := LEFT.record_id;
        SELF.record_ids.RecId1 := (STRING) RIGHT.atf_id;
        SELF := RIGHT;
        SELF := LEFT;
        SELF := []),
      LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_limit), LIMIT(0));

  override_recs := flag_recs(compliance_flags.isOverride);
  suppressed_recs := flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

  override_ids := SET(override_recs, combined_record_id);
  suppressed_ids := SET(suppressed_recs, combined_record_id);

  id_recs := JOIN(in_dids,ATF.Key_atf_did(isFCRA),
    KEYED(LEFT.did=RIGHT.did),
    TRANSFORM(RIGHT),
    LIMIT(0),KEEP($.Constants.Limits.MaxATFPerDID));

  // join to payload key.
  main_recs := JOIN(id_recs, ATF.key_ATF_id(isFCRA),
    KEYED(LEFT.atf_id = RIGHT.atf_id),
    TRANSFORM(layout_ATF_rawrec,
      SELF.compliance_flags.IsOverwritten := (RIGHT.atf_id>0 AND (STRING) RIGHT.atf_id IN override_ids);
      SELF.compliance_flags.IsSuppressed := (RIGHT.atf_id>0 and (STRING) RIGHT.atf_id IN suppressed_ids);
      SELF.subject_did := LEFT.did;
      SELF.record_ids.RecId1 := (STRING) RIGHT.atf_id;
      SELF.did_out := IF(LEFT.did <> 0, (STRING) LEFT.did, RIGHT.did_out);
      SELF := RIGHT;
      SELF := LEFT;
      SELF := []), // recid2, recid3, recid4
    LIMIT(0), KEEP(1));  // only 1 value per atf_id is in index

  recs_all := main_recs + override_recs;

  recs_filt:= recs_all(
    in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
    in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed
    );

  //add statementids  & add dispute indicators/remove disputed records

  layout_ATF_rawrec xformStatements( layout_ATF_rawrec l,  FFD.Layouts.PersonContextBatchSlim r ) := TRANSFORM,
    SKIP(~ShowDisputedRecords AND r.isDisputed)
        SELF.statement_IDs := r.StatementIDs;
        SELF.compliance_flags.IsDisputed := r.isDisputed;
        SELF := l;
  END;

  recs_final_ds := JOIN(recs_filt, pc_flags,
                        LEFT.subject_did = (UNSIGNED6) RIGHT.LexId AND
                        LEFT.atf_id = (INTEGER) RIGHT.RecID1,
                        xformStatements(LEFT,RIGHT),
                        LEFT OUTER,
                        KEEP(1),
                        LIMIT(0));

  // should we add values for premise_fips_county_name when missing?

  //do non-subject suppression
  layout_ATF_rawrec xformNSS(layout_ATF_rawrec L) := TRANSFORM
    //determine which name to use
    BOOLEAN is_license1 := l.rec_code IN ATF_Services.Constants.license1_set;
    SELF.license1_fname := IF(is_license1, l.license1_fname, '');
    SELF.license1_mname := IF(is_license1, l.license1_mname, '');
    SELF.license1_lname := IF(is_license1, l.license1_lname,
                                           IF(in_mod.nss = Suppress.Constants.NonSubjectSuppression.returnBlank, '', FCRA.Constants.FCRA_Restricted));
    SELF.license1_name_suffix := IF(is_license1, l.license1_name_suffix, '');
    SELF.license1_title := IF(is_license1, l.license1_title, '');
    SELF.license1_score := IF(is_license1, l.license1_score, '');
    SELF.license2_fname := IF(is_license1, '', l.license2_fname);
    SELF.license2_mname := IF(is_license1, '', l.license2_mname);
    SELF.license2_lname := IF(is_license1, IF(in_mod.nss = Suppress.Constants.NonSubjectSuppression.returnBlank, '', FCRA.Constants.FCRA_Restricted),
                                           l.license2_lname);
    SELF.license2_name_suffix := IF(is_license1, '', l.license2_name_suffix);
    SELF.license2_title := IF(is_license1, '', l.license2_title);
    SELF.license2_score := IF(is_license1, '', l.license2_score);
    SELF.license_name :=  '';

    self := L;
  end;
  atf_nss := PROJECT(recs_final_ds, xformNSS(LEFT));

  atf_final_ds := IF(in_mod.nss = Suppress.Constants.NonSubjectSuppression.doNothing,
                  recs_final_ds, atf_nss);

  // should we adds zero prefix to SSNs if missing ?
  recs_out := PROJECT(atf_final_ds,
    TRANSFORM(layout_ATF_out,
      SELF.Metadata := $.Functions.GetMetadataESDL(
          LEFT.compliance_flags, LEFT.record_ids, LEFT.statement_IDs, LEFT.subject_did, FFD.Constants.DataGroups.ATF
        );
      SELF := LEFT;
      ));

  IF(ConsumerDisclosure.Debug AND in_mod.IncludeATF, OUTPUT(id_recs, NAMED('ATF_ids')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeATF, OUTPUT(suppressed_recs, NAMED('ATF_suppressed_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeATF, OUTPUT(override_recs, NAMED('ATF_override_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeATF, OUTPUT(main_recs, NAMED('ATF_main_recs')));
  IF(ConsumerDisclosure.Debug AND in_mod.IncludeATF, OUTPUT(recs_out, NAMED('ATF_combined_recs')));

  RETURN SORT(recs_out, -date_last_seen, -date_first_seen, RECORD);
  END;

END;
