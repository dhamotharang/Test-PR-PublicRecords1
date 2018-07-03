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
										/*---- Other Fields .----*/
										'AgencyCounty',
										'AgencyState',
										'AgencyVerticalType',
										'AppendBest',
										'DIDScoreThreshold',
										'FraudPlatform',
										'MaxVelocities',
										/*---- ESDL Request Field ----*/
										'FraudGovReportRequest',
										/*-----Gateway info -----*/
										'Gateways'
							));	
ENDMACRO;