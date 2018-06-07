
EXPORT Collect_EntitiesIDs(
  DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
  string fraud_platform,
  boolean filterBy_entity_type
) := FUNCTION

  ds_valid_in := FraudShared_Services.ValidateInput.BuildValidityRecs(ds_batch_in);

  ds_did                  := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type).GetLexID();
  ds_ip                   := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type).GetIp();
  ds_linkId               := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type).GetLinkIds();
  ds_device_id            := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type).GetDeviceID();
  ds_professional_id      := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type).GetProfessionalID();
  ds_tin                  := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type).GetTIN();
  ds_email                := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type).GetEmail();
  ds_bankaccountnumber    := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type).GetBankAccountNumber();
  ds_dlnumber					    := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type).GetDriverLicenses();
  ds_appended_provider_id := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type).GetAppendedProviderID();
  ds_provider_npi         := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type).GetNPI();
  ds_provider_lnpid       := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type).GetLNPID();
  ds_provider             := ds_provider_npi + ds_provider_lnpid + ds_appended_provider_id; 

  ds_ids := ds_did + ds_ip + ds_linkId + ds_device_id + ds_professional_id + ds_tin + ds_provider + ds_email + ds_bankaccountnumber + ds_dlnumber;

  RETURN ds_ids;
END;
