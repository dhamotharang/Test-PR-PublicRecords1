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
									'ResellerType',
									/*----  Pagination Fields ----*/
									'MaxResults',
									'MaxResultsThisTime',
									'SkipRecords',
                  /*---- versioning ----*/
                  'EmailVersion',  //-internal field, expected to be set by ESP
									/*---- Gateways ----*/
									'Gateways',
									/*----  iesp form ----*/
									'SmartLinxReportRequest'
						));
ENDMACRO;
