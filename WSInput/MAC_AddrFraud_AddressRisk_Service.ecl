// This service created to add Web Service fields for AddrFraud.AddressRisk_Service

EXPORT MAC_AddrFraud_AddressRisk_Service := MACRO

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
										'AddrRiskSearchRequest'
									));
ENDMACRO;	