﻿EXPORT MAC_FraudGovPlatform_Services_BatchService := MACRO
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
										'TestVelocityRules',
										/*---- Batch_In Request Field .----*/
										'batch_in'
							));	
ENDMACRO;