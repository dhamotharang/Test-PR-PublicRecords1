// This service created to add Web Service fields for BankruptcyV2_Services.BankruptcySearchService

EXPORT MAC_BankruptcyV2_Services_SearchService := MACRO

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
										'BDID',
										'TMSID',
										'SSN',
                    'FEIN',
										'CaseNumber',
										'UnParsedFullName',
										'FirstName',
										'MiddleName',
										'LastName',
										'AllowNicknames',
										'Addr',
										'City',
										'State',
										'Zip',
										'County',
										'ZipRadius',
										'PartyType',
                    'CompanyName',
										'FilingJurisdiction',
										'MaxResults',
										'MaxResultsThisTime',
										'SkipRecords',
										'ReturnHashes',
										'Srch_Hashvals',
										'PhoneticMatch',
                    'StrictMatch',
										'NoDeepDive',
                    'PenaltThreshold',
										'IncludeCriminalIndicators',
										'ChapterChoice',
										'BusinessOnly'
									));
ENDMACRO;	