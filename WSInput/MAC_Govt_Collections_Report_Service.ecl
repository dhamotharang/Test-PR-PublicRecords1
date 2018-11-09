// This service created to add Web Service fields for Govt_Collections_Services.Report_Service

EXPORT MAC_Govt_Collections_Report_Service := MACRO
	#WEBSERVICE(FIELDS( 
											/*---- Compliance Fields .----*/
											'ApplicationType',
											'DataPermissionMask',
											'DataRestrictionMask',
											'DLMask',
											'dobMask',
											'DPPAPurpose',
											'GLBPurpose',
											'IndustryClass',
											'ssnMask',
											/*---- ESDL Request Field .----*/
											'IdentityContactResolutionReportRequest'
										));	                  
ENDMACRO;
