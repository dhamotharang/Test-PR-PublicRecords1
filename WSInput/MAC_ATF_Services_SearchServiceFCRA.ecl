// This service created to add Web Service fields for ATF_Services.SearchServiceFCRA


EXPORT MAC_ATF_Services_SearchServiceFCRA := MACRO

     #WEBSERVICE(FIELDS(
                        /*---- Compliance Fields ----*/			                    
												'ApplicationType',
												'DataPermissionMask',
												'DataRestrictionMask',
												'DLMask',
												'DOBMask',
												'DPPAPurpose',
										  'FCRAPurpose',
												'GLBPurpose',
												'IndustryClass',
												'SSNMask',  
												/*---- Other Fields ----*/
												'DID',
												'NonSubjectSuppression',
												'Gateways',
												'FFDOptionsMask',
												/*---- Gateways, if applicable ----*/
											  'Gateways',
												/*---- ESDL Request Field ----*/
												'FcraFirearmSearchRequest'
											 ));

ENDMACRO;