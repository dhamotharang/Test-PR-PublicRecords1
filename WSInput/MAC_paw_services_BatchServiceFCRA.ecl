EXPORT MAC_paw_services_BatchServiceFCRA := MACRO

	#WEBSERVICE(FIELDS(
		/*---- Compliance Fields ----*/
		'ApplicationType',
		'FCRAPurpose',
		'GLBPurpose',
		'IndustryClass',
		/*---- Masking Fields ----*/
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