EXPORT Validate_PROD_PRCT(buildVersion, isPROD=true ) := functionmacro
  
Import KeyValidation,  Data_Services, ut, doxie, ut,Seed_Files,lib_stringlib;
DatasetName := 'Testseed';	


// Key instantid
	instantidSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.instantidKeyName,
																																				KeyValidation.PRCTMappings.instantidKeyType,
																																				KeyValidation.PRCTMappings.instantidParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_instantid,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_Instantid1,
																																				KeyValidation.PRCTMappings.instantidKeySet,
																																				KeyValidation.PRCTMappings.instantidParentSet,
																																				KeyValidation.PRCTMappings.instantidIgnoredFields ,
																																				KeyValidation.PRCTMappings.instantidUniqueField , isPROD);		
	
																																				

// Key Binstantid
	BInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.BInstantIDKeyName,
																																				KeyValidation.PRCTMappings.BInstantIDKeyType,
																																				KeyValidation.PRCTMappings.BInstantIDParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_binstantid,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_BInstantid,
																																				KeyValidation.PRCTMappings.BInstantIDKeySet,
																																				KeyValidation.PRCTMappings.BInstantIDParentSet,
																																				KeyValidation.PRCTMappings.BInstantIDIgnoredFields ,
																																				KeyValidation.PRCTMappings.BInstantIDUniqueField , isPROD);		


	FlexIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.FlexIDKeyName,
																																				KeyValidation.PRCTMappings.FlexIDKeyType,
																																				KeyValidation.PRCTMappings.FlexIDParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_Flexid,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_Flexid,
																																				KeyValidation.PRCTMappings.FlexIDKeySet,
																																				KeyValidation.PRCTMappings.FlexIDParentSet,
																																				KeyValidation.PRCTMappings.FlexIDIgnoredFields ,
																																				KeyValidation.PRCTMappings.FlexIDUniqueField , isPROD);		

	LeadIntegrityAttributesSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.LeadIntegrityAttributesKeyName,
																																				KeyValidation.PRCTMappings.LeadIntegrityAttributesKeyType,
																																				KeyValidation.PRCTMappings.LeadIntegrityAttributesParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_LeadIntegrityAttributes,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_LeadIntegrityAttributes,
																																				KeyValidation.PRCTMappings.LeadIntegrityAttributesKeySet,
																																				KeyValidation.PRCTMappings.LeadIntegrityAttributesParentSet,
																																				KeyValidation.PRCTMappings.LeadIntegrityAttributesIgnoredFields ,
																																				KeyValidation.PRCTMappings.LeadIntegrityAttributesUniqueField , isPROD);		


AMLRiskAttributesV2Summary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesV2KeyName,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesV2KeyType,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesV2ParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_AMLRiskAttributesV2,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_AMLRiskAttributesV2,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesV2KeySet,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesV2ParentSet,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesV2IgnoredFields ,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesV2UniqueField , isPROD);																																			

AMLRiskAttributesSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesKeyName,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesKeyType,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_AMLRiskAttributes,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_AMLRiskAttributes,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesKeySet,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesParentSet,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesIgnoredFields ,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesUniqueField , isPROD);

	AMLRiskAttributesBusnSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnKeyName,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnKeyType,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_AMLRiskAttributesBusn,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_AMLRiskAttributesBusn,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnKeySet,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnParentSet,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnIgnoredFields ,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnUniqueField , isPROD);
	businessdefenderSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.businessdefenderKeyName,
																																				KeyValidation.PRCTMappings.businessdefenderKeyType,
																																				KeyValidation.PRCTMappings.businessdefenderParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_businessdefender,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_businessdefender,
																																				KeyValidation.PRCTMappings.businessdefenderKeySet,
																																				KeyValidation.PRCTMappings.businessdefenderParentSet,
																																				KeyValidation.PRCTMappings.businessdefenderIgnoredFields ,
																																				KeyValidation.PRCTMappings.businessdefenderUniqueField , isPROD);
	
	redflagsSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.redflagsKeyName,
																																				KeyValidation.PRCTMappings.redflagsKeyType,
																																				KeyValidation.PRCTMappings.redflagsParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_redflags,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_redflags,
																																				KeyValidation.PRCTMappings.redflagsKeySet,
																																				KeyValidation.PRCTMappings.redflagsParentSet,
																																				KeyValidation.PRCTMappings.redflagsIgnoredFields ,
																																				KeyValidation.PRCTMappings.redflagsUniqueField , isPROD);
																																				
		SmallBusModelsSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.SmallBusModelsKeyName,
																																				KeyValidation.PRCTMappings.SmallBusModelsKeyType,
																																				KeyValidation.PRCTMappings.SmallBusModelsParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_SmallBusModels,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_SmallBusModels,
																																				KeyValidation.PRCTMappings.SmallBusModelsKeySet,
																																				KeyValidation.PRCTMappings.SmallBusModelsParentSet,
																																				KeyValidation.PRCTMappings.SmallBusModelsIgnoredFields ,
																																				KeyValidation.PRCTMappings.SmallBusModelsUniqueField , isPROD);
																																				
	SmallBusFinancialExchangeSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.SmallBusFinancialExchangeKeyName,
																																				KeyValidation.PRCTMappings.SmallBusFinancialExchangeKeyType,
																																				KeyValidation.PRCTMappings.SmallBusFinancialExchangeParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_key_SBFEAttributes,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_SmallBusFinancialExchange,
																																				KeyValidation.PRCTMappings.SmallBusFinancialExchangeKeySet,
																																				KeyValidation.PRCTMappings.SmallBusFinancialExchangeParentSet,
																																				KeyValidation.PRCTMappings.SmallBusFinancialExchangeIgnoredFields ,
																																				KeyValidation.PRCTMappings.SmallBusFinancialExchangeUniqueField , isPROD);																																			
																																				
	OSSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.OSKeyName,
																																				KeyValidation.PRCTMappings.OSKeyType,
																																				KeyValidation.PRCTMappings.OSParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_OS,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_OS,
																																				KeyValidation.PRCTMappings.OSKeySet,
																																				KeyValidation.PRCTMappings.OSParentSet,
																																				KeyValidation.PRCTMappings.OSIgnoredFields ,
																																				KeyValidation.PRCTMappings.OSUniqueField , isPROD);
																															
	OSAttributesSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.OSAttributesKeyName,
																																				KeyValidation.PRCTMappings.OSAttributesKeyType,
																																				KeyValidation.PRCTMappings.OSAttributesParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_OSAttributes,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_OSAttributes,
																																				KeyValidation.PRCTMappings.OSAttributesKeySet,
																																				KeyValidation.PRCTMappings.OSAttributesParentSet,
																																				KeyValidation.PRCTMappings.OSAttributesIgnoredFields ,
																																				KeyValidation.PRCTMappings.OSAttributesUniqueField , isPROD);
																																				
	CBDSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.CBDKeyName,
																																				KeyValidation.PRCTMappings.CBDKeyType,
																																				KeyValidation.PRCTMappings.CBDParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_CBD,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_CBD,
																																				KeyValidation.PRCTMappings.CBDKeySet,
																																				KeyValidation.PRCTMappings.CBDParentSet,
																																				KeyValidation.PRCTMappings.CBDIgnoredFields ,
																																				KeyValidation.PRCTMappings.CBDUniqueField , isPROD);
																																			
	CBDAttributesSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.CBDAttributesKeyName,
																																				KeyValidation.PRCTMappings.CBDAttributesKeyType,
																																				KeyValidation.PRCTMappings.CBDAttributesParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_CBDAttributes,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_CBDAttributes,
																																				KeyValidation.PRCTMappings.CBDAttributesKeySet,
																																				KeyValidation.PRCTMappings.CBDAttributesParentSet,
																																				KeyValidation.PRCTMappings.CBDAttributesIgnoredFields ,
																																				KeyValidation.PRCTMappings.CBDAttributesUniqueField , isPROD);
																																				
	BS_ServicesSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.BS_ServicesKeyName,
																																				KeyValidation.PRCTMappings.BS_ServicesKeyType,
																																				KeyValidation.PRCTMappings.BS_ServicesParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_BS_Services,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_BS_Services,
																																				KeyValidation.PRCTMappings.BS_ServicesKeySet,
																																				KeyValidation.PRCTMappings.BS_ServicesParentSet,
																																				KeyValidation.PRCTMappings.BS_ServicesIgnoredFields ,
																																				KeyValidation.PRCTMappings.BS_ServicesUniqueField , isPROD);
																																				
			smallbusinessanalyticsSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.smallbusinessanalyticsKeyName,
																																				KeyValidation.PRCTMappings.smallbusinessanalyticsKeyType,
																																				KeyValidation.PRCTMappings.smallbusinessanalyticsParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_smallbusinessanalytics,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_smallbusinessanalytics,
																																				KeyValidation.PRCTMappings.smallbusinessanalyticsKeySet,
																																				KeyValidation.PRCTMappings.smallbusinessanalyticsParentSet,
																																				KeyValidation.PRCTMappings.smallbusinessanalyticsIgnoredFields ,
																																				KeyValidation.PRCTMappings.smallbusinessanalyticsUniqueField , isPROD);																																			
																																				
			AMLRiskAttributesBusnV2Summary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnV2KeyName,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnV2KeyType,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnV2ParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_AMLRiskAttributesBusnV2,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_AMLRiskAttributesBusnV2,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnV2KeySet,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnV2ParentSet,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnV2IgnoredFields ,
																																				KeyValidation.PRCTMappings.AMLRiskAttributesBusnV2UniqueField , isPROD);					
																																				
				ProfileBoosterSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.ProfileBoosterKeyName,
																																				KeyValidation.PRCTMappings.ProfileBoosterKeyType,
																																				KeyValidation.PRCTMappings.ProfileBoosterParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_ProfileBooster,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_ProfileBooster,
																																				KeyValidation.PRCTMappings.ProfileBoosterKeySet,
																																				KeyValidation.PRCTMappings.ProfileBoosterParentSet,
																																				KeyValidation.PRCTMappings.ProfileBoosterIgnoredFields ,
																																				KeyValidation.PRCTMappings.ProfileBoosterUniqueField , isPROD);				
	FOVInteractiveSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.FOVInteractiveKeyName,
																																				KeyValidation.PRCTMappings.FOVInteractiveKeyType,
																																				KeyValidation.PRCTMappings.FOVInteractiveParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_FOVInteractive,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_FOVInteractive,
																																				KeyValidation.PRCTMappings.FOVInteractiveKeySet,
																																				KeyValidation.PRCTMappings.FOVInteractiveParentSet,
																																				KeyValidation.PRCTMappings.FOVInteractiveIgnoredFields ,
																																				KeyValidation.PRCTMappings.FOVInteractiveUniqueField , isPROD);
																																
	FOVRenewalSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.FOVRenewalKeyName,
																																				KeyValidation.PRCTMappings.FOVRenewalKeyType,
																																				KeyValidation.PRCTMappings.FOVRenewalParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_FOVRenewal,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_FOVRenewal,
																																				KeyValidation.PRCTMappings.FOVRenewalKeySet,
																																				KeyValidation.PRCTMappings.FOVRenewalParentSet,
																																				KeyValidation.PRCTMappings.FOVRenewalIgnoredFields ,
																																				KeyValidation.PRCTMappings.FOVRenewalUniqueField , isPROD);
																																					
	frauddefenderSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.frauddefenderKeyName,
																																				KeyValidation.PRCTMappings.frauddefenderKeyType,
																																				KeyValidation.PRCTMappings.frauddefenderParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_frauddefender,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_frauddefender,
																																				KeyValidation.PRCTMappings.frauddefenderKeySet,
																																				KeyValidation.PRCTMappings.frauddefenderParentSet,
																																				KeyValidation.PRCTMappings.frauddefenderIgnoredFields ,
																																				KeyValidation.PRCTMappings.frauddefenderUniqueField , isPROD);
																																		
		HealthCareAttributesSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.HealthCareAttributesKeyName,
																																				KeyValidation.PRCTMappings.HealthCareAttributesKeyType,
																																				KeyValidation.PRCTMappings.HealthCareAttributesParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_HealthCareAttributes,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_HealthCareAttributes,
																																				KeyValidation.PRCTMappings.HealthCareAttributesKeySet,
																																				KeyValidation.PRCTMappings.HealthCareAttributesParentSet,
																																				KeyValidation.PRCTMappings.HealthCareAttributesIgnoredFields ,
																																				KeyValidation.PRCTMappings.HealthCareAttributesUniqueField , isPROD);
																																				
		Identifier2Summary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.Identifier2KeyName,
																																				KeyValidation.PRCTMappings.Identifier2KeyType,
																																				KeyValidation.PRCTMappings.Identifier2ParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_Identifier2,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_Identifier2,
																																				KeyValidation.PRCTMappings.Identifier2KeySet,
																																				KeyValidation.PRCTMappings.Identifier2ParentSet,
																																				KeyValidation.PRCTMappings.Identifier2IgnoredFields ,
																																				KeyValidation.PRCTMappings.Identifier2UniqueField , isPROD);

																																
																																		
	IntlIID_GG2Summary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.IntlIID_GG2KeyName,
																																				KeyValidation.PRCTMappings.IntlIID_GG2KeyType,
																																				KeyValidation.PRCTMappings.IntlIID_GG2ParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_IntlIID_GG2,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_IntlIID_GG2,
																																				KeyValidation.PRCTMappings.IntlIID_GG2KeySet,
																																				KeyValidation.PRCTMappings.IntlIID_GG2ParentSet,
																																				KeyValidation.PRCTMappings.IntlIID_GG2IgnoredFields ,
																																				KeyValidation.PRCTMappings.IntlIID_GG2UniqueField , isPROD);
					
																											
	LNSmallBusinessSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.LNSmallBusinessKeyName,
																																				KeyValidation.PRCTMappings.LNSmallBusinessKeyType,
																																				KeyValidation.PRCTMappings.LNSmallBusinessParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_LNSmallBusiness,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_LNSmallBusiness,
																																				KeyValidation.PRCTMappings.LNSmallBusinessKeySet,
																																				KeyValidation.PRCTMappings.LNSmallBusinessParentSet,
																																				KeyValidation.PRCTMappings.LNSmallBusinessIgnoredFields ,
																																				KeyValidation.PRCTMappings.LNSmallBusinessUniqueField , isPROD);
																																				
	VerificationOfOccupancySummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.VerificationOfOccupancyKeyName,
																																				KeyValidation.PRCTMappings.VerificationOfOccupancyKeyType,
																																				KeyValidation.PRCTMappings.VerificationOfOccupancyParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_VerificationOfOccupancy,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_VerificationOfOccupancy,
																																				KeyValidation.PRCTMappings.VerificationOfOccupancyKeySet,
																																				KeyValidation.PRCTMappings.VerificationOfOccupancyParentSet,
																																				KeyValidation.PRCTMappings.VerificationOfOccupancyIgnoredFields ,
																																				KeyValidation.PRCTMappings.VerificationOfOccupancyUniqueField , isPROD);
																																				
																																																																					
	BIIDV2_1Summary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.BIIDV2_1KeyName,
																																				KeyValidation.PRCTMappings.BIIDV2_1KeyType,
																																				KeyValidation.PRCTMappings.BIIDV2_1ParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_keyPRCT_BIID20keypart1,
																																				KeyValidation.PRCT_PROD_KeyFiles.key_BIID20keypart1,
																																				KeyValidation.PRCTMappings.BIIDV2_1KeySet,
																																				KeyValidation.PRCTMappings.BIIDV2_1ParentSet,
																																				KeyValidation.PRCTMappings.BIIDV2_1IgnoredFields ,
																																				KeyValidation.PRCTMappings.BIIDV2_1UniqueField , isPROD);		
																																				
	BIIDV2_2Summary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.BIIDV2_2KeyName,
																																				KeyValidation.PRCTMappings.BIIDV2_2KeyType,
																																				KeyValidation.PRCTMappings.BIIDV2_2ParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_keyPRCT_BIID20keypart2,
																																				KeyValidation.PRCT_PROD_KeyFiles.key_BIID20keypart2,
																																				KeyValidation.PRCTMappings.BIIDV2_2KeySet,
																																				KeyValidation.PRCTMappings.BIIDV2_2ParentSet,
																																				KeyValidation.PRCTMappings.BIIDV2_2IgnoredFields ,
																																				KeyValidation.PRCTMappings.BIIDV2_2UniqueField , isPROD);
																																				
	BIIDV2_3Summary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.BIIDV2_3KeyName,
																																				KeyValidation.PRCTMappings.BIIDV2_3KeyType,
																																				KeyValidation.PRCTMappings.BIIDV2_3ParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_keyPRCT_BIID20keypart3,
																																				KeyValidation.PRCT_PROD_KeyFiles.key_BIID20keypart3,
																																				KeyValidation.PRCTMappings.BIIDV2_3KeySet,
																																				KeyValidation.PRCTMappings.BIIDV2_3ParentSet,
																																				KeyValidation.PRCTMappings.BIIDV2_3IgnoredFields ,
																																				KeyValidation.PRCTMappings.BIIDV2_3UniqueField , isPROD);																																						
																																																																										
 		 PRCTSummary := instantidSummary  +BInstantIDSummary + FlexIDSummary +LeadIntegrityAttributesSummary 
																			+smallbusinessanalyticsSummary + AMLRiskAttributesBusnV2Summary + ProfileBoosterSummary + AMLRiskAttributesV2Summary + 	 AMLRiskAttributesSummary + businessdefenderSummary + AMLRiskAttributesBusnSummary + redflagsSummary + SmallBusModelsSummary +SmallBusFinancialExchangeSummary +
																			OSSummary		+ OSAttributesSummary +		CBDSummary + 	CBDAttributesSummary +	BS_ServicesSummary +
																			FOVInteractiveSummary	 + FOVRenewalSummary	+ frauddefenderSummary	+ HealthCareAttributesSummary +	Identifier2Summary+
																			IntlIID_GG2Summary + LNSmallBusinessSummary +	VerificationOfOccupancySummary + BIIDV2_1Summary + BIIDV2_2Summary + BIIDV2_3Summary;																							


  return PRCTSummary;																																				
endmacro;