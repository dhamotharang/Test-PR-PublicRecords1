EXPORT Constants := MODULE
	EXPORT string20 FCRA_Restricted := 'FCRA Restricted';
	
	export ALERT_CODE := module
		export string INSUFFICIENT_INPUT_INFO := '50A';
		export string SECURITY_FREEZE := '100A';
		export string SECURITY_FRAUD_ALERT := '100B';
		export string CONSUMER_STATEMENT := '100C';
		export string STATE_EXCEPTION := '100D';
		export string NO_DID_FOUND := '222A';
	end;
	
	export string ALERT_DESCRIPTION(string c) := case(c,
					ALERT_CODE.INSUFFICIENT_INPUT_INFO 	=> 	'Insufficient Input',
					ALERT_CODE.SECURITY_FREEZE				 	=>	'Security Freeze on file',
					ALERT_CODE.SECURITY_FRAUD_ALERT			=>	'Security Fraud Alert on file',
					ALERT_CODE.CONSUMER_STATEMENT				=>	'Consumer Statement on file',
					ALERT_CODE.STATE_EXCEPTION					=>  'Insufficient verification to return a score under state or federal law',
					ALERT_CODE.NO_DID_FOUND							=>	'No consumer file was found matching the input information',
					'');
	
	EXPORT FCRAPurpose := MODULE
    // Various FCRAPurpose options available, currently only implemented for Insurance Application
		EXPORT Integer NoValueProvided := -1;
		EXPORT Integer NoPermissiblePurpose := 0;
		EXPORT Integer Application := 1;
		EXPORT Integer Collections := 2;
		EXPORT Integer Government := 3;
		EXPORT Integer HealthcareCreditTranscation := 4;
		EXPORT Integer HealthcareLegitimateBusinessNeed := 5;
		EXPORT Integer InsuranceApplication := 6;
		EXPORT Integer InsurancePortfolioReview := 7;
		EXPORT Integer PortfolioReview := 8;
		EXPORT Integer PreScreening := 9;
		EXPORT Integer RentalCarLossDamageWaiver := 10;
		EXPORT Integer TenantScreening := 11;
		EXPORT Integer AccountReview := 12;
		EXPORT Integer InstructedByConsumer := 13;
  END;
	
END;