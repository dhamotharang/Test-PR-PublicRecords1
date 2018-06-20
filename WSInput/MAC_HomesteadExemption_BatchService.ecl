EXPORT MAC_HomesteadExemption_BatchService := MACRO

	#WEBSERVICE(FIELDS(
		/*---- Compliance Fields ----*/
		'DPPAPurpose',
		'GLBPurpose',
		'SSNMask',
		'DOBMask',
		'DataPermissionMask',
		'DataRestrictionMask',
		/*---- Other Fields ----*/
		'DidScoreThreshold',
		'MaxProperties',
		'TaxYear',
		'TaxState',
		'LNBranded',
		'ReturnDetailedRoyalties',
		'IncludeRealtimeVehicles',
		'RealTimePermissibleUse',
		/*---- Gateways ----*/
		'Gateways',
		/*---- Batch ----*/
		'batch_in'
	));

ENDMACRO;
