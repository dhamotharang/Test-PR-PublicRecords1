// This service created to add Web Service fields for AddressReport_Services.CountService

EXPORT MAC_AddrReport_CountService := MACRO

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
										'Addr',
                    'City',
                    'State',
                    'Zip',
										'AddressCountReportRequest'
									));
ENDMACRO;	
