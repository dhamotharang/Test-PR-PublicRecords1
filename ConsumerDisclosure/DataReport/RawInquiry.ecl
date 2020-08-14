/*
  ***********************************************************************************************************
  * NOTE: This attribute is to be used for Consumer Disclosure only. It is not "batch safe" and not meant to
  * be used/shared by any service other than ConsumerDisclosure.FCRADataService.
  ***********************************************************************************************************
*/
IMPORT $, doxie, ConsumerDisclosure, FCRA, FFD, Inquiry_AccLogs, RiskWiseFCRA, STD, UT;

layout_inquiry_disclosure_raw := RECORD  // recordof(FCRA.key_override_inquiries_ffid)
  Inquiry_AccLogs.Layout.Layout_inquiry_disclosure;
END;

layout_inquiry_disclosure_rawrec := RECORD(layout_inquiry_disclosure_raw)
  $.Layouts.InternalMetadata;
END;

todaysdate := (STRING) Std.Date.Today();

STRING legacy_purpose := '0'; // Legacy RiskWise Products - Hard

IsAcceptedPermissiblePurpose(STRING _str_purpose) := FUNCTION
  _purpose := FCRA.FCRAPurpose.ConvertAndValidate((INTEGER)_str_purpose);
  is_accepted := _str_purpose = legacy_purpose OR
                                FCRA.FCRAPurpose.isDemandDeposit(_purpose) OR
                                FCRA.FCRAPurpose.isCollections(_purpose) OR
                                FCRA.FCRAPurpose.isCreditApplication(_purpose);
  RETURN is_accepted;
END;

IsEmploymentScreeningPurpose(STRING _purpose) := FCRA.FCRAPurpose.isEmploymentScreening(FCRA.FCRAPurpose.ConvertAndValidate((INTEGER)_purpose));

