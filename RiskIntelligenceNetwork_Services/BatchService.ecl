IMPORT AutoheaderV2, BatchShare, FraudShared_Services, RiskIntelligenceNetwork_Services, ut, WSInput; 

EXPORT BatchService() := MACRO
 //The following macro defines the field sequence on WsECL page of query. 
 WSInput.MAC_RiskIntelligenceNetwork_Services_BatchService();
 
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
 #CONSTANT('useonlybestdid',true);
 #CONSTANT('FraudPlatform', 'FraudGov');
 
 // **************************************************************************************
 // Read parameters and XML input. Providing a canned dataset for testing is optional,
 // but it comes in handy for everyone else.
 // **************************************************************************************
 batch_params := RiskIntelligenceNetwork_Services.IParam.getParams();
 ds_batch_in := DATASET([], FraudShared_Services.Layouts.BatchIn_rec) : STORED('batch_in', FEW);
 
 // **************************************************************************************
 //Checking that gc_id, industry type, and product code have some values - they are required.
 IF(batch_params.GlobalCompanyId = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_GC_ID));
 IF(batch_params.IndustryType = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_INDUSTRY_TYPE));
 IF(batch_params.ProductCode = 0, FraudShared_Services.Utilities.FailMeWithCode(ut.constants_MessageCodes.FRAUDGOV_PRODUCT_CODE));
 // **************************************************************************************
 
 // **************************************************************************************
 // Preprocess input as necessary
 // ************************************************************************************** 
 BatchShare.MAC_SequenceInput(ds_batch_in, ds_sequenced);
 BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_cap_in);
 BatchShare.MAC_CleanAddresses(ds_cap_in, ds_batch_in_cleaned);

 ds_batchrecords := RiskIntelligenceNetwork_Services.BatchRecords(ds_batch_in_cleaned, batch_params);
 BatchShare.MAC_RestoreAcctno(ds_batch_in_cleaned,ds_batchrecords,Results,true,false);

 OUTPUT(Results, named('Results'));
 
ENDMACRO;