// This service created to add Web Service fields for AddressReport_Services.AddressSummaryService

EXPORT MAC_AddrReport_AddressSummaryService := MACRO

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
										'DID',
										'SSN',
										'UnParsedFullName',
										'Addr',
                    'City',
                    'State',
                    'Zip',
										'DOB',
										'PHONE',
										'AddressSummaryRequest'
									));
ENDMACRO;	
