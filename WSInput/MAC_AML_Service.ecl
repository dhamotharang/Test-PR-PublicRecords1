// This service created to add Web Service fields for AML.AML_Service

EXPORT MAC_AML_Service := MACRO

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
										'HistoryDateYYYYMM',
										'AntiMoneyLaunderingRiskAttributesRequest',
										/*---- Gateways ----*/
										'Gateways',
                                        'LexIdSourceOptout',
                                        '_TransactionId',
                                        '_BatchUID',
                                        '_GCID'
									));
ENDMACRO;	