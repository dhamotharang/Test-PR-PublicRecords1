// This service created to add Web Service fields for ATF_Services.SearchService

EXPORT MAC_ATF_Services_SearchService := MACRO

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
												/*---- Other Fields ----*/
                        'ATFLicenseNumber',												
												'DID',
												'IncludeCriminalIndicators',
												'NoDeepDive',
											  'PenaltThreshold',
												'StrictMatch',
												'TradeName',
												/*---- ESDL Request Field ----*/
												'FirearmSearchRequest'
											 ));

ENDMACRO;