// This service created to add Web Service fields for DueDiligence.DueDiligence_Service 

EXPORT MAC_DueDiligence_Service := MACRO

  #WEBSERVICE(FIELDS(	
										/*---- Request Fields ----*/
										'DueDiligenceReportRequest',
										/*---- Gateways ----*/
										//'Gateways'
										/*---- Compliance Fields ----*/
										'DataPermissionMask',
										'DataRestrictionMask',
										'DPPAPurpose',
										'GLBPurpose',
										'HistoryDateYYYYMMDD',
										/*---- Debug ----*/
										'DebugMode',
										'IntermediateVariables'
									));
ENDMACRO;	