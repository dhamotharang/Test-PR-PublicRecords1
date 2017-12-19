// This service created to add Web Service fields for DueDiligence.DueDiligence_Batch_Service

EXPORT MAC_DueDiligence_Batch_Service := MACRO

  #WEBSERVICE(FIELDS(	
										/*---- Request Fields ----*/
										'batch_in',
										'attributesVersion',
										'includeNews',
										/*---- Gateways ----*/
										'gateways',
										/*---- Compliance Fields ----*/
										'glbaPurpose',
										'dppaPurpose',
										'dataRestriction',
										'dataPermissionMask'
									));
ENDMACRO;