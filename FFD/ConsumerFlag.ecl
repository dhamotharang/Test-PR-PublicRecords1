IMPORT FCRA, FFD, iesp, PersonContext, STD;

EXPORT ConsumerFlag := MODULE

  SHARED BOOLEAN RaiseAlert (STRING record_type, FFD.layouts.ConsumerFlagsBatch in_flags) := 
    (record_type = FFD.Constants.RecordType.FA AND in_flags.consumer_flags.alert_security_fraud <>'') OR
    (record_type = FFD.Constants.RecordType.SF AND in_flags.consumer_flags.alert_security_freeze <>'') OR
    (record_type = FFD.Constants.RecordType.IT AND in_flags.consumer_flags.alert_identity_theft <>'') OR
    (record_type = FFD.Constants.RecordType.LH AND in_flags.consumer_flags.alert_legal_flag <>''); 
  
  EXPORT  prepareAlertMessages (DATASET (FFD.Layouts.PersonContextBatch) PersonContext, 
                                FFD.layouts.ConsumerFlagsBatch in_consumer_flags,
                                INTEGER8 inFFDOptionsMask = 0) := FUNCTION

    isSuppressedResult := in_consumer_flags.suppress_records;
    returnBlank := ~FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask); 
    
    consumer_alerts := PROJECT (PersonContext(RecordType IN FFD.Constants.RecordType.AlertFlags),
                           TRANSFORM(iesp.share_fcra.t_ConsumerAlert,
                             SELF.UniqueId      := LEFT.LexID,    
                             SELF.Timestamp     := iesp.ECL2ESP.toTimeStamp(STD.Str.FilterOut(LEFT.DateAdded, '-:')),
                             SELF.Code          := IF(RaiseAlert(LEFT.RecordType, in_consumer_flags), FCRA.Constants.convertAlertType2Code(LEFT.RecordType), SKIP),
                             SELF.Message       := LEFT.Content));

    has_statements_alert := IF(in_consumer_flags.has_record_statement OR in_consumer_flags.has_consumer_statement,
                         PROJECT(DEDUP(SORT(PersonContext((~isSuppressedResult AND RecordType IN FFD.Constants.RecordType.StatementRecordLevel)  
                                                              OR RecordType IN FFD.Constants.RecordType.StatementConsumerLevel),
                             LexID, -DateAdded, RecordType), LexID),
                           TRANSFORM(iesp.share_fcra.t_ConsumerAlert,
                             SELF.UniqueId      := left.LexID,    
                             SELF.Timestamp     := iesp.ECL2ESP.toTimeStamp(STD.Str.FilterOut(left.DateAdded, '-:')),
                             SELF.Code          := FCRA.Constants.convertAlertType2Code(FFD.Constants.RecordType.CS),
                             SELF.Message       := FFD.Constants.AlertMessage.CSMessage)),
                             FFD.Constants.BlankConsumerAlerts);

   RETURN IF(returnBlank, FFD.Constants.BlankConsumerAlerts,
		        consumer_alerts + has_statements_alert);
  END;
  
  EXPORT prepareAlertMessagesBatch (DATASET(FFD.Layouts.PersonContextBatch) PersonContext,
                                    DATASET(FFD.layouts.ConsumerFlagsBatch) ds_consumer_flags,
                                    INTEGER8 inFFDOptionsMask = 0) := FUNCTION

    returnBlank := ~FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask); 
    
		consumer_alerts := PROJECT (PersonContext(RecordType IN FFD.Constants.RecordType.AlertFlags),
                           TRANSFORM (FFD.layouts.ConsumerStatementBatchFull,
                                  SELF.acctno := LEFT.acctno ,
                                  SELF.SequenceNumber := 0, // Consumer level alerts are for the whole DID, not specefic data rows. 
                                  SELF.UniqueID := (UNSIGNED)LEFT.LexID,
                                  SELF.RecordType := LEFT.RecordType,
                                  SELF.SectionId := ''; 
                                  SELF := LEFT));

    // logic on what alerts should be reported for the subject is defined in ds_consumer_flags, using it to filter alerts accordingly
    consumer_alerts_fltrd := JOIN(consumer_alerts, ds_consumer_flags,
                                 LEFT.acctno = RIGHT.acctno AND LEFT.UniqueID = (UNSIGNED) RIGHT.UniqueID,
                                 TRANSFORM(FFD.layouts.ConsumerStatementBatchFull,
                                           SELF.RecordType := IF(RaiseAlert(LEFT.RecordType, RIGHT), LEFT.RecordType, SKIP),
                                           SELF := LEFT),
                                 KEEP(1), LIMIT(0));

    RETURN IF(returnBlank, DATASET([],FFD.layouts.ConsumerStatementBatchFull),
		          consumer_alerts_fltrd);
  END;

  STRING1 subject_has_alert := FFD.Constants.subject_has_alert;
  
  FFD.layouts.ConsumerFlagsBatch xf_prepare_alerts(FFD.Layouts.PersonContextBatch re,
                                                    INTEGER purpose, BOOLEAN suppressIT, 
                                                    BOOLEAN isReseller) := TRANSFORM
      is_security_fraud_alert := re.RecordType = FFD.Constants.RecordType.FA;
      is_security_freeze := ~isReseller AND re.RecordType = FFD.Constants.RecordType.SF AND purpose IN re.set_FCRA_purpose; // SF is not applicable to re-Sellers
      is_identity_theft := re.RecordType = FFD.Constants.RecordType.IT;
      
      SELF.acctno := re.acctno;
      SELF.UniqueID := re.LexID;
      suppress_due_alerts := re.suppress_for_legal_hold OR (~isReseller AND is_security_fraud_alert) 
                             OR is_security_freeze
                             OR (is_identity_theft AND (suppressIT OR isReseller));
      SELF.suppress_records := suppress_due_alerts;                       
      SELF.has_record_statement := re.RecordType IN FFD.Constants.RecordType.StatementRecordLevel;                       
      SELF.has_consumer_statement := re.RecordType IN FFD.Constants.RecordType.StatementConsumerLevel;                       
      SELF.consumer_flags.alert_security_freeze := IF(is_security_freeze, subject_has_alert,'');
      SELF.consumer_flags.alert_security_fraud := IF(is_security_fraud_alert, subject_has_alert,'');
      SELF.consumer_flags.alert_identity_theft := IF(is_identity_theft, subject_has_alert,'');
      SELF.consumer_flags.alert_legal_flag := IF(re.RecordType = FFD.Constants.RecordType.LH, PersonContext.Constants.LegalFlag.Hold,'');
      SELF.consumer_flags.alert_cnsmr_statement := '';  // this will be set later
  END;
    
  FFD.layouts.ConsumerFlagsBatch  xf_roll_alerts(FFD.layouts.ConsumerFlagsBatch le, FFD.layouts.ConsumerFlagsBatch ri) := TRANSFORM
      SELF.acctno := le.acctno;
      SELF.UniqueID := le.UniqueID;
      SELF.suppress_records := le.suppress_records OR ri.suppress_records;
      SELF.has_record_statement := le.has_record_statement OR ri.has_record_statement;
      SELF.has_consumer_statement := le.has_consumer_statement OR ri.has_consumer_statement;
      // keeping consumer level statement flag separately from record level statement flag till final batch application                       
      SELF.consumer_flags.alert_cnsmr_statement := '';  // this will be used by batch and set later
      SELF.consumer_flags.alert_security_freeze := IF(le.consumer_flags.alert_security_freeze<>'',le.consumer_flags.alert_security_freeze, ri.consumer_flags.alert_security_freeze);
      SELF.consumer_flags.alert_security_fraud := IF(le.consumer_flags.alert_security_fraud<>'',le.consumer_flags.alert_security_fraud, ri.consumer_flags.alert_security_fraud);
      SELF.consumer_flags.alert_identity_theft := IF(le.consumer_flags.alert_identity_theft<>'',le.consumer_flags.alert_identity_theft, ri.consumer_flags.alert_identity_theft);
      SELF.consumer_flags.alert_legal_flag := IF(le.consumer_flags.alert_legal_flag<>'',le.consumer_flags.alert_legal_flag, ri.consumer_flags.alert_legal_flag);
  END;
    
  FFD.layouts.ConsumerFlagsBatch  xf_filter_alerts(FFD.layouts.ConsumerFlagsBatch le) := TRANSFORM
      is_legal_hold := le.consumer_flags.alert_legal_flag <> '' AND le.suppress_records;
      SELF.suppress_records := le.suppress_records;
      // supress all in case of LH
      SELF.has_record_statement := IF(is_legal_hold, FALSE, le.has_record_statement);
      SELF.has_consumer_statement := IF(is_legal_hold, FALSE, le.has_consumer_statement);
      SELF.consumer_flags.alert_legal_flag := le.consumer_flags.alert_legal_flag;
      SELF.consumer_flags.alert_cnsmr_statement := IF(is_legal_hold, '', le.consumer_flags.alert_cnsmr_statement);  
      SELF.consumer_flags.alert_security_freeze := IF(is_legal_hold, '', le.consumer_flags.alert_security_freeze);
      SELF.consumer_flags.alert_security_fraud := IF(is_legal_hold, '', le.consumer_flags.alert_security_fraud);
      SELF.consumer_flags.alert_identity_theft := IF(is_legal_hold, '', le.consumer_flags.alert_identity_theft);
      SELF := le;
  END;
    
  EXPORT getAlertIndicators (DATASET (FFD.Layouts.PersonContextBatch) PersonContext,
                             INTEGER in_permissible_purpose = FCRA.FCRAPurpose.NoPermissiblePurpose,
                             INTEGER8 inFFDOptionsMask = 0,
                             BOOLEAN isReseller = FALSE) := FUNCTION

    BOOLEAN in_suppress_records_withIT := FFD.FFDMask.isSuppressRecordsWhenITAlert(inFFDOptionsMask);
    
    pc_alerts := PersonContext(RecordType IN [FFD.Constants.RecordType.AlertFlags, 
                                              FFD.Constants.RecordType.StatementRecordLevel,
                                              FFD.Constants.RecordType.StatementConsumerLevel]);
    
    tr_alerts := PROJECT(pc_alerts, xf_prepare_alerts(LEFT, in_permissible_purpose, in_suppress_records_withIT, isReseller));
    
    srt_alerts := SORT(tr_alerts, acctno, UniqueID);
                       
    rolled_alerts := ROLLUP(srt_alerts, LEFT.acctno = RIGHT.acctno AND LEFT.UniqueID = RIGHT.UniqueID, 
                           xf_roll_alerts(LEFT,RIGHT));

    filtered_alerts := PROJECT(rolled_alerts, xf_filter_alerts(LEFT));

    RETURN filtered_alerts;                       
 END;                          
END;