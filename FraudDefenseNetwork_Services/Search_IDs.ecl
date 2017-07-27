IMPORT FraudShared_Services;

EXPORT Search_IDs( 
  DATASET(FraudShared_Services.Layouts.batch_search_rec) ds_in,
  string fraud_platform,
  boolean filterBy_entity_type
) := FUNCTION

	ds_validationMod:= FraudShared_Services.ValidateInput.ValidateBatchSearchInput(ds_in);
	
	ds_auto := FraudDefenseNetwork_Services.fn_postautokey_joins(ds_in);
	
  ds_entityIds := FraudShared_Services.Collect_EntitiesIDs(ds_in, ds_validationMod, fraud_platform, filterBy_entity_type);
    
	ds_ids := DEDUP(ds_auto + ds_entityIds, ALL);
    
  // OUTPUT(ds_validationMod, NAMED('FDN_Search_IDs__ds_validationMod'));
  // OUTPUT(ds_auto, NAMED('FDN_Search_IDs__ds_auto'));
  // OUTPUT(ds_entityIds, NAMED('FDN_Search_IDs__ds_entityIds'));
  // OUTPUT(ds_ids, NAMED('FDN_Search_IDs__ds_ids'));

	RETURN ds_ids;
END;
