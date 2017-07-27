// This service created to add Web Service fields for BenefitAssessment_Services.SearchServiceFCRA

EXPORT MAC_BenefitAssessment_Services_SearchServiceFCRA := MACRO

	 #WEBSERVICE(FIELDS(
											 /*---- Compliance Fields ----*/
											 'ApplicationType',
											 'DataPermissionMask',
											 'DataRestrictionMask',
											 'DLMask',
											 'DOBMask',
											 'DPPAPurpose',
											 'GLBPurpose',
											 'IndustryClass',
											 'SSNMask',
											 /*---- Other Fields ----*/ 
											 'Gateways',
											 /*---- ESDL Request Field ----*/
											 'FcraBenefitAssessSearchRequest'
										));

ENDMACRO;