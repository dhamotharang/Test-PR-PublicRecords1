IMPORT FraudShared_Services, iesp;

EXPORT Raw_Records(	DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
										unsigned6 gc_id_in, 
										unsigned2 ind_type_in, 
										unsigned6 product_code_in, 
										DATASET(iesp.frauddefensenetwork.t_FDNIndType) ds_industry_types_in = DATASET([],iesp.frauddefensenetwork.t_FDNIndType),             
										DATASET(iesp.frauddefensenetwork.t_FDNFileType) ds_file_types_in = DATASET([],iesp.frauddefensenetwork.t_FDNFileType),
										INTEGER DeltaUse = 0,
										INTEGER DeltaStrict = 0,
										string fraud_platform = FraudShared_Services.Constants.Platform.FraudGov,
										boolean filterBy_entity_type = FALSE) := FUNCTION

  ds_ids := FraudGovPlatform_Services.Search_IDs(ds_batch_in, fraud_platform, filterBy_entity_type);
	
  ds_Raw := FraudShared_Services.GetPayloadRecords(ds_ids, fraud_platform);

  // *** No filtering in FraudGov
  ds_recs_pulled := FraudShared_Services.Common_Suppress(ds_Raw);
	
  ds_FilterThruMBS := FraudShared_Services.FilterThruMBS(ds_recs_pulled, gc_id_in, ind_type_in, product_code_in, ds_industry_types_in, ds_file_types_in, fraud_platform);

  ds_allPayloadRecs := ds_FilterThruMBS;
	
	RETURN ds_allPayloadRecs;
END; 
