// This service created to add Web Service fields for DueDiligence.DueDiligence_Service

EXPORT MAC_DueDiligence_Service := MACRO

  #WEBSERVICE(FIELDS(	
										/*---- Other Fields ----*/
										'DueDiligenceReportRequest',
										/*---- Gateways ----*/
										//'Gateways'
										/*---- Debug ----*/
										'DebugMode',
										'IntermediateVariables'
									));
ENDMACRO;	