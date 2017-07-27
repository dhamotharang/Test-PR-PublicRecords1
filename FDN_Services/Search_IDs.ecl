EXPORT Search_IDs(DATASET(FDN_Services.Layouts.batch_search_rec) ds_in = DATASET([],FDN_Services.Layouts.batch_search_rec)) := FUNCTION

	ds_validationMod:= FDN_Services.ValidateInput.ValidateBatchSearchInput(ds_in)(isValidSearchInput);
	
	ds_auto := fn_postautokey_joins(ds_in);
	
	ds_did									:= FDN_Services.EntitiesIds.GetLexID(ds_in(did != 0));
	ds_ip                   := FDN_Services.EntitiesIds.GetIp(ds_validationMod(isIpAddress));
	ds_linkId               := FDN_Services.EntitiesIds.GetLinkIds(ds_validationMod(isBusiness));
	ds_device_id            := FDN_Services.EntitiesIds.GetDeviceID(ds_validationMod(isDevice));
	ds_professional_id      := FDN_Services.EntitiesIds.GetProfessionalID(ds_validationMod(isProfessionalid));
	ds_tin                  := FDN_Services.EntitiesIds.GetTIN(ds_validationMod(isTin));
	ds_appended_provider_id := FDN_Services.EntitiesIds.GetAppendedProviderID(ds_validationMod(isProvider AND appendedproviderid > 0));
	ds_provider_npi         := FDN_Services.EntitiesIds.GetNPI(ds_validationMod(isProvider AND npi <> ''));
	ds_provider_lnpid       := FDN_Services.EntitiesIds.GetLNPID(ds_validationMod(isProvider AND lnpid > 0));
	ds_email       					:= FDN_Services.EntitiesIds.GetEmail(ds_validationMod(isEmailAddress));
	ds_provider 						:= (ds_provider_npi + ds_provider_lnpid + ds_appended_provider_id); 

	
	ds_ids	:=	DEDUP(ds_auto
									+	ds_did
									+ ds_ip
									+ ds_linkId
									+ ds_device_id
									+ ds_professional_id
									+ ds_tin
									+ ds_provider
									+ ds_email, ALL);
	
	
	 // OUTPUT(ds_auto ,NAMED('ds_auto'));
	 // OUTPUT(ds_ids ,NAMED('ds_ids'));
	 // OUTPUT(validationMod.isDevice ,NAMED('validationMod_isDevice'));
	 // OUTPUT(ds_device_id ,NAMED('ds_device_id'));								
	RETURN ds_ids;
END;
