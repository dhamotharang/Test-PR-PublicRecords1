EXPORT MAC_DriversV2_Services_FocusSearchService := MACRO
	#WEBSERVICE(FIELDS(	'FocusSearch',
											'FocusDocIDs',
											'IncludeNonDMVSources',
											'DOBMask',
											'DPPAPurpose',
											'MaxResults',
											'MaxResultsThisTime',
											'SkipRecords'										
										));
ENDMACRO;