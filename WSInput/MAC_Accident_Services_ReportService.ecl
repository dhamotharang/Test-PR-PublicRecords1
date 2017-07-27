// This service created to add Web Service fields for Accident_Services.ReportService

EXPORT MAC_Accident_Services_ReportService := MACRO

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
                    'AccidentReportRequest'
									));
ENDMACRO;									