EXPORT MAC_emailservice_BatchServiceFCRA := MACRO

	#WEBSERVICE(FIELDS(
		/*---- Compliance Fields ----*/
		'ApplicationType',
		'FCRAPurpose',
		'IndustryClass',
		/*---- Masking Fields ----*/
		'FFDOptionsMask',
		/*---- Other Fields ----*/
		'DidScoreThreshold',
		'Max_Results_Per_Acct',
		'ReturnDetailedRoyalties',
		/*---- Gateways ----*/
		'Gateways',
		/*---- Batch ----*/
		'batch_in'
	));

ENDMACRO;
