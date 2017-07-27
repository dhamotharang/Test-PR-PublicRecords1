// This service created to add Web Service fields for doxie.SexOffender_Report

EXPORT MAC_SexOffender_Report() := MACRO

  #WEBSERVICE(FIELDS(	
										/*---- Compliance Fields ----*/
										'ApplicationType',
										'DataPermissionMask',
										'DataRestrictionMask',
										'DPPAPurpose',
										'GLBPurpose',
										/*---- Search Fields ----*/
										'DID',
										'SeisintPrimaryKey'
									));
ENDMACRO;	
