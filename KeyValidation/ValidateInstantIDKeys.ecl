/* Author: V Arani
Validating InstantID keys using validateKeysMacrov2 function
*/


Import InstantID_Archiving,KeyValidation,doxie, Data_Services,ut, ADVFiles,Autokey;

//Function Macro that validates all InstantID Keys. BuildVersion and isDev should be provided as input
EXPORT ValidateInstantIDKeys(buildVersion, isDev) := FunctionMacro

	DatasetName := 'InstantID';	
	
	//Summary report for report key validation		
	payloadReportFileInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.ReportParentName,KeyValidation.IIDMappings.ReportKeyType,
																																				 KeyValidation.IIDMappings.ReportKeyName,buildVersion,
																																			   KeyValidation.IIDParentFiles.parentFileKeyReport, KeyValidation.IIDKeyFiles.keyFileReport,
																																				 KeyValidation.IIDMappings.ReportKeySet,KeyValidation.IIDMappings.ReportParentSet,
																																				 KeyValidation.IIDMappings.ReportIgnoredFields,KeyValidation.IIDMappings.ReportUniqueField, isDev); 
	//Summary report for report1 key validation																																				
	payloadReportFileInstantIDSummary1 := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.Report1ParentName,KeyValidation.IIDMappings.Report1KeyType,
																																				 KeyValidation.IIDMappings.Report1KeyName,buildVersion,
																																			   KeyValidation.IIDParentFiles.parentFileKeyReport1, KeyValidation.IIDKeyFiles.keyFileReport1,
																																				 KeyValidation.IIDMappings.Report1KeySet,KeyValidation.IIDMappings.Report1ParentSet,
																																				 KeyValidation.IIDMappings.Report1IgnoredFields,KeyValidation.IIDMappings.Report1UniqueField, isDev);																													
	//Summary report for report2 key validation																																				
	payloadReportFileInstantIDSummary2 := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.Report2ParentName,KeyValidation.IIDMappings.Report2KeyType,
																																				 KeyValidation.IIDMappings.Report2KeyName,buildVersion,
																																			   KeyValidation.IIDParentFiles.parentFileKeyReport2, KeyValidation.IIDKeyFiles.keyFileReport2,
																																				 KeyValidation.IIDMappings.Report2KeySet,KeyValidation.IIDMappings.Report2ParentSet,
																																				 KeyValidation.IIDMappings.Report2IgnoredFields,KeyValidation.IIDMappings.Report2UniqueField, isDev);																														
		//Summary report for report3 key validation																																			
	payloadReportFileInstantIDSummary3 := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.Report3ParentName,KeyValidation.IIDMappings.Report3KeyType,
																																				 KeyValidation.IIDMappings.Report3KeyName,buildVersion,
																																			   KeyValidation.IIDParentFiles.parentFileKeyReport3, KeyValidation.IIDKeyFiles.keyFileReport3,
																																				 KeyValidation.IIDMappings.Report3KeySet,KeyValidation.IIDMappings.Report3ParentSet,
																																				 KeyValidation.IIDMappings.Report3IgnoredFields,KeyValidation.IIDMappings.Report3UniqueField, isDev);
		//Summary report for report4 key validation																																			
	payloadReportFileInstantIDSummary4 := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.Report4ParentName,KeyValidation.IIDMappings.Report4KeyType,
																																				 KeyValidation.IIDMappings.Report4KeyName,buildVersion,
																																			   KeyValidation.IIDParentFiles.parentFileKeyReport4, KeyValidation.IIDKeyFiles.keyFileReport4,
																																				 KeyValidation.IIDMappings.Report4KeySet,KeyValidation.IIDMappings.Report4ParentSet,
																																				 KeyValidation.IIDMappings.Report4IgnoredFields,KeyValidation.IIDMappings.Report4UniqueField, isDev);																														
			//Summary report for report5 key validation																																		
	payloadReportFileInstantIDSummary5 := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.Report5ParentName,KeyValidation.IIDMappings.Report5KeyType,
																																				 KeyValidation.IIDMappings.Report5KeyName,buildVersion,
																																			   KeyValidation.IIDParentFiles.parentFileKeyReport5, KeyValidation.IIDKeyFiles.keyFileReport5,
																																				 KeyValidation.IIDMappings.Report5KeySet,KeyValidation.IIDMappings.Report5ParentSet,
																																				 KeyValidation.IIDMappings.Report5IgnoredFields,KeyValidation.IIDMappings.Report5UniqueField, isDev);
		//Summary report for report6 key validation																																			
	payloadReportFileInstantIDSummary6 := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.Report6ParentName,KeyValidation.IIDMappings.Report6KeyType,
																																				 KeyValidation.IIDMappings.Report6KeyName,buildVersion,
																																			   KeyValidation.IIDParentFiles.parentFileKeyReport6, KeyValidation.IIDKeyFiles.keyFileReport6,
																																				 KeyValidation.IIDMappings.Report6KeySet,KeyValidation.IIDMappings.Report6ParentSet,
																																				 KeyValidation.IIDMappings.Report6IgnoredFields,KeyValidation.IIDMappings.Report6UniqueField, isDev);
			
	
 //Summary report for verification key validation	
  payloadVerificationInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.VerificationKeyName,KeyValidation.IIDMappings.VerificationKeyType,
																																					 KeyValidation.IIDMappings.VerificationParentName, buildVersion,
																																			     KeyValidation.IIDParentFiles.parentFileKeyVerification,KeyValidation.IIDKeyFiles.keyFileVerification,
																																					 KeyValidation.IIDMappings.VerificationKeySet,KeyValidation.IIDMappings.VerificationParentSet,
																																					 KeyValidation.IIDMappings.VerificationIgnoredFields,KeyValidation.IIDMappings.VerificationUniqueField,
																																				   isDev); 
  //Summary report for risk key validation	
	payloadRiskInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.RiskKeyName,KeyValidation.IIDMappings.RiskKeyType,KeyValidation.IIDMappings.RiskParentName,
																																		buildVersion, KeyValidation.IIDParentFiles.parentFileKeyRisk,KeyValidation.IIDKeyFiles.keyFileRisk,
																																		KeyValidation.IIDMappings.RiskKeySet,KeyValidation.IIDMappings.RiskParentSet,
																																		KeyValidation.IIDMappings.RiskIgnoredFields,KeyValidation.IIDMappings.RiskUniqueField, isDev); 
																																																								
	
	//Summary report for model key validation	
	payloadModelInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.ModelKeyName,KeyValidation.IIDMappings.ModelKeyType,
																																	  KeyValidation.IIDMappings.ModelParentName,buildVersion, KeyValidation.IIDParentFiles.parentFileKeyModel,
																																		KeyValidation.IIDKeyFiles.keyFileModel,KeyValidation.IIDMappings.ModelKeySet,
																																		KeyValidation.IIDMappings.ModelParentSet,KeyValidation.IIDMappings.ModelIgnoredFields,
																																		KeyValidation.IIDMappings.ModelUniqueField, isDev); 
																																																									
	//Summary reports for ModelRisk key validation
	payloadModelRiskInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.ModelRiskKeyName,KeyValidation.IIDMappings.ModelRiskKeyType,
																																				KeyValidation.IIDMappings.ModelRiskParentName,buildVersion,
																																				KeyValidation.IIDParentFiles.parentFileKeyModelRisk,KeyValidation.IIDKeyFiles.keyFileModelRisk,
																																				KeyValidation.IIDMappings.ModelRiskKeySet,KeyValidation.IIDMappings.ModelRiskParentSet,
																																				KeyValidation.IIDMappings.ModelRiskIgnoredFields,KeyValidation.IIDMappings.ModelRiskUniqueField, isDev); 

	//Summary reports for DateAdded key validation
	payloadDateAddedInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.DateAddedKeyName,KeyValidation.IIDMappings.DateAddedKeyType,
																																				KeyValidation.IIDMappings.DateAddedParentName,buildVersion, 
																																				KeyValidation.IIDParentFiles.parentFileKey_DateAdded,KeyValidation.IIDKeyFiles.keyFileDateAdded,
																																				KeyValidation.IIDMappings.DateAddedKeySet,KeyValidation.IIDMappings.DateAddedParentSet,
																																				KeyValidation.IIDMappings.DateAddedIgnoredFields,
																																			  KeyValidation.IIDMappings.DateAddedUniqueField, isDev); 


	//Summary reports for RiskIndex key validation
	payloadModelIndexInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.RiskIndexKeyName,KeyValidation.IIDMappings.RiskIndexKeyType,
																																				 KeyValidation.IIDMappings.RiskIndexParentName,buildVersion,
																																			   KeyValidation.IIDParentFiles.parentFileKey_ModelIndex,KeyValidation.IIDKeyFiles.keyFile_ModelIndex,
																																				 KeyValidation.IIDMappings.RiskIndexKeySet,KeyValidation.IIDMappings.RiskIndexParentSet,
																																				 KeyValidation.IIDMappings.RiskIndexIgnoredFields,
																																			   KeyValidation.IIDMappings.RiskIndexUniqueField, isDev); 
								

	//Summary reports for RedFlags key validation
	payloadRedFlagsInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.RedflagsKeyName,KeyValidation.IIDMappings.RedflagsKeyType,
																																	     KeyValidation.IIDMappings.RedflagsParentName,buildVersion,
																																			 KeyValidation.IIDParentFiles.parentFileKey_RedFlags,KeyValidation.IIDKeyFiles.keyFile_RedFlags,
																																			 KeyValidation.IIDMappings.RedflagsKeySet,KeyValidation.IIDMappings.RedflagsParentSet,
																																			 KeyValidation.IIDMappings.RedflagsIgnoredFields,
																																			 KeyValidation.IIDMappings.RedflagsUniqueField, isDev); 

	//Summary reports for Payload key validation
	payloadPayloadInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.PayloadKeyName,KeyValidation.IIDMappings.PayloadKeyType,
																																		  KeyValidation.IIDMappings.PayloadParentName,buildVersion,
																																		  KeyValidation.IIDParentFiles.parentKeyFile_Payload,KeyValidation.IIDKeyFiles.keyFile_Payload,
																																			KeyValidation.IIDMappings.PayloadKeySet,KeyValidation.IIDMappings.PayloadParentSet,
																																			KeyValidation.IIDMappings.PayloadIgnoredFields,KeyValidation.IIDMappings.PayloadUniqueField, isDev); 

 
	//Summary reports for AutoKeyPayload key validation
	payloadAutoKeyPayloadInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.PayloadAKKeyName,KeyValidation.IIDMappings.PayloadAKKeyType,
																																						 KeyValidation.IIDMappings.PayloadAKParentName, buildVersion, 
																																						 KeyValidation.IIDParentFiles.parentKeyFile_AutoKeyPayload,
																																						 KeyValidation.IIDKeyFiles.keyFile_AutoKeyPayload,KeyValidation.IIDMappings.PayloadAKKeySet,
																																						 KeyValidation.IIDMappings.PayloadAKParentSet,KeyValidation.IIDMappings.PayloadAKIgnoredFields,
																																			       KeyValidation.IIDMappings.PayloadAKUniqueField, isDev); 
 //Summary reports for AutoKeyAddress key validation
	AutoKeyAdressInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.AddressAKKeyName,KeyValidation.IIDMappings.AddressAKKeyType,
																																		 KeyValidation.IIDMappings.AddressAKParentName,buildVersion,
																																		 KeyValidation.IIDParentFiles.keyFile_AutoKeyPayload,KeyValidation.IIDKeyFiles.keyFile_AutoKeyAddress,
																                                     KeyValidation.IIDMappings.AddressAKKeySet,
																                                     KeyValidation.IIDMappings.AddressAKParentSet,KeyValidation.IIDMappings.AddressAKIgnoredFields,
																																		 KeyValidation.IIDMappings.AddressAKUniqueField, isDev); 


 //Summary reports for AutoKeyCityStName key validation
	AutoKeycitystnameInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.CityStNameAKKeyName,
																																				 KeyValidation.IIDMappings.CityStNameAKKeyType,KeyValidation.IIDMappings.CityStNameAKParentName,
																																				 buildVersion, KeyValidation.IIDParentFiles.keyFile_AutoKeyPayload,
																																				 KeyValidation.IIDKeyFiles.keyFile_AutoKeycitystname,KeyValidation.IIDMappings.CityStNameAKKeySet,
																																				 KeyValidation.IIDMappings.CityStNameAKParentSet,KeyValidation.IIDMappings.CityStNameAKIgnoredFields,
																																				 KeyValidation.IIDMappings.CityStNameAKUniqueField, isDev); 
	
 //Summary reports for AutokeyName key validation
	AutoKeynameInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.NameAKKeyName,KeyValidation.IIDMappings.NameAKKeyType,
																																	 KeyValidation.IIDMappings.NameAKParentName,buildVersion, KeyValidation.IIDParentFiles.keyFile_AutoKeyPayload,
																																	 KeyValidation.IIDKeyFiles.keyFile_AutoKeyname,KeyValidation.IIDMappings.NameAKKeySet,
																																	 KeyValidation.IIDMappings.NameAKParentSet,KeyValidation.IIDMappings.NameAKIgnoredFields,
																																	 KeyValidation.IIDMappings.NameAKUniqueField, isDev); 
																
								
 //Summary reports for AutokeySSN2 key validation	
	AutoKeySSn2InstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.SSN2AKKeyName,KeyValidation.IIDMappings.SSN2AKKeyType,
																																	 KeyValidation.IIDMappings.SSN2AKParentName,buildVersion, KeyValidation.IIDParentFiles.keyFile_AutoKeyPayload,
																																	 KeyValidation.IIDKeyFiles.keyFile_AutoKeySSN2, KeyValidation.IIDMappings.SSN2AKKeySet,
																																	 KeyValidation.IIDMappings.SSN2AKParentSet,KeyValidation.IIDMappings.SSN2AKIgnoredFields,
																																	 KeyValidation.IIDMappings.SSN2AKUniqueField, isDev); 

 //Summary reports for AutokeyStName key validation										
	AutoKeyStNameInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.StNameAKKeyName,KeyValidation.IIDMappings.StNameAKKeyType,
	                                                                   KeyValidation.IIDMappings.StNameAKParentName,buildVersion, 
																																		 KeyValidation.IIDParentFiles.keyFile_AutoKeyPayload, KeyValidation.IIDKeyFiles.keyFile_AutoKeyStName,
																																		 KeyValidation.IIDMappings.StNameAKKeySet, KeyValidation.IIDMappings.StNameAKParentSet,
																																		 KeyValidation.IIDMappings.StNameAKIgnoredFields, KeyValidation.IIDMappings.StNameAKUniqueField, isDev);		
 //Summary reports for AutokeyZip key validation
	AutoKeyZipInstantIDSummary := KeyValidation.validateKeysMacrov2(DatasetName,KeyValidation.IIDMappings.ZipAKKeyName,KeyValidation.IIDMappings.ZipAKKeyType,
																																	KeyValidation.IIDMappings.ZipAKParentName,buildVersion,KeyValidation.IIDParentFiles.keyFile_AutoKeyPayload,
																																	KeyValidation.IIDKeyFiles.keyFile_AutoKeyZip, KeyValidation.IIDMappings.ZipAKKeySet,
																																	KeyValidation.IIDMappings.ZipAKParentSet, KeyValidation.IIDMappings.ZipAKIgnoredFields, 
																					                        KeyValidation.IIDMappings.ZipAKUniqueField, isDev);																							 
																					 
	//consolidated summary report containing information related to all InstantID keys																					 
	return payloadReportFileInstantIDSummary+payloadReportFileInstantIDSummary1+payloadReportFileInstantIDSummary2+payloadReportFileInstantIDSummary3+
	       payloadReportFileInstantIDSummary4+payloadReportFileInstantIDSummary5 + payloadReportFileInstantIDSummary6 + payloadVerificationInstantIDSummary + 
				 payloadRiskInstantIDSummary + payloadModelInstantIDSummary + payloadModelRiskInstantIDSummary + payloadDateAddedInstantIDSummary + 
				 payloadModelIndexInstantIDSummary + payloadRedFlagsInstantIDSummary + payloadPayloadInstantIDSummary + payloadAutoKeyPayloadInstantIDSummary + 
	       AutoKeyAdressInstantIDSummary + AutoKeycitystnameInstantIDSummary + AutoKeynameInstantIDSummary+
	       AutoKeySSn2InstantIDSummary + AutoKeyStNameInstantIDSummary + AutoKeyZipInstantIDSummary; 

EndMacro;


