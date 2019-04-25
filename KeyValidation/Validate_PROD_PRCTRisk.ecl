EXPORT Validate_PROD_PRCTRisk(buildVersion, isPROD=true ) := functionmacro
  
Import KeyValidation,  Data_Services, ut, doxie, ut,Seed_Files,lib_stringlib;
DatasetName := 'TestseedRisk';	

// Key instantid
	riskview2Summary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.riskview2KeyName,
																																				KeyValidation.PRCTMappings.riskview2KeyType,
																																				KeyValidation.PRCTMappings.riskview2ParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_riskview2,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_riskview2,
																																				KeyValidation.PRCTMappings.riskview2KeySet,
																																				KeyValidation.PRCTMappings.riskview2ParentSet,
																																				KeyValidation.PRCTMappings.riskview2IgnoredFields ,
																																				KeyValidation.PRCTMappings.riskview2UniqueField , isPROD);		
	
																																				
// RiskView
	RiskViewSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.RiskViewKeyName,
																																				KeyValidation.PRCTMappings.RiskViewKeyType,
																																				KeyValidation.PRCTMappings.RiskViewParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_RiskView,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_RiskView,
																																				KeyValidation.PRCTMappings.RiskViewKeySet,
																																				KeyValidation.PRCTMappings.RiskViewParentSet,
																																				KeyValidation.PRCTMappings.RiskViewIgnoredFields ,
																																				KeyValidation.PRCTMappings.RiskViewUniqueField , isPROD);	
		// RV_Attributes																																
		RVAttributesSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.RVAttributesKeyName,
																																				KeyValidation.PRCTMappings.RVAttributesKeyType,
																																				KeyValidation.PRCTMappings.RVAttributesParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_RVAttributes,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_RVAttributes,
																																				KeyValidation.PRCTMappings.RVAttributesKeySet,
																																				KeyValidation.PRCTMappings.RVAttributesParentSet,
																																				KeyValidation.PRCTMappings.RVAttributesIgnoredFields ,
																																				KeyValidation.PRCTMappings.RVAttributesUniqueField , isPROD);	
 		 
		 																																			
																																				
 	//FCRA_GongHistory																																		
	FCRA_GongHistorySummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.FCRA_GongHistoryKeyName,
																																				KeyValidation.PRCTMappings.FCRA_GongHistoryKeyType,
																																				KeyValidation.PRCTMappings.FCRA_GongHistoryParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_FCRA_GongHistory,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_FCRA_GongHistory,
																																				KeyValidation.PRCTMappings.FCRA_GongHistoryKeySet,
																																				KeyValidation.PRCTMappings.FCRA_GongHistoryParentSet,
																																				KeyValidation.PRCTMappings.FCRA_GongHistoryIgnoredFields ,
																																				KeyValidation.PRCTMappings.FCRA_GongHistoryUniqueField , isPROD);																																				
		 	RVderogsSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.RVderogsKeyName,
																																				KeyValidation.PRCTMappings.RVderogsKeyType,
																																				KeyValidation.PRCTMappings.RVderogsParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_RVderogs,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_RVderogs,
																																				KeyValidation.PRCTMappings.RVderogsKeySet,
																																				KeyValidation.PRCTMappings.RVderogsParentSet,
																																				KeyValidation.PRCTMappings.RVderogsIgnoredFields ,
																																				KeyValidation.PRCTMappings.RVderogsUniqueField , isPROD);																																				
 		 
		 
		 PRCTSummary := riskview2Summary + RiskViewSummary + RVAttributesSummary + FCRA_GongHistorySummary + RVderogsSummary ;
										
  return PRCTSummary;																																				
endmacro;