// This service created to add Web Service fields for BusinessCredit_Services.CreditReportService

EXPORT MAC_BusinessCredit_Services_CreditReportService := MACRO

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
										'BusinessCreditReportRequest'
									));
ENDMACRO;	