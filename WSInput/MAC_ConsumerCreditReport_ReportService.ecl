EXPORT MAC_ConsumerCreditReport_ReportService := MACRO

	#WEBSERVICE(FIELDS(
		/*---- Compliance Fields ----*/
		'DataRestrictionMask',
		'DOBMask',
		'SSNMask',
		'FCRAPurpose',
		/*---- Other Fields ----*/
		'IncludeLiensJudgments',
		'ScoreThreshold',
		/*---- Gateways ----*/
		'Gateways',
		/*---- ESDL Request Field ----*/
		'FCRAConsumerCreditReportRequest'
	));

ENDMACRO;