// This service created to add Web Service fields for doxie.DOC_Search_Events

EXPORT MAC_DOC_Search_Events() := MACRO

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
										'SSNMask',
										'DLMask',
										/*---- Search Fields ----*/
										'DID',
										'SSN',
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
										'ZipRadius',
										'Phone',
										'DOB',
										'AgeLow',
										'AgeHigh',
										'DID',
										'DOCNumber',
										'OffenderKey',
										/*---- Options ----*/
										'ReturnOffenses',
										'ReturnParoles',
										'ReturnPrisonTerms',
										'ReturnActivities',
										'AllowNickNames',
										'PhoneticMatch',
										'ScoreThreshold',
										'MaxResults',
										'MaxResultsThisTime',
										'SkipRecords',
										'noDeepDive',
										'Raw'
									));
ENDMACRO;	


 