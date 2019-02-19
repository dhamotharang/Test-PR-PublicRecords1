IMPORT KELOtto, ut,tools; 
EXPORT Build_Base_Kel (
   string pversion
) := 
module 

	tools.mac_WriteFile(Filenames(pversion).Base.kel_customeraddress.New, KELOtto.KelFiles.CustomerAddress, Build_kel_customeraddress , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_personstats.New, KELOtto.KelFiles.PersonStats, Build_kel_personstats , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_personevents.New, KELOtto.KelFiles.PersonEvents, Build_kel_personevents , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_customerstats.New, KELOtto.KelFiles.CustomerStats, Build_kel_customerstats , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_CustomerStatsPivot.New, KELOtto.KelFiles.CustomerStatsPivot, Build_kel_CustomerStatsPivot , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_fullgraph.New, KELOtto.KelFiles.FullCluster, Build_kel_fullgraph , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_entitystats.New, KELOtto.KelFiles.EntityStats, Build_kel_entitystats , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_person_associations_stats.New, KELOtto.KelFiles.PersonAssociationsStats, Build_kel_person_associations_stats , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_person_associations_details.New, KELOtto.KelFiles.PersonAssociationsDetails, Build_kel_person_associations_details , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_entity_scorebreakdown.New, KELOtto.KelFiles.ScoreBreakdown, Build_kel_entity_scorebreakdown , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_CustomerDashTopEntityStats.New, KELOtto.CustomerDash.TopEntityStats, Build_kel_CustomerDashTopEntityStats , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_CustomerDashTopClustersAndElements.New, KELOtto.CustomerDash.TopClustersAndElements, Build_kel_CustomerDashTopClustersAndElements , pOverwrite := true);
	

// Return
	export full_build :=
		 Parallel(
			 Build_kel_customeraddress,
			 Build_kel_personstats,
			 Build_kel_personevents,
			 Build_kel_customerstats,
			 Build_kel_CustomerStatsPivot,
			 Build_kel_fullgraph,
			 Build_kel_entitystats,
			 Build_kel_person_associations_stats,
			 Build_kel_person_associations_details,
			 Build_kel_entity_scorebreakdown,
			 Build_kel_CustomerDashTopEntityStats,
			 Build_kel_CustomerDashTopClustersAndElements
			 
		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_Kel atribute')
	);
	
end;
