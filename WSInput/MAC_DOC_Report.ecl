// This service created to add Web Service fields for doxie.DOC_Report

EXPORT MAC_DOC_Report() := MACRO

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
										'SSNMask',
										'DLMask',
										/*---- Search Fields ----*/
										'FirstName',
										'MiddleName',
										'LastName',
										'DID',
										'DOCNumber',
										'DOCState',
										'OffenderKey',										
										'Raw'
									));
ENDMACRO;	

