// This service created to add Web Service fields for doxie.DOC_Search_People

EXPORT MAC_DOC_Search_People() := MACRO

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
										'DOCState',
										'OffenderKey',
										/*---- Options ----*/
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


 