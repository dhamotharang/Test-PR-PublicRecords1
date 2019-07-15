EXPORT Out_Strata_Population_Stats(	pIdent   	// Identities
																		,pOPhones // Other Phones
																		,pRInd		// Risk Indicators
																		,pTrans		// Transactions
																		,pVersion // Version of Strata Stats
																		,zOut)    // Output of Population Stats
:= MACRO

IMPORT Strata;

	#uniquename(dPopulationStats_pIdent);
	#uniquename(zRunIdentStats);
	
	#uniquename(dPopulationStats_pOPhones);
	#uniquename(zRunOPhonesStats);
	
	#uniquename(dPopulationStats_pRInd);
	#uniquename(zRunRIndStats);
	
	#uniquename(dPopulationStats_pTrans);
	#uniquename(zRunTransStats);
	
	//Identities Population Stats	
	%dPopulationStats_pIdent% := strata.macf_pops(pIdent,
																								'verified_carrier',
																								,
																								,
																								,
																								,
																								TRUE,
																								['verified_carrier']);	// remove these fields from population stats
	
	strata.createXMLStats(%dPopulationStats_pIdent%, 'PhoneFinderRptDelta', 'Identities', pVersion, 'Population', %zRunIdentStats%);

	//Other Phones Population Stats
	%dPopulationStats_pOPhones% := strata.macf_pops(pOPhones,
																									'phone_type',
																									,
																									,
																									,
																									,
																									TRUE,
																									['phone_type']);	// remove these fields from population stats																		
		
	strata.createXMLStats(%dPopulationStats_pOPhones%, 'PhoneFinderRptDelta', 'OtherPhones', pVersion, 'Population', %zRunOPhonesStats%);
	
	//Risk Indicators Population Stats
	%dPopulationStats_pRInd% := strata.macf_pops(pRInd,
																								'risk_indicator_category',
																								,
																								,
																								,
																								,
																								TRUE,
																								['risk_indicator_category']);	// remove these fields from population stats																		
		
	strata.createXMLStats(%dPopulationStats_pRInd%, 'PhoneFinderRptDelta', 'RiskIndicators', pVersion, 'Population', %zRunRIndStats%);
	
	//Transactions Population Stats
	%dPopulationStats_pTrans% := strata.macf_pops(pTrans,
																								'company_id',
																								,
																								,
																								,
																								,
																								TRUE,
																								['company_id']);	// remove these fields from population stats																		
		
	strata.createXMLStats(%dPopulationStats_pTrans%, 'PhoneFinderRptDelta', 'Transactions', pVersion, 'Population', %zRunTransStats%);
	
	zOut := parallel(%zRunIdentStats%, %zRunOPhonesStats%, %zRunRIndStats%, %zRunTransStats%);
	
ENDMACRO;