// This service created to add Web Service fields for BankruptcyV3_Services.BankruptcySearchService

EXPORT MAC_BankruptcyV3_Services_BankruptcySearchService := MACRO

     #WEBSERVICE(FIELDS(
                        /*---- Compliance Fields ----*/			                    
												'ApplicationType',
												'DataPermissionMask',
												'DataRestrictionMask',
												'DLMask',
												'DOBMask',
												'DPPAPurpose',
												'GLBPurpose',
												'IndustryClass',
												'SSNMask',  
												/*---- ID's	----*/
                        'DID',
												'SSN',
												'BDID',
												'FEIN',
												'TMSID',
												'CaseNumber',
												/*---- Person Name Fields ----*/
												'UnParsedFullName',
												'FirstName',
												'MiddleName',
												'LastName',
												'AllowNicknames',
												/*---- Person Address Fields ----*/
												'Addr',
												'City',
												'State',
												'Zip',
												'County',
												'ZipRadius',
												/*---- Company Identifying fields ----*/
												'CompanyName',
												/*---- Misc Input Options	----*/
												'FilingJurisdiction',
												'NoDeepDive',
												'PartyType',
												'PenaltThreshold',
												'PhoneticMatch',
												'ReturnHashes',
												'Srch_Hashvals',
												'StrictMatch',
												/*----  Pagination Fields ----*/
												'MaxResults',
												'MaxResultsThisTime',
												'SkipRecords'
											 ));

ENDMACRO;