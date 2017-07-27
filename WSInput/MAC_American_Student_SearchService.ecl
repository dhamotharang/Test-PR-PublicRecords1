// This service created to add Web Service fields for American_Student_Services.SearchService

EXPORT MAC_American_Student_SearchService := MACRO

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
										'DatasourceExclusion',
										'StudentSearchRequest'
									));
ENDMACRO;	