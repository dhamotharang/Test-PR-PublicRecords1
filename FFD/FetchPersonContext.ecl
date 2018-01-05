IMPORT FFD, PersonContext, Gateway, STD;

  ExpandPersonContext (DATASET(PersonContext.Layouts.Layout_PCResponseRec) pc_in) := FUNCTION
  // for some record types Content field contains additional data which need to be moved to expanded layout 

    FFD.Layouts.PersonContextBatch xform_alerts (PersonContext.Layouts.Layout_PCResponseRec le) := TRANSFORM
    
      consumer_phone := IF(le.RecordType = FFD.Constants.RecordType.FA, STD.Str.CleanSpaces(le.Content), ''); // the phone provided by consumer for verification purposes in case of Fraud Alert
      LH_flag := IF(le.RecordType = FFD.Constants.RecordType.LH, STD.Str.CleanSpaces(le.Content), ''); // Expected values in content field: SP (Suppress Product), SA (Suppress All), Empty for no suppression
      SELF.suppress_for_legal_hold := LH_flag = PersonContext.Constants.LegalFlag.SuppressProduct OR LH_flag = PersonContext.Constants.LegalFlag.SuppressAll;
      SELF.set_FCRA_purpose := IF(le.RecordType = FFD.Constants.RecordType.SF, STD.Str.SplitWords(STD.Str.CleanSpaces(le.Content), ','), []);
      SELF.Content := CASE(le.RecordType, 
                            FFD.Constants.RecordType.IT => FFD.Constants.AlertMessage.IDTheftMessage,
                            FFD.Constants.RecordType.LH => '', //FFD.Constants.AlertMessage.LegalHoldMessage,
                            FFD.Constants.RecordType.SF => FFD.Constants.AlertMessage.FreezeMessage,
                            FFD.Constants.RecordType.FA => FFD.Constants.AlertMessage.FraudMessage + 
                                                IF(consumer_phone<>'', ' ' + FFD.Constants.AlertMessage.ConsumerPhoneMessage + consumer_phone,''),
                            le.Content);
      SELF := le;
      SELF := [];
    END;
    
    res := PROJECT(pc_in, xform_alerts(LEFT));
    RETURN res;                                
  END;


EXPORT FetchPersonContext (DATASET(FFD.Layouts.DidBatch) dids,
                           DATASET(Gateway.Layouts.Config) gateways = Gateway.Constants.void_gateway,
                           SET OF STRING data_group_set = [],                           
                           INTEGER8 inFFDOptionsMask = FFD.Constants.ConsumerOptions.SHOW_CONSUMER_STATEMENTS    // by default consumer statements are not filtered                       
                          ) := FUNCTION

  BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

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
  request := ROW (load_request());
  response := PersonContext.GetPersonContext (request);
  
  /* use line below for testing with canned data */  
  // res := IF(FFD._FakePersonContextData.Ignore, response[1].Records, FFD._FakePersonContextData.Records);

  // clean the response by moving supplemental info from Content field into expanded layout
  pc_recs := ExpandPersonContext(response[1].Records);  
  
  // restore acctno for batch
  recs := JOIN (dids, pc_recs(searchstatus = FFD.Constants.StatusCode.ResultsFound),
            LEFT.DID = (unsigned) right.LexID,
            TRANSFORM (FFD.Layouts.PersonContextBatch,
                       SELF.acctno := LEFT.acctno, 
                       SELF := RIGHT)); 
                       
  recs_filt := recs((~apply_group_filter OR datagroup in data_group_set)
                    AND (showConsumerStatements OR RecordType IN FFD.Constants.RecordType.ComplianceSet));    
  
  RETURN recs_filt;
END;