IMPORT FraudShared, FraudShared_Services, iesp;

EXPORT fn_GetPayloadRecords(
  DATASET(FraudShared_Services.Layouts.Recid_rec) ds_ids,
	FraudGovPlatform_Services.IParam.BatchParams batch_params, 
	DATASET(iesp.frauddefensenetwork.t_FDNIndType) ds_industry_types_in = DATASET([],iesp.frauddefensenetwork.t_FDNIndType),             
	DATASET(iesp.frauddefensenetwork.t_FDNFileType) ds_file_types_in = DATASET([],iesp.frauddefensenetwork.t_FDNFileType),
  string fraud_platform
) := FUNCTION

  // JOIN RECORD_ID with Payload
  results := JOIN(
    ds_ids, FraudShared.Key_Id(fraud_platform),
    KEYED(LEFT.RECORD_ID = RIGHT.RECORD_ID),
		TRANSFORM(FraudShared_Services.Layouts.Raw_Payload_rec, 
		  SELF.acctno := LEFT.acctno,
			SELF := RIGHT,
			SELF := LEFT),
		LIMIT(0));
		
		// *** No filtering in FraudGov
  ds_recs_pulled := FraudShared_Services.Common_Suppress(results);
	
  ds_FilterThruMBS := FraudShared_Services.FilterThruMBS(ds_recs_pulled, batch_params.GlobalCompanyId, batch_params.IndustryType, batch_params.ProductCode, ds_industry_types_in, ds_file_types_in, fraud_platform);

    // OUTPUT(results, NAMED('GetPayloadRecords'));
   RETURN ds_FilterThruMBS;
END;
