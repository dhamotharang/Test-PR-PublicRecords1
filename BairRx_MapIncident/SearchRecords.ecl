import BairRx_Common,BairRx_CFS,BairRx_Crash,BairRx_Event,BairRx_Intel,BairRx_LPR,BairRx_Offender,BairRx_Spotter,iesp;

EXPORT SearchRecords(BairRx_Common.IParam.SearchParam inMod, iesp.bair_mapincident.t_BAIRMapIncidentSearchOption options, integer max_records) := FUNCTION
	
	return_metadata := options.IncludeMetadata;								// Used by ATACRaids to display summary in metadata tab.
	eid_download := options.EIDDownload; 											// Used by ATACRaids to download a complete report. No incident information other than EID is returned.
	is_raids := options.Raids; 																// Used by RAIDS Online to access public domain data only.
	inc_details := options.IncludeIncidentDetails; 						// Option to return additional incident information.
	return_clustermetadata := options.IncludeClusterMetadata; // Used by ATACRaids to display pin Clusters in maps.
	cluster_depth := options.ClusterDepth; 										// Indicates number of levels we intend to go from the returned  GeoHash Level. 
	cluster_by_mode := options.ClusterByMode; 								// Used if we want to group cluster info by mode.
	cluster_by_class := options.ClusterByClass; 							// Used if we want to group cluster info by class.
		
	boolean skipOffenderDates := NOT options.ApplyOffenderDates;
	dIDs := BairRx_MapIncident.GetIDs(inMod, is_raids, eid_download, skipOffenderDates); 	
	
	// Apply group access restrictions - not needed if running a raids search.
	dCleanIDs := IF(is_raids, dIDs, BairRx_Common.GroupAccessControl.Clean(dIDs, inMod.AgencyORI));	
	
	getMod 	 := BairRx_MapIncident.GetModeRecs(inMod.ModeContext, inMod.DataProviderID, max_records, eid_download, is_raids, inc_details);
	dRecsEVE := getMod.GetEvents(dCleanIDs(BairRx_Common.EID.IsEvent(eid)));	
	dRecsCFS := getMod.GetCFS(dCleanIDs(BairRx_Common.EID.IsCFS(eid)));	
	dRecsCRA := getMod.GetCrash(dCleanIDs(BairRx_Common.EID.IsCrash(eid)));	
	dRecsLPR := getMod.GetLPR(dCleanIDs(BairRx_Common.EID.IsLPR(eid)));
	dRecsOFF := getMod.GetOffenders(dCleanIDs(BairRx_Common.EID.IsOffender(eid)));
	dRecsSPO := getMod.GetShotspotter(dCleanIDs(BairRx_Common.EID.IsShotSpotter(eid)));
	dRecsINT := getMod.GetIntel(dCleanIDs(BairRx_Common.EID.IsIntel(eid)));
	
	dSearchRecs := BairRx_MapIncident.PickTopRecords(dRecsEVE, dRecsCFS, dRecsCRA, dRecsLPR, dRecsOFF, dRecsSPO, dRecsINT, max_records);
	
	dRecsOut := IF(eid_download, 
		PROJECT(dSearchRecs, TRANSFORM(iesp.bair_mapincident.t_BAIRMapIncidentSearchRecord, SELF.EntityID := LEFT.eid, SELF := [])),
		PROJECT(dSearchRecs, BairRx_MapIncident.ESPOut.MapView(LEFT, inMod.CLatitude, inMod.CLongitude, inc_details,is_raids)));	
		
	dMetadata := BairRx_MapIncident.GetMetadata(dSearchRecs);
	dClusterMetadata := BairRx_MapIncident.GetClusterMetadata(dCleanIDs, cluster_depth, cluster_by_mode, cluster_by_class);
	
	BairRx_MapIncident.Layouts.SearchResults xtResults() := transform
		self.match_count := COUNT(dCleanIDs),
		self.records := dRecsOut;
		self.metadata := IF(return_metadata, dMetadata, DATASET([], iesp.bair_mapincident.t_BAIRMetadata));
		self.clustermetadata := IF(return_clustermetadata, CHOOSEN(dClusterMetadata,iesp.bair_constants.MAX_CLUSTER_METADATA_RESULTS)
																, DATASET([], iesp.bair_mapincident.t_BAIRClusterMetadata));
	end;
	dResults := dataset([xtResults()]);			
	
	BairRx_Common.GetGeoHash(inMod).Debug();
	return dResults;
	
end;