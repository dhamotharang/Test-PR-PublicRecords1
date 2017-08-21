EXPORT Out_STRATA_Population_Stats( pIPMetadata 	// IPMetadata File	
																		,pVersion     // Version of Strat Stats
																		,zOut)        // Output of Population Stats
:= MACRO
 
import Strata, PhonesInfo, ut;

	#uniquename(dPopulationStats_pIPMetadata);
	#uniquename(zRunIPMetadataStats);
	
	//IP_Metadata Population Stats	
	%dPopulationStats_pIPMetadata% := strata.macf_pops(pIPMetadata(is_current=TRUE),
																							'edge_conn_speed',
																							,
																							,
																							,
																							,
																							TRUE,
																							['edge_conn_speed']);	// remove these fields from population stats
	
	strata.createXMLStats(%dPopulationStats_pIPMetadata%, 'IPMetadata', 'ConnSpeed', pVersion, 'Population', %zRunIPMetadataStats%);

	zOut := %zRunIPMetadataStats%;

ENDMACRO;