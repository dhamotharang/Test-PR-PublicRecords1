EXPORT Constants := Module
	Export Principles := 'P';
	Export HCP := 'I';
	Export HCO := 'O';
	Export Orgs := 'M';
	
	Export Input := 'APS';
	Export LexisNexis := 'LN';
	
	Export Warnings := Module
		Export NoRecordIdentifier := '100';
		Export NoLegalName := '101';
		Export NoDoingBusinessAs := '102';
		Export NoTaxId := '103';
		Export NoAddress := '104';
		Export NoFirstName := '105';
		Export NoLastName := '106';
		Export NoGender := '107';
		Export NoDob := '108';
		Export NoSSN := '109';
		Export NoNPI := '110';
		Export NoEntityType := '111';	
		Export NoHit := '199';
	END;
END;