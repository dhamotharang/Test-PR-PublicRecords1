// This service created to add Web Service fields for doxie.SexOffender_Search

EXPORT MAC_SexOffender_Search() := MACRO

  #WEBSERVICE(FIELDS(	
										/*---- Compliance Fields ----*/
										'ApplicationType',
										'DataPermissionMask',
										'DataRestrictionMask',
										'DPPAPurpose',
										'GLBPurpose',
										/*---- Search Fields ----*/
										'SeisintPrimaryKey',
										'DID',
										'SSN',
										'UnParsedFullName',
										'FirstName',
										'MiddleName',
										'LastName',
										'OtherLastName1',
										'RelativeFirstName1',
										'RelativeFirstName2',
										'Addr',
										'City',
										'OtherCity1',
										'State',
										'OtherState1',
										'OtherState2',
										'Zip',
										'Radius',
										'SearchAroundAddress',
										'Phone',
										'DOB',
										'AgeLow',
										'AgeHigh',
										/*---- Options ----*/
										'MaxResults',
										'MaxResultsThisTime',
										'SkipRecords',
										'Raw',
										'ScoreThreshold',
										'IncludeHistoricalAltAddresses',
										'IncludeRelativeAltAddresses',
										'ExcludeRegisteredAltAddresses',
										'IncludeNonRegisteredAltAddresses',
										'ReturnHashes',
										'srch_hashvals'
									));
ENDMACRO;	

