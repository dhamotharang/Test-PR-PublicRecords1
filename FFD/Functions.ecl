IMPORT doxie, FCRA, FFD, FCRA, PersonContext, Gateway, STD;

  int_rec := RECORD
    INTEGER number;
  END;

EXPORT Functions := MODULE

  CovertSetStr2Int (SET OF STRING inl_set) := FUNCTION
      total_words := COUNT(inl_set);

      inl_ds := DATASET(total_words,
                      TRANSFORM(int_rec, SELF.number := (INTEGER) inl_set[COUNTER]));
      set_out := SET(inl_ds, number);
    RETURN set_out;
  END;

  ExpandPersonContext (DATASET(PersonContext.Layouts.Layout_PCResponseRec) pc_in) := FUNCTION
  // for some record types Content field contains additional data which need to be moved to expanded layout

    FFD.Layouts.PersonContextBatch xform_alerts (PersonContext.Layouts.Layout_PCResponseRec le) := TRANSFORM

      clean_phone:= REGEXFIND('\\(?\\d{3}\\)?\\-?\\d{3}\\-?\\d{4}', STD.Str.Filter(le.Content,'0123456789-()'), 0);  // looking for 10 digit phone number with optional '()-' characters
      consumer_phone := IF(le.RecordType = FFD.Constants.RecordType.FA AND REGEXFIND('\\d+',le.Content), clean_phone, ''); // the phone provided by consumer for verification purposes in case of Fraud Alert
      inl_set := IF(le.RecordType = FFD.Constants.RecordType.SF, STD.Str.SplitWords(STD.Str.CleanSpaces(le.Content), ','), []);
      LH_flag := IF(le.RecordType = FFD.Constants.RecordType.LH, STD.Str.CleanSpaces(le.Content), ''); // Expected values in content field: SP (Suppress Product), SA (Suppress All), Empty for no suppression

      suppress_for_LH := LH_flag = PersonContext.Constants.LegalFlag.SuppressProduct OR LH_flag = PersonContext.Constants.LegalFlag.SuppressAll;
      offenderRecId1 := TRIM(le.RecId1, LEFT, RIGHT) + TRIM(le.RecId2, LEFT, RIGHT);
      SELF.RecId1 := IF(le.DataGroup = FFD.Constants.DataGroups.OFFENDERS, offenderRecId1, le.RecId1);
      SELF.RecId2 := IF(le.DataGroup = FFD.Constants.DataGroups.OFFENDERS, '', le.RecId2);
      SELF.suppress_for_legal_hold := suppress_for_LH;
      SELF.security_freeze_suppression.apply_to_all := le.RecordType = FFD.Constants.RecordType.SF AND TRIM(le.Content,LEFT,RIGHT) = '*';
      SELF.security_freeze_suppression.set_FCRA_purpose := CovertSetStr2Int(inl_set);
      SELF.Content := CASE(le.RecordType,
                            FFD.Constants.RecordType.IT => FFD.Constants.AlertMessage.IDTheftMessage,
                            FFD.Constants.RecordType.LH => IF(suppress_for_LH, FFD.Constants.AlertMessage.LegalHoldMessage, SKIP), // we should only return LH alert if we are suppressing results for it
                            FFD.Constants.RecordType.SF => FFD.Constants.AlertMessage.FreezeMessage,
                            FFD.Constants.RecordType.FA => FFD.Constants.AlertMessage.FraudMessage +
                                                IF(consumer_phone<>'', ' ' + FFD.Constants.AlertMessage.ConsumerPhoneMessage + consumer_phone + '.',''),
                            le.Content);
      SELF := le;
      SELF := [];
    END;

    res := PROJECT(pc_in, xform_alerts(LEFT));
    RETURN res;
  END;


 EXPORT FetchPersonContextAsResponse (DATASET(FFD.Layouts.DidBatch) dids,
                           DATASET(Gateway.Layouts.Config) gateways = Gateway.Constants.void_gateway,
                           SET OF STRING data_group_set = [],
                           INTEGER8 inFFDOptionsMask = FFD.Constants.ConsumerOptions.SHOW_CONSUMER_STATEMENTS,    // by default consumer statements are not filtered
                           BOOLEAN FailOnSoapError = FALSE
                          ) := FUNCTION

  delta_url := TRIM (gateways (Gateway.Configuration.IsDeltaPersoncontext(servicename))[1].URL, LEFT, RIGHT);

  BOOLEAN apply_group_filter := EXISTS(data_group_set);

  PersonContext.Layouts.Layout_PCSearchKey LoadValues({dids} L) := TRANSFORM
    SELF.LexID   := (string) L.Did;
    SELF         := [];
  END;

  PersonContext.Layouts.Layout_PCRequest Load_Request() := TRANSFORM
    SELF.DeltabaseURL := delta_url;
    SELF.SearchBy.Keys := PROJECT (dids, LoadValues(LEFT));
    SELF := [];
  END;
  pc_request := ROW (load_request());
  pc_response := PersonContext.GetPersonContext (pc_request, FailOnSoapError);

  /* use line below for testing with canned data */
  // res := IF(FFD._FakePersonContextData.Ignore, response[1].Records, FFD._FakePersonContextData.Records);

  // clean the response by moving supplemental info from Content field into expanded layout
  pc_recs := ExpandPersonContext(pc_response[1].Records);

  // restore acctno for batch
  recs_all := JOIN (dids, pc_recs(searchstatus = FFD.Constants.StatusCode.ResultsFound),
            LEFT.DID = (unsigned) right.LexID,
            TRANSFORM (FFD.Layouts.PersonContextBatch,
                       SELF.acctno := LEFT.acctno,
                       // BK main records in person context populated as either:
                       // (deprecated) RecID1(tmsid)+RecID2(court_code)+RecID3(case_number)
                       // or (current) RecID1 = court_code; RecID2 = case_number
                       // Here, we convert them all to (current) so we can handle them all the same way everywhere else.
                       is_bk_main_exception := RIGHT.Datagroup = FFD.Constants.DataGroups.BANKRUPTCY_MAIN AND
                        RIGHT.RecID1[1..2] = 'BK' AND RIGHT.RecID2 <> '' AND RIGHT.RecID3 <> '';
                       SELF.RecID1 := IF(is_bk_main_exception, RIGHT.RecID2, RIGHT.RecID1);
                       SELF.RecID2 := IF(is_bk_main_exception, RIGHT.RecID3, RIGHT.RecID2);
                       SELF.RecID3 := IF(is_bk_main_exception, '', RIGHT.RecID3);
                       SELF.RecID4 := IF(is_bk_main_exception, '', RIGHT.RecID4);
                       SELF := RIGHT));

  recs_filt := recs_all(~apply_group_filter OR datagroup in data_group_set);

  recs := IF(EXISTS(dids(did>0)), recs_filt, DATASET([],FFD.Layouts.PersonContextBatch));

  // we pass through header status/message/exceptions from soap call
  FFD.Layouts.PersonContextBatchResponse xf_response() := TRANSFORM
                  SELF._Header := pc_response[1]._Header;
                  SELF.Records := recs;
  END;

  res := ROW(xf_response());

  RETURN res;
 END;

 DataGroupToFileID(STRING data_group) := CASE(data_group,
    FFD.Constants.DataGroups.ACTIVITY => FCRA.FILE_ID.ACTIVITY,
    FFD.Constants.DataGroups.ADDRESS => FCRA.FILE_ID.ADDRESSES,
    FFD.Constants.DataGroups.ADVO => FCRA.FILE_ID.ADVO,
    FFD.Constants.DataGroups.AIRCRAFT => FCRA.FILE_ID.AIRCRAFT,
    FFD.Constants.DataGroups.AIRCRAFT_DETAILS => FCRA.FILE_ID.AIRCRAFT_DETAILS,
    FFD.Constants.DataGroups.AIRCRAFT_ENGINE => FCRA.FILE_ID.AIRCRAFT_ENGINE,
    FFD.Constants.DataGroups.ASSESSMENT => FCRA.FILE_ID.ASSESSMENT,
    FFD.Constants.DataGroups.ATF => FCRA.FILE_ID.ATF,
    FFD.Constants.DataGroups.AVM => FCRA.FILE_ID.AVM,
    FFD.Constants.DataGroups.AVM_MEDIANS => FCRA.FILE_ID.AVM_MEDIANS,
    FFD.Constants.DataGroups.BANKRUPTCY_SEARCH => FCRA.FILE_ID.BANKRUPTCY,
    FFD.Constants.DataGroups.BANKRUPTCY_MAIN => FCRA.FILE_ID.BANKRUPTCY,
    FFD.Constants.DataGroups.CCW => FCRA.FILE_ID.CCW,
    FFD.Constants.DataGroups.COURT_OFFENSES => FCRA.FILE_ID.COURT_OFFENSES,
    FFD.Constants.DataGroups.DEED => FCRA.FILE_ID.DEED,
    FFD.Constants.DataGroups.DID_DEATH => FCRA.FILE_ID.DID_DEATH,
    FFD.Constants.DataGroups.EMAIL_DATA => FCRA.FILE_ID.EMAIL_DATA,
    FFD.Constants.DataGroups.GONG => FCRA.FILE_ID.GONG,
    FFD.Constants.DataGroups.HDR => FCRA.FILE_ID.HDR,
    FFD.Constants.DataGroups.HUNTING_FISHING => FCRA.FILE_ID.HUNTING_FISHING,
    FFD.Constants.DataGroups.IBEHAVIOR_CONSUMER => FCRA.FILE_ID.IBEHAVIOR_CONSUMER,
    FFD.Constants.DataGroups.IBEHAVIOR_PURCHASE => FCRA.FILE_ID.IBEHAVIOR_PURCHASE,
    FFD.Constants.DataGroups.IMPULSE => FCRA.FILE_ID.IMPULSE,
    FFD.Constants.DataGroups.INFUTOR => FCRA.FILE_ID.INFUTOR,
    //FFD.Constants.DataGroups.INFUTORCID => FCRA.FILE_ID.INFUTORCID,  // no flag id for it
    FFD.Constants.DataGroups.INQUIRIES => FCRA.FILE_ID.INQUIRIES,
    FFD.Constants.DataGroups.LIEN_MAIN => FCRA.FILE_ID.LIEN,
    FFD.Constants.DataGroups.LIEN_PARTY => FCRA.FILE_ID.LIEN,
    FFD.Constants.DataGroups.MARI => FCRA.FILE_ID.MARI,
    FFD.Constants.DataGroups.MARRIAGE => FCRA.FILE_ID.MARRIAGE,
    FFD.Constants.DataGroups.MARRIAGE_SEARCH => FCRA.FILE_ID.MARRIAGE_SEARCH,
    FFD.Constants.DataGroups.OFFENDERS => FCRA.FILE_ID.OFFENDERS,
    FFD.Constants.DataGroups.OFFENDERS_PLUS => FCRA.FILE_ID.OFFENDERS_PLUS,
    FFD.Constants.DataGroups.OFFENSES => FCRA.FILE_ID.OFFENSES,
    FFD.Constants.DataGroups.PAW => FCRA.FILE_ID.PAW,
    FFD.Constants.DataGroups.PILOT_CERTIFICATE => FCRA.FILE_ID.PILOT_CERTIFICATE,
    FFD.Constants.DataGroups.PILOT_REGISTRATION => FCRA.FILE_ID.PILOT_REGISTRATION,
    FFD.Constants.DataGroups.PROFLIC => FCRA.FILE_ID.PROFLIC,
    FFD.Constants.DataGroups.PROPERTY => FCRA.FILE_ID.PROPERTY,
    FFD.Constants.DataGroups.PROPERTY_SEARCH => FCRA.FILE_ID.SEARCH,
    FFD.Constants.DataGroups.PUNISHMENT => FCRA.FILE_ID.PUNISHMENT,
    FFD.Constants.DataGroups.SO_MAIN => FCRA.FILE_ID.SO_MAIN,
    FFD.Constants.DataGroups.SO_OFFENSES => FCRA.FILE_ID.SO_OFFENSES,
    FFD.Constants.DataGroups.SSN => FCRA.FILE_ID.SSN,
    FFD.Constants.DataGroups.STUDENT => FCRA.FILE_ID.STUDENT,
    FFD.Constants.DataGroups.STUDENT_ALLOY => FCRA.FILE_ID.STUDENT_ALLOY,
    FFD.Constants.DataGroups.THRIVE => FCRA.FILE_ID.THRIVE,
    FFD.Constants.DataGroups.UCC => FCRA.FILE_ID.UCC,
    FFD.Constants.DataGroups.UCC_PARTY => FCRA.FILE_ID.UCC_PARTY,
    FFD.Constants.DataGroups.WATERCRAFT => FCRA.FILE_ID.WATERCRAFT,
    FFD.Constants.DataGroups.WATERCRAFT_COASTGUARD => FCRA.FILE_ID.WATERCRAFT_COASTGUARD,
    FFD.Constants.DataGroups.WATERCRAFT_DETAILS => FCRA.FILE_ID.WATERCRAFT_DETAILS,
    '');

 EXPORT GetFlagFileCombined(dataset (doxie.layout_best) ds_best,
                   dataset(FFD.Layouts.PersonContextBatch) pc_recs = dataset([], FFD.Layouts.PersonContextBatch)) :=
 function

  ds_file_flags := PROJECT(FCRA.GetFlagFile(ds_best),
  TRANSFORM(FFD.Layouts.flag_ext_rec,
    SELF.isSuppressed := (UNSIGNED)LEFT.override_flag = FCRA.Constants.OverrideFlag.SuppressionInd,
    SELF.isOverride := (UNSIGNED)LEFT.override_flag != FCRA.Constants.OverrideFlag.SuppressionInd,
    SELF.flag_file_id := IF((UNSIGNED)LEFT.override_flag = FCRA.Constants.OverrideFlag.SuppressionInd, '', LEFT.flag_file_id), // we blank it for suppressions
    SELF := LEFT)
  );

  ds_pc_flags := project(pc_recs(recordtype=FFD.Constants.RecordType.SR),
    transform(FFD.Layouts.flag_ext_rec,
    self.record_id := trim(left.RecId1)+trim(left.RecId2)+trim(left.RecId3)+trim(left.RecId4); // string100 enough?
    self.file_id := DataGroupToFileID(left.datagroup);
    self.did := left.lexid;
    self.flag_file_id := ''; // need a new record type in person context for overrides; recid would be file_id (?)
    self.isSuppressed := TRUE;
    self := []
    ));

  ds_flags := rollup(sort(ds_file_flags + ds_pc_flags, did, file_id, record_id, flag_file_id<>''),
    left.did = right.did and left.file_id = right.file_id and left.record_id = right.record_id,
    transform(FFD.Layouts.flag_ext_rec,
      SELF.isSuppressed := LEFT.isSuppressed OR RIGHT.isSuppressed,
      SELF.isOverride := LEFT.isOverride OR RIGHT.isOverride,
      SELF.flag_file_id := MAP(LEFT.isOverride=>LEFT.flag_file_id,
                               RIGHT.isOverride=>RIGHT.flag_file_id,
                               '');

      self.override_flag := if(left.override_flag <> '', left.override_flag, right.override_flag);
      self.in_dispute_flag := if(left.in_dispute_flag <> '', left.in_dispute_flag, right.in_dispute_flag);
      self.consumer_statement_flag := if(left.consumer_statement_flag <> '', left.consumer_statement_flag, right.consumer_statement_flag);
      self.fname := if(left.fname <> '', left.fname, right.fname);
      self.mname := if(left.mname <> '', left.mname, right.mname);
      self.lname := if(left.lname <> '', left.lname, right.lname);
      self.name_suffix := if(left.name_suffix <> '', left.name_suffix, right.name_suffix);
      self.ssn := if(left.ssn <> '', left.ssn, right.ssn);
      self.dob := if(left.dob <> '', left.dob, right.dob);
      self := left
      ));

//output(ds_flags, named('combined_flag_file'), extend);

  return if(exists(pc_recs), sort(ds_flags, flag_file_id, did, file_id, record_id), ds_file_flags);

 end;

END;
