EXPORT MAC_ConsumerCreditReport_ReportServiceFCRA := MACRO

	#WEBSERVICE(FIELDS(
		/*---- Compliance Fields ----*/
		'DataRestrictionMask',
		'DOBMask',
		'SSNMask',
		'GLBPurpose',
		'PermissiblePurpose',
		'FFDOptionsMask',
		'FCRAPurpose',
		/*---- Other Fields ----*/
		'IncludeLiensJudgments',
		/*---- Gateways ----*/
		'Gateways',
		/*---- ESDL Request Field ----*/
		'FCRAConsumerCreditReportRequest'
	));

ENDMACRO;