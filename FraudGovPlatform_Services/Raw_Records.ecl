IMPORT doxie, FraudShared_Services, iesp;

EXPORT Raw_Records(	DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
										FraudGovPlatform_Services.IParam.BatchParams batch_params, 
										DATASET(iesp.frauddefensenetwork.t_FDNIndType) ds_industry_types_in = DATASET([],iesp.frauddefensenetwork.t_FDNIndType),             
										DATASET(iesp.frauddefensenetwork.t_FDNFileType) ds_file_types_in = DATASET([],iesp.frauddefensenetwork.t_FDNFileType),
										string fraud_platform = FraudShared_Services.Constants.Platform.FraudGov,
										boolean filterBy_entity_type = FALSE,
										boolean isBatch = FALSE) := FUNCTION

  ds_ids := FraudGovPlatform_Services.Search_IDs(ds_batch_in, fraud_platform, filterBy_entity_type);
	
  ds_Raw := FraudGovPlatform_Services.fn_GetPayloadRecords(ds_ids, batch_params, 
																													ds_industry_types_in, ds_file_types_in, fraud_platform);

	ds_allPayloadRecs := IF(isBatch,
													LIMIT(ds_Raw,FraudGovPlatform_Services.Constants.MAX_RECS_ON_JOIN, SKIP),
													LIMIT(ds_Raw,FraudGovPlatform_Services.Constants.MAX_RECS_ON_JOIN, FAIL(203, doxie.ErrorCodes(203))));
	
	RETURN ds_allPayloadRecs;
END; 
