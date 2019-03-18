
EXPORT Collect_EntitiesIDs(
  DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
  string fraud_platform,
  boolean filterBy_entity_type,
	unsigned join_limit = FraudShared_Services.Constants.MAX_RECS_ON_JOIN
) := FUNCTION

  ds_valid_in := FraudShared_Services.ValidateInput.BuildValidityRecs(ds_batch_in);
	_GetEntitiesIds := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type, join_limit);

  ds_did                  := _GetEntitiesIds.GetLexID();
  ds_ip                   := _GetEntitiesIds.GetIp();
  ds_linkId               := _GetEntitiesIds.GetLinkIds();
  ds_device_id            := _GetEntitiesIds.GetDeviceID();
  ds_professional_id      := _GetEntitiesIds.GetProfessionalID();
  ds_tin                  := _GetEntitiesIds.GetTIN();
  ds_email                := _GetEntitiesIds.GetEmail();
  ds_bankaccountnumber    := _GetEntitiesIds.GetBankAccountNumber();
  ds_dlnumber					    := _GetEntitiesIds.GetDriverLicenses();
  ds_appended_provider_id := _GetEntitiesIds.GetAppendedProviderID();
  ds_provider_npi         := _GetEntitiesIds.GetNPI();
  ds_provider_lnpid       := _GetEntitiesIds.GetLNPID();
  ds_provider             := ds_provider_npi + ds_provider_lnpid + ds_appended_provider_id; 

  ds_ids := ds_did + ds_ip + ds_linkId + ds_device_id + ds_professional_id + ds_tin + ds_provider + ds_email + ds_bankaccountnumber + ds_dlnumber;

  RETURN ds_ids;
END;
