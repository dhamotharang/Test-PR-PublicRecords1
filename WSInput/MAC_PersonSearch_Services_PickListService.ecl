EXPORT MAC_PersonSearch_Services_PickListService := MACRO
		#WEBSERVICE(FIELDS(	
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
											/*---- Other search fields ----*/
											'DID',
											'RID',
											'SSN',
											'UnParsedFullName',
											'FirstName',
											'MiddleName',
											'LastName',
											'Addr',
											'City',
											'FuzzySecRange',
											'State',
											'Zip',
											'ZipRadius',
											'DOB',
											'Phone',
											/*---- Misc Input Options	----*/
											'AddressLimit',
											'AllowHeaderQuick',
											'AllowNickNames',
											'AllowWildcard',
											'BestOnly',
											'CurrentOnly',
											'CurrentResidentsOnly',
											'DIDOnly',
											'DistanceThreshold',								
											'DLNumber',
											'DLState',
											'DoNotFillBlanks',
											'ExcludeDMVPII',
											'GroupByDID',
											'Household',
											'KeepOldSsns',
											'LookupType',
											'NoLookupSearch',
											'NonExclusion',
											'PhoneticDistanceMatch',
											'PhoneticMatch',
											'ReducedData',
											'ReturnCount',
											'ScoreThreshold',
											'SkipFCRA_RI',
											'SSNTypos',
											'StrictMatch',
											/*---- Boolean Include Options	----*/
											'IncludeAllDIDRecords',
											/*----  Pagination Fields ----*/
											'StartingRecord',
											'MaxResults',
											'MaxResultsThisTime',
											'SkipRecords',
											/*----  iesp form ----*/
											'PersonPickListRequest'
		));
ENDMACRO;