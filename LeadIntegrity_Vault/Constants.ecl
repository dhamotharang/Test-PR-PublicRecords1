IMPORT RiskWise;

EXPORT Constants := MODULE    
	
		EXPORT DataRestrictionMask := '0000000000000101000000000000000000000000';
		EXPORT DataPermissionMask := '000000000000000000000000000000'; 
		EXPORT DPPAPurpose := 0;
		EXPORT GLBPurpose := 6;
		EXPORT MODELNAME := 'msn1106_0';
		// EXPORT TeamEmailList					:= 'sanjay.narla@lexisnexisrisk.com';
		EXPORT TeamEmailList					:= 'CPPM-Data.Acquisitions.Management2@risk.lexisnexis.com,RIS-BI-AnalyticsRepository@lexisnexis.com,Vault.Logistics@risk.lexisnexis.com';


		EXPORT recordsToRun := 0;
		EXPORT eyeball := 50;

		EXPORT threads := 1;

		EXPORT roxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie; // Production
		// roxieIP := RiskWise.shortcuts.prod_batch_neutral; // Production
		// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert

		EXPORT inputFile := '~foreign::prod_esp.br.seisint.com::' +'bxb::ar::marketmagnifier::leadintegrity::201801_14_of_15';
		//inputFile := '~foreign::10.194.112.105::' + 'bxb::ar::leadintegrity::ih_1m_input';
		// inputFile := '~foreign::10.194.90.202::' + 'bxb::ar::riskview50::1m_input20170921';
		EXPORT outputFile := '~thor::base::ar::201801::LeadIntegrity::p14';

		// Versions Available: 1, 3 and 4
		EXPORT version := 4;
		EXPORT LeadIntegrityBatchService := 'Models.LeadIntegrity_Batch_Service';
	
END;