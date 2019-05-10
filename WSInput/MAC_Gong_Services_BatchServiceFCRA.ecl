EXPORT MAC_Gong_Services_BatchServiceFCRA := MACRO

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
		/*---- Gateways ----*/
		'Gateways',
		/*---- Batch ----*/
		'batch_in'
	));

ENDMACRO;
