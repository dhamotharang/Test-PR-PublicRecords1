IMPORT iesp,BairRx_Common;


EXPORT GetLayerGroup($.IParam.SearchParam inMod) := FUNCTION

	GH 		:= $.GetGeoHash(inMod);	
	SearchIDs 	:= GH.SearchGrid;

	GroupLayerkey := $.Keys.LayerSearchKey();
	
	dSearchIDS_GH4 := PROJECT (SearchIDs,TRANSFORM($.Layouts.LayoutGeoSearchGrid,SELF.Box := LEFT.Box[1..4],self:=[]));
	
	dIDs := DEDUP(SORT(dSearchIDS_GH4,Box),Box) ;
	
	
	dLayerInfo := JOIN(dIDs,GroupLayerkey, 
												KEYED(LEFT.Box = RIGHT.GH4),
												TRANSFORM(RIGHT), 
												LIMIT(0), KEEP($.Constants.MAX_PAYLOAD));
												
	Layerrec := RECORD	
		UNSIGNED4 data_provider_id;
		STRING70 agencyname;
		UNSIGNED6 layergroupid;
		STRING30 layergroupname;
		UNSIGNED6 layerid;
		STRING20 layername;
	END;
	
	
	rec_grouplayerinfo := RECORD
		Layerrec.data_provider_id;
		Layerrec.agencyname;
		iesp.Bair_Agencylayer.t_BAIRAgencyLayerGroup;
	END;
	
	dLayerInfoSorted := SORT(PROJECT(dLayerInfo,Layerrec),data_provider_id,LayerGroupID);
	
	
	rec_grouplayerinfo GroupLayerInfo(Layerrec L, DATASET(Layerrec) AllnewLayerGroups) := TRANSFORM
		SELF.data_provider_id := L.data_provider_id;
		SELF.AgencyName  := L.AgencyName;
		SELF.LayerGroupId  := L.LayerGroupID;
		SELF.LayerGroupName := L.LayerGroupName;
		SELF.Layers := DEDUP(SORT(PROJECT(AllnewLayerGroups,TRANSFORM(iesp.Bair_Agencylayer.t_BAIRAgencyLayerInfo,
															SELF.LayerId  := LEFT.LayerID;
															SELF.LayerName := LEFT.LayerName)),
													LayerId,LayerName),LayerId,LayerName);	
	END;

	dLayerinfoGrouped := ROLLUP(GROUP(dLayerInfoSorted,data_provider_id,LayerGroupId),GROUP,GroupLayerInfo(LEFT,ROWS(LEFT)));	
	
	
	
	iesp.Bair_Agencylayer.t_BAIRAgencyLayerGroupRecord xtresults(rec_grouplayerinfo L, DATASET(rec_grouplayerinfo) AllLayerGroups)  := TRANSFORM
		SELF.AgencyID := L.data_provider_id;
		SELF.AgencyName  := L.AgencyName;
		SELF.LayerGroups  := DEDUP(SORT(PROJECT(AllLayerGroups, TRANSFORM(iesp.Bair_Agencylayer.t_BAIRAgencyLayerGroup, 
																	SELF.LayerGroupId  := LEFT.LayerGroupID;
																	SELF.LayerGroupName := LEFT.LayerGroupName;
																	SELF.Layers := LEFT.Layers)),
															LayerGroupId,LayerGroupName),LayerGroupId,LayerGroupName);
	
	END;
		
	results := ROLLUP(GROUP(dLayerinfoGrouped,data_provider_id),GROUP,xtresults(LEFT,ROWS(LEFT)));

	RETURN  results;
END;
