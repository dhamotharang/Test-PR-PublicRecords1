EXPORT MAC_FraudGovPlatform_Services_ReportService := MACRO
	#WEBSERVICE(FIELDS( 
										/*---- Compliance Fields .----*/
										'ApplicationType',
										'DataPermissionMask',
										'DataRestrictionMask',
										'DLMask',
										'DOBMask',
										'DPPAPurpose',
										'GLBPurpose',
										'IndustryClass',
										'SSNMask',
										/*---- FDN Fields .----*/
										'GlobalCompanyId',
										'IndustryTypeName',
										'ProductCode',
										/*---- ESDL Request Field ----*/
										'FraudGovReportRequest',
										/*-----Gateway info -----*/
										'Gateways'
							));	
ENDMACRO;