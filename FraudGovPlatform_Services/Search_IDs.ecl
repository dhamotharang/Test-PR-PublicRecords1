IMPORT FraudShared_Services;

EXPORT Search_IDs(
  DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
  string fraud_platform = FraudShared_Services.Constants.Platform.FraudGov,
  boolean filterBy_entity_type = FALSE
) := FUNCTION
	
	 ds_auto := FraudGovPlatform_Services.fn_postautokey_joins(ds_batch_in, fraud_platform);
  
  ds_entityIds := FraudShared_Services.Collect_EntitiesIDs(ds_batch_in, fraud_platform, filterBy_entity_type,FraudGovPlatform_services.Constants.Limits.MAX_JOIN_LIMIT);
    
	 ds_ids := DEDUP(ds_auto + ds_entityIds, ALL);

  // OUTPUT(ds_validationMod, NAMED('GOV_Search_IDs__ds_validationMod'));
  // OUTPUT(ds_autoKeys, NAMED('GOV_Search_IDs__ds_autoKeys'));
  // OUTPUT(ds_auto, NAMED('GOV_Search_IDs__ds_auto'));
  // OUTPUT(ds_entityIds, NAMED('GOV_Search_IDs__ds_entityIds'));
  // OUTPUT(ds_ids, NAMED('GOV_Search_IDs__ds_ids'));

 	RETURN ds_ids;

END;
