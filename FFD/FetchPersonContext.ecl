IMPORT FFD, Gateway;

EXPORT FetchPersonContext (DATASET(FFD.Layouts.DidBatch) dids,
                           DATASET(Gateway.Layouts.Config) gateways = Gateway.Constants.void_gateway,
                           SET OF STRING data_group_set = [],                           
                           INTEGER8 inFFDOptionsMask = FFD.Constants.ConsumerOptions.SHOW_CONSUMER_STATEMENTS    // by default consumer statements are not filtered                       
                          ) := FUNCTION

  pc_response := FFD.Functions.FetchPersonContextAsResponse(dids, gateways, data_group_set);
  pc_recs := PROJECT(pc_response.Records, FFD.Layouts.PersonContextBatch);
  
  RETURN pc_recs;
END;