EXPORT Validate_PROD_PRCTFraud(buildVersion, isDev=false ) := functionmacro
  
Import KeyValidation,  Data_Services, ut, doxie, ut,Seed_Files,lib_stringlib;
DatasetName := 'FraudpointseedKeys';	

// Key instantid
	FraudpointSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																													KeyValidation.PRCTMappings.FraudPointKeyName,
																													KeyValidation.PRCTMappings.FraudPointKeyType,
																													KeyValidation.PRCTMappings.FraudPointParentName,
																													buildVersion,
																													KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_FraudPoint,
																													KeyValidation.PRCT_PROD_KeyFiles.Key_FraudPoint,
																													KeyValidation.PRCTMappings.FraudPointKeySet,
																													KeyValidation.PRCTMappings.FraudPointParentSet,
																													KeyValidation.PRCTMappings.FraudPointIgnoredFields ,
																													KeyValidation.PRCTMappings.FraudPointUniqueField , 
																													isdev);		
																																				

 FDAttributesSummary := KeyValidation.validateKeysMacrov2(DatasetName,
																																				KeyValidation.PRCTMappings.FDAttributesKeyName,
																																				KeyValidation.PRCTMappings.FDAttributesKeyType,
																																				KeyValidation.PRCTMappings.FDAttributesParentName,
																																				buildVersion,
																																			  KeyValidation.PRCT_PROD_ParentFiles.ParentFile_KeyPRCT_FDAttributes,
																																				KeyValidation.PRCT_PROD_KeyFiles.Key_FDAttributes,
																																				KeyValidation.PRCTMappings.FDAttributesKeySet,
																																				KeyValidation.PRCTMappings.FDAttributesParentSet,
																																				KeyValidation.PRCTMappings.FDAttributesIgnoredFields ,
																																				KeyValidation.PRCTMappings.FDAttributesUniqueField , isdev);
																																				
 		 PRCTSummary := FraudpointSummary  + FDAttributesSummary;
										
  return PRCTSummary;																																				
endmacro;