// This service created to add Web Service fields for BankruptcyV2_Services.FocusSearchService

EXPORT MAC_BankruptcyV2_Services_FocusSearchService := MACRO

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
										'FocusSearch',
										'FocusDocIDs',
										'MaxResults',
										'MaxResultsThisTime',
										'SkipRecords',
										'ReturnHashes',
										'Srch_Hashvals'
									));
ENDMACRO;	