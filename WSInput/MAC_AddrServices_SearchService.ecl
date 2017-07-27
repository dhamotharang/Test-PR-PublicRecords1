// This service created to add Web Service fields for Address_Services.SearchService

EXPORT MAC_AddrServices_SearchService := MACRO

  #WEBSERVICE(FIELDS(	
										/*---- Compliance Fields ----*/
										'ApplicationType',
										'DataPermissionMask',
										'DataRestrictionMask',
										'DLMask',
										'dobMask',
										'DPPAPurpose',
										'GLBPurpose',
										'IndustryClass',
										'ssnMask',
										/*---- Other Fields ----*/
										'Addr',
                    'City',
                    'State',
                    'Zip',
										'AddressSearchRequest'
									));
ENDMACRO;	