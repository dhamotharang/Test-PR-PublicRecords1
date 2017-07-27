// This service created to add Web Service fields for Address.AddressCleaningService

EXPORT MAC_Addr_AddressCleaningService := MACRO

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
										'AddressLine1',
                    'AddressLine2',
                    'City',
                    'State',
                    'Zip'
									));
ENDMACRO;	