EXPORT MAC_PersonReports_PrelitReportService := MACRO
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
										'SSNMask',
										/*---- Other search fields ----*/
										'DID',
										'SSN',
										'UnparsedFullName',
										'FirstName',
										'MiddleName',
										'LastName',
										'AllowNickNames',
										'Addr',
										'City',
										'State',
										'Zip',
										'DOB',
										'Phone',
										/*---- Misc Input Options	----*/
										'ExcludeDMVPII',
										'LnBranded',
										'PhoneticMatch',
										'ReturnAlsoFound',
										'SelectIndividually',
										/*---- Boolean Include Options	----*/
										'IncludeAssociates',
										'IncludeCriminalIndicators',
										'IncludeDriversLicenses',
										'IncludePhonesPlus',
										'IncludeRelatives',
										/*----  Pagination Fields ----*/
										'MaxResults',
										'MaxResultsThisTime',
										'SkipRecords',
										/*----  iesp form ----*/
										'PreLitigationReportRequest'
								));

ENDMACRO;