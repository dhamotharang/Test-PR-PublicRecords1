EXPORT MAC_FDD_ConsumerSearchService := MACRO

	#WEBSERVICE(FIELDS(
		/*---- Gateways ----*/
		'Gateways',
		/*---- ESDL Request Field ----*/
		'fcraConsumerSearchRequest'
	));

ENDMACRO;