EXPORT MAC_DLReportService := MACRO
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
											'DLSeq',
											'DriversLicense',
											'PenaltThreshold',
											'IncludeAccidents',
											'IncludeConvictions',
											'IncludeDRInfo',
											'IncludeEverything',
											'IncludeFRAInsurance',
											'IncludeNonDMVSources',
											'IncludeSuspensions',
											'MaxResults',
											'MaxResultsThisTime',
											'SkipRecords'
											));
ENDMACRO;