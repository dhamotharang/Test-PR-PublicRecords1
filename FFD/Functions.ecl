IMPORT FFD, PersonContext, Gateway, STD;

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

END;