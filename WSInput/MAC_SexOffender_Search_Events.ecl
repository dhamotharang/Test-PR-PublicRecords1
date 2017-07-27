// This service created to add Web Service fields for doxie.SexOffender_Search_Events

EXPORT MAC_SexOffender_Search_Events() := MACRO

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
										'AllowNickNames',
										'PhoneticMatch'
									));
ENDMACRO;	

