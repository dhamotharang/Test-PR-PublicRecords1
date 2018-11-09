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
										'GlobalCompanyId', // Same as Agency
										'IndustryType',	//Same as Agecy Program
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
										'FraudGovReportRequest'
							));	
ENDMACRO;