// This service created to add Web Service fields for Accident_Services.StateRestrictionsReportService

EXPORT MAC_Accident_Services_StateRestrictionsReportService := MACRO

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
										'AccidentStateRestrictionReportRequest'
									));
ENDMACRO;	