// This service created to add Web Service fields for BankruptcyV2_Services.BankruptcyReportService

EXPORT MAC_BankruptcyV2_Services_ReportService := MACRO

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
										'TMSID',
										'AllBkAllDebtors',
										'IncludeCriminalIndicators'
									));
ENDMACRO;	