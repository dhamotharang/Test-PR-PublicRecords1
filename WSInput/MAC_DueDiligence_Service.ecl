// This service created to add Web Service fields for all 3 DueDiligence XML services

EXPORT MAC_DueDiligence_Service(reqName) := MACRO

  #WEBSERVICE(FIELDS(	
										/*---- Request Fields ----*/
										reqName,
										/*---- Gateways ----*/
										'Gateways',
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