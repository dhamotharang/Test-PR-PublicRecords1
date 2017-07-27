// This service created to add Web Service fields for BankruptcyV3_Services.BankruptcyReportService

EXPORT MAC_BankruptcyV3_Services_BankruptcyReportService := MACRO

     #WEBSERVICE(FIELDS(
                        /*---- Compliance Fields ----*/			                    
												'ApplicationType',
												'DataPermissionMask',
												'DataRestrictionMask',
												'DLMask',
												'DOBMask',
												'DPPAPurpose',
												'GLBPurpose',
												'IndustryClass',
												'SSNMask',  
												/*---- ID's	----*/
                        'DID',												
												'BDID',
												'TMSID',
												/*---- Misc Input Options	----*/
												'AllBkAllDebtors',
												'LowerEnteredDateLimit',
												'UpperEnteredDateLimit',
												/*---- Boolean Input Options ----*/ 
												'IncludeDockets'
											 ));

ENDMACRO;