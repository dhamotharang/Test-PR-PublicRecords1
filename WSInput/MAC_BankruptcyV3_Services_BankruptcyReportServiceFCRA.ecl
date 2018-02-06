// This service created to add Web Service fields for BankruptcyV3_Services.BankruptcyReportServiceFCRA

EXPORT MAC_BankruptcyV3_Services_BankruptcyReportServiceFCRA := MACRO

     #WEBSERVICE(FIELDS(
                        /*---- Compliance Fields ----*/			                    
												'ApplicationType',
												'DataPermissionMask',
												'DataRestrictionMask',
												'DLMask',
												'DOBMask',
												'DPPAPurpose',
										  'FCRAPurpose',
												'GLBPurpose',
												'IndustryClass',
												'SSNMask',
												/*---- ID's	----*/
												'DID',												
												'PersonFilterID',
												'TMSID',
												/*---- Misc Input Options	----*/
												'PartyType',
												'LowerEnteredDateLimit',
												'UpperEnteredDateLimit',
												'NonSubjectSuppression',
												'ApplyNonsubjectRestrictions',
												'SuppressWithdrawnBankruptcy',
												'FFDOptionsMask',
												/*---- Boolean Input Options ----*/
												'IncludeDockets',
												/*---- Gateways, if applicable ----*/
											  'Gateways'
											 ));

ENDMACRO;