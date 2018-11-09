// This service created to add Web Service fields for BankruptcyV3_Services.BankruptcySearchServiceFCRA

EXPORT MAC_BankruptcyV3_Services_BankruptcySearchServiceFCRA := MACRO

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
												'SSNLast4',
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
												'CaseSort',
												'CompanyNameSort',
												'FileDateSort',
												'LastNameSort',
												'StateSort',
												'FilingJurisdiction',
												'NoDeepDive',
												'PartyType',
												'PenaltThreshold',
												'PhoneticMatch',
												'ReturnHashes',
												'Srch_Hashvals',
												'StrictMatch',
												'NonSubjectSuppression',
												'ApplyNonsubjectRestrictions',
												'SuppressWithdrawnBankruptcy',
												'FFDOptionsMask',
                        'EnableCaseNumberFilterSearch',
												/*----  Pagination Fields ----*/
												'MaxResults',
												'MaxResultsThisTime',
												'SkipRecords',
												/*---- Gateways, if applicable ----*/
											  'Gateways'
											 ));

ENDMACRO;