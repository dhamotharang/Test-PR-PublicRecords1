IMPORT RiskWise, _control;

EXPORT Constants := MODULE    
	
	
	//***********************************************************************************************
	//** ExtraPrefix - typically for customer test or qc test to create their own super files 
	//**                without overwriting the developer's work - example: '::CT' '::QC'
	//***********************************************************************************************
	EXPORT ExtraPrefix		:= '' : STORED('ExtraPrefix'); 	
	
	EXPORT MMPrefix     := '~in::marketmagnifier' + ExtraPrefix + '::leadintegrity::';
	EXPORT MMPrefixNM    := 'in::marketmagnifier' + ExtraPrefix + '::leadintegrity::';
	Export ARPrefix     := '~out::base' + ExtraPrefix + '::ar::';
	
	
		EXPORT DataRestrictionMask := '0000000000000101000000000000000000000000';
		EXPORT DataPermissionMask := '000000000000000000000000000000'; 
		EXPORT DPPAPurpose := 0;
		EXPORT GLBPurpose := 6;
		EXPORT MODELNAME := 'msn1106_0';
		
 EXPORT AR_EmailAddresses := 'RIS-BI-AnalyticsRepository@lexisnexis.com,Vault.Logistics@risk.lexisnexis.com';
 EXPORT DF_EmailAddresses := 'a&rdata.engineering.support@lexisnexisrisk.com';
 EXPORT DO_EmailAddresses := 'InsDataOps@lexisnexis.com';
 EXPORT PRD_EmailAddresses := 'RIS-BI-AnalyticsRepository@lexisnexis.com,Vault.Logistics@risk.lexisnexis.com,a&rdata.engineering.support@lexisnexisrisk.com,InsDataOps@lexisnexis.com';
 EXPORT DEV_EmailAddresses := 'melissa.newport@lexisnexisrisk.com,sanjay.narla@lexisnexisrisk.com';
	EXPORT TeamEmailList := if (_control.ThisEnvironment.name='Prod',PRD_EmailAddresses,DEV_EmailAddresses);
	


		EXPORT recordsToRun := 0;
		EXPORT eyeball := 50;

		EXPORT threads := 1;

		EXPORT roxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie; // Production
		// roxieIP := RiskWise.shortcuts.prod_batch_neutral; // Production
		// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert

		EXPORT inputFile := '~foreign::prod_esp.br.seisint.com::' +'bxb::ar::marketmagnifier::leadintegrity::201801_14_of_15';
		//inputFile := '~foreign::10.194.112.105::' + 'bxb::ar::leadintegrity::ih_1m_input';
		// inputFile := '~foreign::10.194.90.202::' + 'bxb::ar::riskview50::1m_input20170921';
		EXPORT outputFile := '~thor::base' + ExtraPrefix + '::ar::201801::LeadIntegrity::p14';

		// Versions Available: 1, 3 and 4
		EXPORT version := 4;
		EXPORT LeadIntegrityBatchService := 'Models.LeadIntegrity_Batch_Service';
	
END;