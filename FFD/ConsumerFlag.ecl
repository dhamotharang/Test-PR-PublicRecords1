IMPORT FCRA, FFD, iesp, PersonContext, STD;
EXPORT ConsumerFlag := MODULE

  EXPORT  prepareAlertMessages (DATASET (FFD.Layouts.PersonContextBatch) PersonContext, BOOLEAN isSuppressedResult = FALSE) := FUNCTION

    consumer_alerts := PROJECT (PersonContext(RecordType IN FFD.Constants.RecordType.AlertFlags),
                           TRANSFORM(iesp.share_fcra.t_ConsumerAlert,
                             SELF.UniqueId      := left.LexID,    
                             SELF.Timestamp     := iesp.ECL2ESP.toTimeStamp(STD.Str.FilterOut(left.DateAdded, '-:')),
                             SELF.Code          := FCRA.Constants.convertAlertType2Code(left.RecordType),
                             SELF.Message       := left.Content));

    has_statements_alert := PROJECT(DEDUP(SORT(PersonContext((~isSuppressedResult AND RecordType IN FFD.Constants.RecordType.StatementRecordLevel)  
                                                              OR RecordType IN FFD.Constants.RecordType.StatementConsumerLevel),
                             LexID, -DateAdded, RecordType), LexID),
                           TRANSFORM(iesp.share_fcra.t_ConsumerAlert,
                             SELF.UniqueId      := left.LexID,    
                             SELF.Timestamp     := iesp.ECL2ESP.toTimeStamp(STD.Str.FilterOut(left.DateAdded, '-:')),
                             SELF.Code          := FCRA.Constants.convertAlertType2Code(FFD.Constants.RecordType.CS),
                             SELF.Message       := FFD.Constants.AlertMessage.CSMessage));

    RETURN consumer_alerts + has_statements_alert;
  END;
  
  EXPORT prepareAlertMessagesBatch (DATASET (FFD.Layouts.PersonContextBatch) PersonContext) := FUNCTION

    consumer_alerts := PROJECT (PersonContext(RecordType IN FFD.Constants.RecordType.AlertFlags),
                           TRANSFORM (FFD.layouts.ConsumerStatementBatchFull,
                                  SELF.acctno := LEFT.acctno ,
                                  SELF.SequenceNumber := 0, // Consumer level alerts are for the whole DID, not specefic data rows. 
                                  SELF.UniqueID := (UNSIGNED)LEFT.LexID,
                                  SELF.RecordType := LEFT.RecordType,
                                  SELF.SectionId := ''; 
                                  SELF := LEFT));

    RETURN consumer_alerts;
  END;

  STRING1 subject_has_alert := 'Y';
  
  FFD.layouts.ConsumerFlagsBatch  xf_prepare_alerts(FFD.Layouts.PersonContextBatch re,
                                                    INTEGER purpose, BOOLEAN suppressIT) := TRANSFORM
      is_security_fraud_alert := re.RecordType = FFD.Constants.RecordType.FA;
      is_security_freeze := re.RecordType = FFD.Constants.RecordType.SF;
      is_identity_theft := re.RecordType = FFD.Constants.RecordType.IT;
      permissible_purpose_list := re.set_FCRA_purpose;  
      
      SELF.acctno := re.acctno;
      SELF.UniqueID := re.LexID;
      suppress_due_alerts := re.suppress_for_legal_hold OR is_security_fraud_alert 
                             OR (is_security_freeze AND purpose IN permissible_purpose_list)
                             OR (is_identity_theft AND suppressIT);
      SELF.suppress_records := suppress_due_alerts;                       
      SELF.consumer_flags.has_consumer_statement := IF((~suppress_due_alerts AND re.RecordType IN FFD.Constants.RecordType.StatementRecordLevel) 
                                                        OR re.RecordType IN FFD.Constants.RecordType.StatementConsumerLevel, subject_has_alert,'');
      SELF.consumer_flags.security_freeze := IF(is_security_freeze, subject_has_alert,'');
      SELF.consumer_flags.security_fraud_alert := IF(is_security_fraud_alert, subject_has_alert,'');
      SELF.consumer_flags.identity_theft := IF(is_identity_theft, subject_has_alert,'');
      SELF.consumer_flags.legal_flag := IF(re.RecordType = FFD.Constants.RecordType.LH, PersonContext.Constants.LegalFlag.Hold,'');
  END;
    
  FFD.layouts.ConsumerFlagsBatch  xf_roll_alerts(FFD.Layouts.ConsumerFlagsBatch le, 
                                                FFD.Layouts.ConsumerFlagsBatch ri) := TRANSFORM
      SELF.acctno := le.acctno;
      SELF.UniqueID := le.UniqueID;
      SELF.suppress_records := le.suppress_records OR ri.suppress_records;
                             
      SELF.consumer_flags.has_consumer_statement := IF(le.consumer_flags.has_consumer_statement<>'',le.consumer_flags.has_consumer_statement, ri.consumer_flags.has_consumer_statement);
      SELF.consumer_flags.security_freeze := IF(le.consumer_flags.security_freeze<>'',le.consumer_flags.security_freeze, ri.consumer_flags.security_freeze);
      SELF.consumer_flags.security_fraud_alert := IF(le.consumer_flags.security_fraud_alert<>'',le.consumer_flags.security_fraud_alert, ri.consumer_flags.security_fraud_alert);
      SELF.consumer_flags.identity_theft := IF(le.consumer_flags.identity_theft<>'',le.consumer_flags.identity_theft, ri.consumer_flags.identity_theft);
      SELF.consumer_flags.legal_flag := IF(le.consumer_flags.legal_flag<>'',le.consumer_flags.legal_flag, ri.consumer_flags.legal_flag);
  END;
    
  EXPORT getAlertIndicators (DATASET (FFD.Layouts.PersonContextBatch) PersonContext,
                             INTEGER in_permissible_purpose = FCRA.FCRAPurpose.NoPermissiblePurpose,
                             INTEGER8 inFFDOptionsMask = 0) := FUNCTION

    BOOLEAN in_suppress_records_withIT := FFD.FFDMask.isSuppressRecordsWhenITAlert(inFFDOptionsMask);
    
    pc_alerts := PersonContext(RecordType IN [FFD.Constants.RecordType.AlertFlags, 
                                              FFD.Constants.RecordType.StatementRecordLevel,
                                              FFD.Constants.RecordType.StatementConsumerLevel]);
    
    tr_alerts := PROJECT(pc_alerts, xf_prepare_alerts(LEFT, in_permissible_purpose, in_suppress_records_withIT));
    
    srt_alerts := SORT(tr_alerts, acctno, UniqueID);
                       
    rolled_alerts := ROLLUP(srt_alerts, LEFT.acctno = RIGHT.acctno AND LEFT.UniqueID = RIGHT.UniqueID, 
                           xf_roll_alerts(LEFT,RIGHT));
    RETURN rolled_alerts;                       
 END;                          
END;