EXPORT Out_Strata_Population_Stats (pDltGwy  		// DeltabaseGateway File
																		,pVersion 	// Strata Stats Version
																		,zOut)    	// Population Stats Output
:= MACRO

	IMPORT Strata;

	#uniquename(dPopulationStats_pDltGwy);
	#uniquename(zRunDltGwyStats);
	
	//DltGwy File Population Stats	
	%dPopulationStats_pDltGwy% := strata.macf_pops(pDltGwy,
																								'source',
																								,
																								,
																								,
																								,
																								TRUE,
																								['source']);	// remove these fields from population stats
	
	strata.createXMLStats(%dPopulationStats_pDltGwy%, 'DeltabaseGateway', 'HistoricResults', pVersion, 'Population', %zRunDltGwyStats%);

	zOut := %zRunDltGwyStats%;
	
ENDMACRO;