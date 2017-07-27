// This service created to add Web Service fields for AutoHeaderV2.LexIDSearchService

EXPORT MAC_AutoHeaderV2_LexIDSearchService := MACRO

     #WEBSERVICE(FIELDS(
                        /*---- Compliance Fields ----*/			                    
												'ApplicationType',
												'DataPermissionMask',
												'DataRestrictionMask',
												'DLMask',
												'DOBMask',
												'DPPAPurpose',
												'GLBPurpose',
												'IndustryClass',
												'SSNMask',  
												/*---- Other Fields .----*/
												'SearchCode',
												/*---- ESDL Request Field ----*/
												'LexIDSearchRequest'
											 ));

ENDMACRO;