// This service created to add Web Service fields
// for BusinessCredit_Services.BCD_BusinessSearch
// Capital One's Business Credit Decisioning (BCD) service

EXPORT MAC_BusinessCredit_Services_BCD_BusinessSearch := MACRO

	#WEBSERVICE(FIELDS('DPPAPurpose',
											'GLBPurpose',
											'ApplicationType',
											'DataPermissionMask',
											'DataRestrictionMask',
											'SELEID',
											'CompanyName',
											'TIN',
											'ADDR',
											'CITY',
											'STATE',
											'ZIP',
											'sec_range',
											'Radius',
											'PhoneNumber',
											'URL',
											'Email',
											'FirstName',
											'MiddleName',
											'LastName',
											'SIC',
											'SSN',
											'SSNMask',
											'Hsort',
											'LnBranded',
                      'IncludeBusinessCredit',
											'StartingRecord',
											'ReturnCount',
                      'BcdBusinessSearchRequest'));

ENDMACRO;