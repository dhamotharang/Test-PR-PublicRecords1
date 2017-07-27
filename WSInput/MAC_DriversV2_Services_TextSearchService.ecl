EXPORT MAC_DriversV2_Services_TextSearchService := MACRO
	#WEBSERVICE(FIELDS(	'Search',
											'IncludeNonDMVSources',
											'DOBMask',
											'DPPAPurpose',
											'MaxResults',
											'MaxResultsThisTime',
											'SkipRecords'										
										));
ENDMACRO;