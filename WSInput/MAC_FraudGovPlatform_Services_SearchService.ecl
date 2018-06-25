EXPORT MAC_FraudGovPlatform_Services_SearchService := MACRO
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
										/*---- ESDL Request Field ----*/
										'FraudGovSearchRequest',
										/*----Gateway-----*/
										'Gateways'
							));	
ENDMACRO;