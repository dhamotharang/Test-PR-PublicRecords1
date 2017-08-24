IMPORT BairRx_Common, BairRx_MapIncident, iesp, SALT32;

EXPORT GetClusterMetadata(DATASET(BairRx_Common.Layouts.SearchRec) GeoIDs, INTEGER inDepth, BOOLEAN ClusterByMode, BOOLEAN ClusterByClass) := FUNCTION

	// Slim layout for the records
	LPrepRec := RECORD									
	  STRING12 cluster;	
	  UNSIGNED1 depth;
	  STRING3 mode;
	  UNSIGNED2 class_code;
	  STRING50 class;
	  STRING12 gh12;	
	  STRING11 latitude;
	  STRING10 longitude;	
	END;
	
	// Derive Search depth level
	UNSIGNED1 cluster_depth := GeoIDs[1].depth; 
	UNSIGNED1 max_depth := MIN(inDepth, iesp.bair_constants.MAX_CLUSTER_DEPTH_LEVELS_TOGO);// Restricting max levels to go deep 
	
	// Prepare and slim down records at search level
	dIDs0 := PROJECT(GeoIDs, TRANSFORM(LPrepRec, 		
	  SELF.cluster := LEFT.gh12[1..cluster_depth],
	  SELF.depth := cluster_depth,
	  SELF.mode := LEFT.eid[1..3];
	  _classcode := BairRx_Common.ClassificationCode.MapClassCodeOut(BairRx_Common.EID.TypeFromString(LEFT.class[1..3]),LEFT.class[4..]);
	  SELF.class_code := _classcode,
	  SELF.class := BairRx_Common.ClassificationCode.GetClassification(_classcode); 
	  SELF := LEFT	
	));
	
	// Dig deeper and prepare records depending upon the 'Depth' parameter passed
	dIDs1 := NORMALIZE(dIDs0, max_depth, TRANSFORM(LPrepRec, _depth := LEFT.depth + COUNTER; SELF.cluster := LEFT.gh12[1.._depth], SELF.depth := _depth, SELF := LEFT));							
	dIDs  := dIDs0 + dIDs1;
	
	LCluster := RECORD
	  dIDs.cluster;
	  dIDs.depth;
	  dIDs.mode;
	  dIDs.class_code;
	  dIDs.class;
	  REAL4 latitude := AVE(GROUP,(REAL4)dIDs.latitude);
	  REAL4 longitude := AVE(GROUP,(REAL4)dIDs.longitude);
	  REAL4 min_latitude := 0; 
	  REAL4 max_latitude := 0; 
	  REAL4 min_longitude := 0; 
	  REAL4 max_longitude := 0; 
	  unsigned total := COUNT(GROUP);
	END;

	dClusterbyClass:= TABLE(dIDs, LCluster, cluster, depth, mode, class_code, class, FEW);		
	
	// Calculate counts at mode level	
 	LClusterModeTotals := RECORD
	  dIDs.cluster;
	  dIDs.depth;
	  dIDs.mode;
	  UNSIGNED2 class_code := 0;
	  STRING50 class := '';
	  REAL4 latitude := AVE(GROUP,(REAL4)dIDs.latitude);
	  REAL4 longitude := AVE(GROUP,(REAL4)dIDs.longitude);
	  REAL4 min_latitude := 0; 
	  REAL4 max_latitude := 0; 
	  REAL4 min_longitude := 0; 
	  REAL4 max_longitude := 0; 
	  UNSIGNED total := COUNT(GROUP);
	END;
		
	dClusterByMode := TABLE(dIDs, LClusterModeTotals, cluster, depth, mode, FEW);

	// Calculate counts at Aggregate(ALL) level	
	LClusterTotals := RECORD
	  dIDs.cluster;
	  dIDs.depth;
	  STRING3	mode := 'ALL';
	  UNSIGNED2 class_code := 0;
	  STRING50 class := '';
	  REAL4 latitude := AVE(GROUP,(REAL4)dIDs.latitude);
	  REAL4 longitude := AVE(GROUP,(REAL4)dIDs.longitude);
	  REAL4 min_latitude := 0; 
	  REAL4 max_latitude := 0; 
	  REAL4 min_longitude := 0; 
	  REAL4 max_longitude := 0; 
	  UNSIGNED total := COUNT(GROUP);
	END;
		
	dClusterTotals := TABLE(dIDs, LClusterTotals, cluster, depth, FEW);
	
	dCluster := dClusterTotals + IF(ClusterByMode, dClusterbyMode) + if(ClusterByClass, dClusterbyClass);

	dClusterMeta := PROJECT(dCluster,
	  TRANSFORM(iesp.bair_mapincident.t_BAIRClusterMetadata,
	    SELF.Cluster := LEFT.cluster,
	    SELF.Level := (STRING)LEFT.depth,
	    SELF.Mode := LEFT.mode,
	    SELF.ClassCode := (STRING)LEFT.class_code,
	    SELF.Class := LEFT.class,
	    SELF.Latitude := (STRING)LEFT.latitude,
	    SELF.Longitude := (STRING)LEFT.longitude,
	    SELF.MinLatitude := '';
	    SELF.MaxLatitude := ''; 
	    SELF.MinLongitude := ''; 
	    SELF.MaxLongitude := ''; 
	    SELF.Total := (STRING)LEFT.Total)
	  );

	// add the min/max lat/long to the records for the cluster geohash values
	iesp.bair_mapincident.t_BAIRClusterMetadata addGeoHashBounds(iesp.bair_mapincident.t_BAIRClusterMetadata l) := TRANSFORM
	  UNSIGNED1 cluster_depth := (UNSIGNED)l.level; 
	  box := SALT32.MOD_LL.Decode(l.cluster[1..cluster_depth]);
	  SELF.minlatitude 	:= (STRING)(box[1].latitude - box[1].latitude_err),
	  SELF.maxlatitude 	:= (STRING)(box[1].latitude + box[1].latitude_err),
	  SELF.minlongitude := (STRING)(box[1].longitude - box[1].longitude_err),
	  SELF.maxlongitude := (STRING)(box[1].longitude + box[1].longitude_err),
	  SELF := l
	END;
	
	dClusterMetaFinal := PROJECT(dClusterMeta, addGeoHashBounds(LEFT));
		
	RETURN SORT(dClusterMetaFinal, Level, Cluster, Mode, ClassCode);
	
END;


