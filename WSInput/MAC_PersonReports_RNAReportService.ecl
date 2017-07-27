EXPORT MAC_PersonReports_RNAReportService := MACRO
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
										'AddressesWithoutPhones',
										'ExcludeDMVPII',
										'NeighborsProximityRadius',
										'PhoneticMatch',
										'UnverifiedAddresses',
										/*---- Boolean Include Options	----*/
										'IncludeAssociates',
										'IncludeCriminalIndicators',
										'IncludeNeighbors',
										'IncludeRelativeAddresses',
										'IncludeRelatives',
										/*----  Pagination Fields ----*/
										'MaxResults',
										'MaxResultsThisTime',
										'SkipRecords',
										/*----  iesp form ----*/
										'RNAReportRequest'
								));
ENDMACRO;