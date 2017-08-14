IMPORT FraudShared_Services;

EXPORT Search_IDs( 
  DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
  string fraud_platform = FraudShared_Services.Constants.Platform.FDN,
  boolean filterBy_entity_type = TRUE
) := FUNCTION

  ds_auto := FraudDefenseNetwork_Services.fn_postautokey_joins(ds_batch_in, fraud_platform);
  
  ds_entityIds := FraudShared_Services.Collect_EntitiesIDs(ds_batch_in, fraud_platform, filterBy_entity_type);
    
  ds_ids := DEDUP(ds_auto + ds_entityIds, ALL);
    
  // OUTPUT(ds_auto, NAMED('FraudDefenseNetwork_Services_Search_IDs__ds_auto'));
  // OUTPUT(ds_entityIds, NAMED('FraudDefenseNetwork_Services_Search_IDs__ds_entityIds'));
  // OUTPUT(ds_ids, NAMED('FraudDefenseNetwork_Services_Search_IDs__ds_ids'));

  RETURN ds_ids;
END;
