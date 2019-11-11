﻿// This service created to add Web Service fields for all 3 DueDiligence XML services

EXPORT MAC_DueDiligence_Service(reqName) := MACRO

  #WEBSERVICE(FIELDS(	
										/*---- Request Fields ----*/
										reqName,
										/*---- Compliance Fields ----*/
										'DataPermissionMask',
										'DataRestrictionMask',
										'DPPAPurpose',
										'GLBPurpose',
										'HistoryDateYYYYMMDD',
										'SSNMask',
                                        /*---- CCPA ----*/
                                        'LexIdSourceOptout',
                                        '_TransactionId',
                                        '_BatchUID',
                                        '_GCID',
										/*---- Debug ----*/
										'DebugMode',
										'IntermediateVariables'
									));
ENDMACRO;