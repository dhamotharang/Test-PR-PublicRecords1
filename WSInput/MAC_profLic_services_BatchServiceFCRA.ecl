EXPORT MAC_profLic_services_BatchServiceFCRA := MACRO

	#WEBSERVICE(FIELDS(
		/*---- Compliance Fields ----*/
		'ApplicationType',
		'FCRAPurpose',
		'IndustryClass',
		/*---- Masking Fields ----*/
		'DOBMask',
		'FFDOptionsMask',
		/*---- Other Fields ----*/
		'DidScoreThreshold',
		'Max_Results_Per_Acct',
		/*---- Gateways ----*/
		'Gateways',
		/*---- Batch ----*/
		'batch_in'
	));

ENDMACRO;