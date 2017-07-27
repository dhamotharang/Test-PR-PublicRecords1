EXPORT MAC_PersonReports_SmartLinxReportService := MACRO
#WEBSERVICE (FIELDS(	
									/*---- Compliance Fields .----*/
									'ApplicationType',
									'DataPermissionMask',
									'DataRestrictionMask',
									'DLMask',
									'dobMask',
									'DPPAPurpose',
									'GLBPurpose',
									'IndustryClass',
									'ssnMask',
									/*----  Pagination Fields ----*/
									'MaxResults',
									'MaxResultsThisTime',
									'SkipRecords',
									/*----  iesp form ----*/
									'SmartLinxReportRequest'
						));
ENDMACRO;