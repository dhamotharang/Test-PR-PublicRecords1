EXPORT MAC_PersonSearch_Services_CheckSearchService := MACRO
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
									/*----  Pagination Fields ----*/
									'MaxResults',
									'MaxResultsThisTime',
									'SkipRecords',
									/*----  iesp form ----*/
									'CheckPersonSearchRequest'
									));


ENDMACRO;