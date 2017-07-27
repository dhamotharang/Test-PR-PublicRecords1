// This service created to add Web Service fields for Accident_Services.SearchService

EXPORT MAC_Accident_Services_SearchService := MACRO

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
                    'BDID',
                    'UnParsedFullName',
                    'FirstName',
                    'MiddleName',
                    'LastName',
                    'NameSuffix',
                    'AllowNicknames',
                    'prim_range',
                    'predir',
                    'prim_name',
                    'suffix',
                    'postdir',
                    'sec_range',
                    'Addr',
                    'City',
                    'State',
                    'Zip',
                    'PhoneticMatch',
                    'StrictMatch',
                    'MaxWaitSeconds',
                    'ReturnCount',
                    'StartingRecord',
                    'DeepDive',
                    'PenaltThreshold',                    
                    'AccidentSearchRequest'
								));
ENDMACRO;								