IMPORT FraudShared_Services, iesp, ut;

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

  // ds_batch_in_seq := FraudShared_Services.Functions.SetSequences(ds_batch_in);

  ds_ids := FraudGovPlatform_Services.Search_IDs(ds_batch_in, fraud_platform, filterBy_entity_type);
	
  ds_Raw := FraudShared_Services.GetPayloadRecords(ds_ids, fraud_platform);

  // *** No filtering in FraudGov
  ds_recs_pulled := FraudShared_Services.Common_Suppress(ds_Raw);
	
	// --- TO BE USED LATER ON WHEN ITS READY TO USE----- //
  // ds_appendDeltabase := FraudShared_Services.Common_Deltabase(ds_batch_in, ds_recs_pulled, ds_file_types_in, DeltaUse, DeltaStrict);
  ds_FilterThruMBS := FraudShared_Services.FilterThruMBS(ds_recs_pulled, gc_id_in, ind_type_in, product_code_in, ds_industry_types_in, ds_file_types_in, fraud_platform);

  ds_allPayloadRecs := ds_FilterThruMBS;
	
	RETURN ds_allPayloadRecs;
END; 
