IMPORT FFD, PersonContext, Gateway;

// batch version for getting person context
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
  pc_recs := response[1].Records;  
  
  recs := JOIN (dids, pc_recs(searchstatus = FFD.Constants.StatusCode.ResultsFound),
            LEFT.DID = (unsigned) right.LexID,
            TRANSFORM (FFD.Layouts.PersonContextBatch,
                       SELF.acctno := LEFT.acctno, SELF := RIGHT)); 
                       
  recs_filt := recs((~apply_group_filter OR datagroup in data_group_set)
                    AND (showConsumerStatements OR RecordType IN FFD.Constants.RecordType.ComplianceSet));    
  
  RETURN recs_filt;
END;