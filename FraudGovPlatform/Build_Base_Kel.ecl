IMPORT KELOtto, ut,tools; 
EXPORT Build_Base_Kel (
   string pversion
) := 
module 

	shared Base_customeraddress											:=	files().base.kel_customeraddress_delta.built
																										+ files().base.kel_customeraddress_demo.built;
	shared Base_customerdashtopclustersandelements	:=	files().base.kel_customerdashtopclustersandelements_delta.built
																										+ files().base.kel_customerdashtopclustersandelements_demo.built;
	shared Base_customerdashtopentitystats					:=	files().base.kel_customerdashtopentitystats_delta.built
																										+	files().base.kel_customerdashtopentitystats_demo.built;
	shared Base_customerstats												:=	files().base.kel_customerstats_delta.built
																										+	files().base.kel_customerstats_demo.built;
	shared Base_customerstatspivot									:=	files().base.kel_customerstatspivot_delta.built
																										+	files().base.kel_customerstatspivot_demo.built;
	shared Base_entity_scorebreakdown								:=	files().base.kel_entity_scorebreakdown_delta.built
																										+	files().base.kel_entity_scorebreakdown_demo.built;
	shared Base_entitystats													:=	files().base.kel_entitystats_delta.built
																										+	files().base.kel_entitystats_demo.built;
	shared Base_fullgraph														:=	 files().base.kel_fullgraph_delta.built
																										+	files().base.kel_fullgraph_demo.built;
	shared Base_person_associations_details					:=	files().base.kel_person_associations_details_delta.built
																										+	files().base.kel_person_associations_details_demo.built;
	shared Base_person_associations_stats						:=	files().base.kel_person_associations_stats_delta.built
																										+ files().base.kel_person_associations_stats_demo.built;
	shared Base_personevents												:=	files().base.kel_personevents_delta.built
																										+	files().base.kel_personevents_demo.built;
	shared Base_personstats													:=	files().base.kel_personstats_delta.built 
																										+	files().base.kel_personstats_demo.built;
																					
	tools.mac_WriteFile(Filenames(pversion).Base.kel_customeraddress.New, Base_customeraddress, Build_kel_customeraddress , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_personstats.New, Base_personstats, Build_kel_personstats , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_personevents.New, Base_personevents, Build_kel_personevents , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_customerstats.New, Base_customerstats, Build_kel_customerstats , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_CustomerStatsPivot.New, Base_customerstatspivot, Build_kel_CustomerStatsPivot , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_fullgraph.New, Base_fullgraph, Build_kel_fullgraph , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_entitystats.New, Base_entitystats, Build_kel_entitystats , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_person_associations_stats.New, Base_person_associations_stats, Build_kel_person_associations_stats , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_person_associations_details.New, Base_person_associations_details, Build_kel_person_associations_details , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_entity_scorebreakdown.New, Base_entity_scorebreakdown, Build_kel_entity_scorebreakdown , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_CustomerDashTopEntityStats.New, Base_customerdashtopentitystats, Build_kel_CustomerDashTopEntityStats , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_CustomerDashTopClustersAndElements.New, Base_customerdashtopclustersandelements, Build_kel_CustomerDashTopClustersAndElements , pOverwrite := true);
	//KEL Demo
	tools.mac_WriteFile(Filenames(pversion).Base.kel_customeraddress_Demo.New, KELOtto.KelFiles.CustomerAddress, Build_kel_customeraddress_Demo , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_personstats_Demo.New, KELOtto.KelFiles.PersonStats, Build_kel_personstats_Demo , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_personevents_Demo.New, KELOtto.KelFiles.PersonEvents, Build_kel_personevents_Demo , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_customerstats_Demo.New, KELOtto.KelFiles.CustomerStats, Build_kel_customerstats_Demo , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_CustomerStatsPivot_Demo.New, KELOtto.KelFiles.CustomerStatsPivot, Build_kel_CustomerStatsPivot_Demo , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_fullgraph_Demo.New, KELOtto.KelFiles.FullCluster, Build_kel_fullgraph_Demo , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_entitystats_Demo.New, KELOtto.KelFiles.EntityStats, Build_kel_entitystats_Demo , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_person_associations_stats_Demo.New, KELOtto.KelFiles.PersonAssociationsStats, Build_kel_person_associations_stats_Demo , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_person_associations_details_Demo.New, KELOtto.KelFiles.PersonAssociationsDetails, Build_kel_person_associations_details_Demo , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_entity_scorebreakdown_Demo.New, KELOtto.KelFiles.ScoreBreakdown, Build_kel_entity_scorebreakdown_Demo , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_CustomerDashTopEntityStats_Demo.New, KELOtto.CustomerDash.TopEntityStats, Build_kel_CustomerDashTopEntityStats_Demo , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_CustomerDashTopClustersAndElements_Demo.New, KELOtto.CustomerDash.TopClustersAndElements, Build_kel_CustomerDashTopClustersAndElements_Demo , pOverwrite := true);
	//KEL Delta
	tools.mac_WriteFile(Filenames(pversion).Base.kel_customeraddress_Delta.New, KELOtto.KelFiles.CustomerAddress, Build_kel_customeraddress_Delta , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_personstats_Delta.New, KELOtto.KelFiles.PersonStats, Build_kel_personstats_Delta , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_personevents_Delta.New, KELOtto.KelFiles.PersonEvents, Build_kel_personevents_Delta , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_customerstats_Delta.New, KELOtto.KelFiles.CustomerStats, Build_kel_customerstats_Delta , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_CustomerStatsPivot_Delta.New, KELOtto.KelFiles.CustomerStatsPivot, Build_kel_CustomerStatsPivot_Delta , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_fullgraph_Delta.New, KELOtto.KelFiles.FullCluster, Build_kel_fullgraph_Delta , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_entitystats_Delta.New, KELOtto.KelFiles.EntityStats, Build_kel_entitystats_Delta , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_person_associations_stats_Delta.New, KELOtto.KelFiles.PersonAssociationsStats, Build_kel_person_associations_stats_Delta , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_person_associations_details_Delta.New, KELOtto.KelFiles.PersonAssociationsDetails, Build_kel_person_associations_details_Delta , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_entity_scorebreakdown_Delta.New, KELOtto.KelFiles.ScoreBreakdown, Build_kel_entity_scorebreakdown_Delta , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_CustomerDashTopEntityStats_Delta.New, KELOtto.CustomerDash.TopEntityStats, Build_kel_CustomerDashTopEntityStats_Delta , pOverwrite := true);
	tools.mac_WriteFile(Filenames(pversion).Base.kel_CustomerDashTopClustersAndElements_Delta.New, KELOtto.CustomerDash.TopClustersAndElements, Build_kel_CustomerDashTopClustersAndElements_Delta , pOverwrite := true);
	
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
	
		export full_build_Demo :=
		 Parallel(
			 Build_kel_customeraddress_Demo,
			 Build_kel_personstats_Demo,
			 Build_kel_personevents_Demo,
			 Build_kel_customerstats_Demo,
			 Build_kel_CustomerStatsPivot_Demo,
			 Build_kel_fullgraph_Demo,
			 Build_kel_entitystats_Demo,
			 Build_kel_person_associations_stats_Demo,
			 Build_kel_person_associations_details_Demo,
			 Build_kel_entity_scorebreakdown_Demo,
			 Build_kel_CustomerDashTopEntityStats_Demo,
			 Build_kel_CustomerDashTopClustersAndElements_Demo
			 
		);
		
			export full_build_Delta :=
		 Parallel(
			 Build_kel_customeraddress_Delta,
			 Build_kel_personstats_Delta,
			 Build_kel_personevents_Delta,
			 Build_kel_customerstats_Delta,
			 Build_kel_CustomerStatsPivot_Delta,
			 Build_kel_fullgraph_Delta,
			 Build_kel_entitystats_Delta,
			 Build_kel_person_associations_stats_Delta,
			 Build_kel_person_associations_details_Delta,
			 Build_kel_entity_scorebreakdown_Delta,
			 Build_kel_CustomerDashTopEntityStats_Delta,
			 Build_kel_CustomerDashTopClustersAndElements_Delta
			 
		);
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_Kel atribute')
	);
	
	export Demo_All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build_Demo
		,output('No Valid version parameter passed, skipping Build_Base_Kel atribute')
	);
	export Delta_All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build_Delta
		,output('No Valid version parameter passed, skipping Build_Base_Kel atribute')
	);
end;
