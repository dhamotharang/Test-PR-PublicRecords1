IMPORT FraudShared;

EXPORT Collect_EntitiesIDs(
  DATASET(FraudShared_Services.Layouts.batch_search_rec) ds_in = DATASET([],FraudShared_Services.Layouts.batch_search_rec),
  DATASET(FraudShared_Services.Layouts.batch_search_flags_rec) ds_validationMod,
  string fraud_platform,
  boolean filterBy_entity_type
) := FUNCTION

  ds_validMod := ds_validationMod(isValidSearchInput);

  ds_did                  := FraudShared_Services.EntitiesIds(fraud_platform, filterBy_entity_type).GetLexID(ds_in(did != 0));
  ds_ip                   := FraudShared_Services.EntitiesIds(fraud_platform, filterBy_entity_type).GetIp(ds_validMod(isIpAddress));
  ds_linkId               := FraudShared_Services.EntitiesIds(fraud_platform, filterBy_entity_type).GetLinkIds(ds_validMod(isBusiness));
  ds_device_id            := FraudShared_Services.EntitiesIds(fraud_platform, filterBy_entity_type).GetDeviceID(ds_validMod(isDevice));
  ds_professional_id      := FraudShared_Services.EntitiesIds(fraud_platform, filterBy_entity_type).GetProfessionalID(ds_validMod(isProfessionalid));
  ds_tin                  := FraudShared_Services.EntitiesIds(fraud_platform, filterBy_entity_type).GetTIN(ds_validMod(isTin));
  ds_email                := FraudShared_Services.EntitiesIds(fraud_platform, filterBy_entity_type).GetEmail(ds_validMod(isEmailAddress));
  ds_appended_provider_id := FraudShared_Services.EntitiesIds(fraud_platform, filterBy_entity_type).GetAppendedProviderID(ds_validMod(isProvider AND appendedproviderid > 0));
  ds_provider_npi         := FraudShared_Services.EntitiesIds(fraud_platform, filterBy_entity_type).GetNPI(ds_validMod(isProvider AND npi <> ''));
  ds_provider_lnpid       := FraudShared_Services.EntitiesIds(fraud_platform, filterBy_entity_type).GetLNPID(ds_validMod(isProvider AND lnpid > 0));
  ds_provider             := (ds_provider_npi + ds_provider_lnpid + ds_appended_provider_id); 
  
  ds_ids := ds_did + ds_ip + ds_linkId + ds_device_id + ds_professional_id + ds_tin + ds_provider + ds_email;

  RETURN ds_ids;
END;
