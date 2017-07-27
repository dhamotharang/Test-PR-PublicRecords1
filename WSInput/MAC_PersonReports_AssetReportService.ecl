EXPORT MAC_PersonReports_AssetReportService := MACRO
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
										'ExactSecondRangeMatch',
										'ExcludeDMVPII',
										'LnBranded',
										'PhoneticMatch',
										'RelativeDepth',
										'ReturnAlsoFound',
										/*---- Boolean Include Options	----*/
										'IncludeAssociates',
										'IncludeCriminalIndicators',
										'IncludeDriversLicenses',
										'IncludePeopleAtWork',
										'IncludePhonesPlus',
										'IncludeProfessionalLicenses',
										'IncludeRelatives',
										/*----  Pagination Fields ----*/
										'MaxResults',
										'MaxResultsThisTime',
										'SkipRecords',
										/*----  iesp form ----*/
										'AssetReportRequest'
								));
ENDMACRO;