EXPORT RawInquiry := MODULE

  EXPORT layout_inquiries_out := RECORD($.Layouts.Metadata)
    layout_inquiry_disclosure_raw DisclosureData;
  END;

  EXPORT GetData(	DATASET (doxie.layout_references) in_dids,
                  DATASET (FFD.Layouts.flag_ext_rec) flag_file,
                  DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs,
                  $.IParams.IParam in_mod
  ) := FUNCTION

    BOOLEAN showDisputedRecords := in_mod.ReturnDisputed;

    pc_flags := slim_pc_recs(datagroup = FFD.Constants.DataGroups.inquiries);
    all_flags := flag_file(file_id = FCRA.FILE_ID.inquiries);

    calculated_inquiries_data := RiskWiseFCRA._Inquiries_data(in_dids, all_flags);

    flag_recs :=
      JOIN(all_flags, FCRA.key_override_inquiries_ffid,
        KEYED (LEFT.flag_file_id = RIGHT.flag_file_id),
        TRANSFORM(layout_inquiry_disclosure_rawrec,
          is_override := LEFT.flag_file_id <> '' AND LEFT.flag_file_id = RIGHT.flag_file_id;
          SELF.compliance_flags.isOverride := LEFT.isOverride AND is_override;
          SELF.compliance_flags.isSuppressed := LEFT.isSuppressed AND (RIGHT.search_info.transaction_id='' OR LEFT.record_id=RIGHT.search_info.transaction_id);
          SELF.subject_did := (UNSIGNED6) LEFT.did;
          SELF.combined_record_id := LEFT.record_id;
          SELF.record_ids.RecId1 := (STRING) RIGHT.search_info.transaction_id;
          SELF := RIGHT;
          SELF := LEFT;
          SELF := []),
        LEFT OUTER, KEEP(FCRA.compliance.MAX_OVERRIDE_LIMIT), LIMIT(0));

    override_recs := flag_recs(compliance_flags.isOverride);
    suppressed_recs := flag_recs(compliance_flags.isSuppressed AND ~compliance_flags.isOverride);

    override_ids := SET(override_recs, combined_record_id);
    suppressed_ids := SET(suppressed_recs, combined_record_id);

    // now we need to mark overrides in calculated_inquiries_data
    uncorrected_with_overrides_recs := JOIN(calculated_inquiries_data, override_recs,
                                LEFT.person_q.appended_adl = RIGHT.subject_did AND
                                LEFT.search_info.transaction_id = RIGHT.combined_record_id,
                                TRANSFORM(layout_inquiry_disclosure_rawrec,
                                          SELF.compliance_flags.isOverride := RIGHT.compliance_flags.isOverride,
                                          SELF.record_ids.RecId1 := (STRING) LEFT.search_info.transaction_id,
                                          SELF.subject_did := LEFT.person_q.appended_adl,
                                          SELF:= LEFT,
                                          SELF:=[]
                                          ),
                                LEFT OUTER, KEEP(1), LIMIT(0));


    // pull original data to grab suppressed/overwritten
    inquiry_main_raw := JOIN (in_dids, Inquiry_AccLogs.Key_FCRA_DID,
                      KEYED(LEFT.did = RIGHT.appended_adl),
                      TRANSFORM(layout_inquiry_disclosure_rawrec,
                                SELF.compliance_flags.IsOverwritten :=
                                  (RIGHT.search_info.transaction_id<>'' AND (STRING) RIGHT.search_info.transaction_id IN override_ids),
                                SELF.compliance_flags.IsSuppressed :=
                                  (RIGHT.search_info.transaction_id<>'' AND (STRING) RIGHT.search_info.transaction_id IN suppressed_ids),
                                SELF.subject_did := LEFT.did,
                                SELF.record_ids.RecId1 := (STRING) RIGHT.search_info.transaction_id,
                                SELF := RIGHT,
                                SELF := LEFT,
                                SELF := []),
                                //KEEP($.Constants.Limits.MaxInquiriesPerDID),
                                LIMIT(0));

    suppressed_overwritten_recs := inquiry_main_raw(compliance_flags.isOverwritten OR compliance_flags.isSuppressed);

    //---now combining results-------
    recs_all := uncorrected_with_overrides_recs + suppressed_overwritten_recs;

    recs_filt:= recs_all(
      in_mod.ReturnOverwritten OR ~compliance_flags.isOverwritten,
      in_mod.ReturnSuppressed OR ~compliance_flags.isSuppressed,
      (IsAcceptedPermissiblePurpose(TRIM(permissions.fcra_purpose))
      AND ut.fn_date_is_ok(todaysdate, search_info.datetime[1..8], 1))
      OR (IsEmploymentScreeningPurpose(TRIM(permissions.fcra_purpose)) AND
          ut.fn_date_is_ok(todaysdate, search_info.datetime[1..8], 2))
      );

    layout_inquiry_disclosure_rawrec xformStatements(layout_inquiry_disclosure_rawrec l, FFD.Layouts.PersonContextBatchSlim r ) := transform,
      SKIP(~ShowDisputedRecords AND r.isDisputed)
            SELF.statement_ids := r.StatementIDs;
            SELF.compliance_flags.IsDisputed   := r.isDisputed;
            SELF := l;
    END;

    recs_final_ds := JOIN(recs_filt, pc_flags,
                            LEFT.subject_did = (UNSIGNED) RIGHT.lexid AND
                            LEFT.record_ids.RecId1 = RIGHT.RecID1,
                            xformStatements(LEFT,RIGHT),
                            LEFT OUTER,
                            KEEP(1),
                            LIMIT(0));

    recs_out := PROJECT(recs_final_ds, TRANSFORM(layout_inquiries_out,
                          SELF.Metadata := $.Functions.GetMetadataESDL(LEFT.compliance_flags,
                                                LEFT.record_ids,
                                                LEFT.statement_IDs,
                                                LEFT.subject_did,
                                                FFD.Constants.DataGroups.Inquiries);
                          SELF.DisclosureData := LEFT;
                          ));

    final_recs := SORT( recs_out, -DisclosureData.search_info.datetime, RECORD);

    IF(ConsumerDisclosure.Debug AND in_mod.IncludeInquiries,OUTPUT(override_recs, NAMED('inquiry_override_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeInquiries,OUTPUT(suppressed_recs, NAMED('inquiry_suppressed_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeInquiries,OUTPUT(calculated_inquiries_data, NAMED('calculated_inquiries_data')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeInquiries,OUTPUT(uncorrected_with_overrides_recs, NAMED('inquiry_uncorrected_with_overrides_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeInquiries,OUTPUT(suppressed_overwritten_recs, NAMED('inquiry_suppressed_overwritten_recs')));
    IF(ConsumerDisclosure.Debug AND in_mod.IncludeInquiries,OUTPUT(final_recs, NAMED('inquiry_recs_out')));

    RETURN final_recs;
  END;

  EXPORT GetSSNList(DATASET(layout_inquiries_out) in_inquiry_recs) := FUNCTION

    filtered_recs := in_inquiry_recs(~MetaData.ComplianceFlags.isSuppressed,
                                // ~MetaData.ComplianceFlags.isDisputed,
                                ~MetaData.ComplianceFlags.isOverwritten);

    ssn_recs := PROJECT(filtered_recs,
                      TRANSFORM($.Layouts.ssn_rec,
                                SELF.subject_did:=(UNSIGNED)LEFT.Metadata.Lexid,
                                SELF.ssn :=LEFT.DisclosureData.person_q.ssn,
                                SELF.inquiry_source := TRUE,
                                SELF:=[]));

    unique_inquiry_ssns := DEDUP(SORT(ssn_recs(ssn<>''), subject_did,ssn),subject_did,ssn);
    RETURN unique_inquiry_ssns;
  END;
END;
