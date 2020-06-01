IMPORT FraudShared, FraudShared_Services, iesp, RiskIntelligenceNetwork_Services;

EXPORT fn_GetPayloadRecords(DATASET(FraudShared_Services.Layouts.Recid_rec) ds_ids,
                                    RiskIntelligenceNetwork_Services.IParam.Params in_mod,
                                    DATASET(iesp.frauddefensenetwork.t_FDNIndType) ds_industry_types_in = DATASET([],iesp.frauddefensenetwork.t_FDNIndType),             
                                    DATASET(iesp.frauddefensenetwork.t_FDNFileType) ds_file_types_in = DATASET([],iesp.frauddefensenetwork.t_FDNFileType),
                                    string fraud_platform) := FUNCTION

 // JOIN RECORD_ID with Payload
 results := JOIN(ds_ids, FraudShared.Key_Id(fraud_platform),
              KEYED(LEFT.RECORD_ID = RIGHT.RECORD_ID),
                TRANSFORM(FraudShared_Services.Layouts.Raw_Payload_rec, 
                  SELF.acctno := LEFT.acctno,
                  SELF := RIGHT,
                  SELF := LEFT),
              LIMIT(0));

 ds_recs_pulled := FraudShared_Services.Common_Suppress(results);

 ds_FilterThruMBS := FraudShared_Services.FilterThruMBS(ds_recs_pulled, in_mod.GlobalCompanyId, in_mod.IndustryType, in_mod.ProductCode, ds_industry_types_in, ds_file_types_in, fraud_platform);
 RETURN ds_FilterThruMBS;
END;
