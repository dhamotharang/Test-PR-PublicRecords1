EXPORT MAC_FAA_Pilot_BatchService() := MACRO

	#WEBSERVICE(FIELDS(
		/*---- Compliance Fields ----*/
		'ApplicationType',
		/*---- Masking Fields ----*/
		'SSNMask',
		/*---- Batch ----*/
		'batch_in'
	));

ENDMACRO;
