// This service created to add Web Service fields for BankruptcyV2_Services.TextSearchService

EXPORT MAC_BankruptcyV2_Services_TextSearchService := MACRO

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
										'Search',
										'MaxResults',
										'MaxResultsThisTime',
										'SkipRecords',
										'ReturnHashes',
										'Srch_Hashvals'
									));
ENDMACRO;	