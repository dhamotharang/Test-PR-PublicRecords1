// This service created to add Web Service fields for BusinessCredit_Services.BusinessAuthRepSearchService

EXPORT MAC_BusinessCredit_Services_BusinessAuthRepSearchService := MACRO

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
										'BusinessAuthRepSearchRequest'
									));
ENDMACRO;	