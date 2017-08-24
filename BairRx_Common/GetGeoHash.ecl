IMPORT SALT32,Bair,BairRx_Common,ut,iesp;

EXPORT GetGeoHash(BairRx_Common.IParam.SearchParam inMod, BairRx_Common.Layouts.ModeContext MC = ROW([],BairRx_Common.Layouts.ModeContext), boolean filterByAgency = false, SET OF STRING allowedORISet = []) := MODULE
	
	SHARED SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);	
	SHARED THISMODETYPE := MC.codes[1].etype; // grab mode type from codes, also as a way to make sure a set of class codes has been provided and the mode is indeed active. 
	
	SHARED searchByLayerID := inMod.layerid <>0 ;
	SHARED searchByPolygon := inMod.GeoSearchType = BairRx_Common.Constants.GeoSearchType.Polygon;
	SHARED searchByRadius := inMod.GeoSearchType = BairRx_Common.Constants.GeoSearchType.PointRadius;	
	SHARED searchByBox := inMod.GeoSearchType = BairRx_Common.Constants.GeoSearchType.Box;	
	
	SHARED REAL inClat := (REAL) inMod.CLatitude;
	SHARED REAL inClon := (REAL) inMod.CLongitude;
	SHARED REAL inRadius := inMod.Radius;

	//get polygon Text when layerid is provided
	
	iesp.bair_agencylayer.t_BAIRAgencyLayerSearchRecord eids() := TRANSFORM
		SELF.layerid := inmod.layerid;
		SELF.geotype := BairRx_Common.Constants.LAYER.WKTText;
	END;
	
	dlayereid := DATASET([eids()]);

	SHARED inPolygonText := if(searchByLayerID, BairRx_Common.GetLayerText(dlayereid)[1].GeoText, inMod.Polygon);
	SHARED inPolyDS	:= BairRx_Common.WKT.Polygon.fromWKT(inPolygonText);
	circleBBox 	:= BairRx_Common.WKT.BoundingBoxCircle(inClat, inClon, inRadius);
	polygonBBox := BairRx_Common.WKT.BoundingBoxPolygon(inPolygonText);
	boxBBox 		:= BairRx_Common.WKT.BoxAsPolygon(inMod.BoxMinY, inMod.BoxMinX, inMod.BoxMaxY, inMod.BoxMaxX);

	// determine the bounding box of the primary search area
	P_BBox 		:= MAP(searchByPolygon => polygonBBox, searchByRadius => circleBBox, boxBBox);
	P_BBoxDs 	:= BairRx_Common.WKT.Polygon.fromWKT(P_BBox);	
	SHARED P_BBOX_Coords := BairRx_Common.WKT.Polygon.MinXY_MaxXY(P_BBoxDs);

	SHARED REAL P_BBOX_MinX := P_BBOX_Coords[1];
	SHARED REAL P_BBOX_MinY := P_BBOX_Coords[2];
	SHARED REAL P_BBOX_MaxX := P_BBOX_Coords[3];
	SHARED REAL P_BBOX_MaxY := P_BBOX_Coords[4];

	SHARED boolean hasOuterBox := inMod.BoxMinX <> 0 OR inMod.BoxMinY <> 0 OR inMod.BoxMaxX <> 0 OR inMod.BoxMaxY <> 0;
	// disjoint when the inner box does not touch the outer box.
	SHARED boolean IsOuterBoxDisjoint := hasOuterBox AND (inMod.BoxMinX > P_BBOX_MaxX OR inMod.BoxMinY > P_BBOX_MaxY OR inMod.BoxMaxX < P_BBOX_MinX OR inMod.BoxMaxY < P_BBOX_MinY);
	// A buffer search is a point radius or polygon search within an outer box.	
	SHARED boolean IsBufferSearch := ~searchByBox AND hasOuterBox;
	// A disjoin buffer search should return no records. 
	SHARED boolean isBufferSearchDisjoint := IsBufferSearch AND IsOuterBoxDisjoint; 
	
	SHARED REAL Min2Real(REAL L, REAL R) := (REAL) if(l=0.0 or l>r and r<>0.0, r, l);
	// Min/max will be the intersection between the input box and either the circle or polygon bounding box.
	SHARED REAL intersectMinX := IF(IsOuterBoxDisjoint, P_BBOX_MinX, MAX(inMod.BoxMinX, P_BBOX_MinX));
	SHARED REAL intersectMinY := IF(IsOuterBoxDisjoint, P_BBOX_MinY, MAX(inMod.BoxMinY, P_BBOX_MinY));
	SHARED REAL intersectMaxX := IF(IsOuterBoxDisjoint, P_BBOX_MaxX, Min2Real(inMod.BoxMaxX, P_BBOX_MaxX));
	SHARED REAL intersectMaxY := IF(IsOuterBoxDisjoint, P_BBOX_MaxY, Min2Real(inMod.BoxMaxY, P_BBOX_MaxY));

	// If running a buffer search (box + circle or box + polygon), we need the bounding box of the intersection area.
	// If input box is not provided, min/max defaults to either circle or polygon bounding box.	
	SHARED REAL minX := IF(IsBufferSearch, intersectMinX, IF(searchByBox, inMod.BoxMinX, P_BBOX_MinX));
	SHARED REAL minY := IF(IsBufferSearch, intersectMinY, IF(searchByBox, inMod.BoxMinY, P_BBOX_MinY));
	SHARED REAL maxX := IF(IsBufferSearch, intersectMaxX, IF(searchByBox, inMod.BoxMaxX, P_BBOX_MaxX));
	SHARED REAL maxY := IF(IsBufferSearch, intersectMaxY, IF(searchByBox, inMod.BoxMaxY, P_BBOX_MaxY));
		
	TL := SALT32.MOD_LL.Encode(maxY, minX, 12);
	TR := SALT32.MOD_LL.Encode(maxY, maxX, 12);
	BL := SALT32.MOD_LL.Encode(minY, minX, 12);
	BR := SALT32.MOD_LL.Encode(minY, maxX, 12);	
	SHARED SGBox := SALT32.MOD_LL.Rectangle(TL, TR, BL, BR);

	GeoH 	:= SALT32.MOD_LL.Encode(inClat,inClon,12);
	SGPointRad := SALT32.MOD_LL.PointRadius(GeoH,inRadius);

	boolean checkDisjoint(REAL lminX, REAL lminY, REAL lmaxX, REAL lmaxY) := lmaxX<minX or lminX>maxX or lminY>maxY or lmaxY<minY;
	boolean checkInside(REAL lminX, REAL lminY, REAL lmaxX, REAL lmaxY) := lminX>minX and lmaxX<maxX and lmaxY<maxY and lminY>minY;

	// tl_latitude=maxY | tl_longitude=minX | br_latitude=minY | br_longitude=maxX			
	SGRadius := PROJECT(SGPointRad, TRANSFORM(BairRx_Common.Layouts.LayoutGeoSearchGrid,	
		SELF.overlap := MAP(																			
				~IsBufferSearch => LEFT.overlap, // not a buffer search, no change to overlap
				checkDisjoint(LEFT.tl_longitude, LEFT.br_latitude, LEFT.br_longitude, LEFT.tl_latitude) => SKIP,
				// must be inside the circle (overlap=1) and the intersection
				LEFT.overlap=1 AND checkInside(LEFT.tl_longitude, LEFT.br_latitude, LEFT.br_longitude, LEFT.tl_latitude) => 1,
				0); // border line
		SELF := LEFT));
		
	EXPORT SearchGrid	:= IF(~isBufferSearchDisjoint, IF(searchByRadius, SGRadius, SGBox), DATASET([],BairRx_Common.Layouts.LayoutGeoSearchGrid));
	
	SHARED sYYYYMM := (unsigned) inMod.StartDate[1..6];
	SHARED eYYYYMM := (unsigned) inMod.EndDate[1..6];

	SHARED sDate 	:= (unsigned) (inMod.StartDate+'000000000');
	SHARED eDate 	:= (unsigned) (inMod.EndDate+'999999999');	

	SHARED REAL inPlat := (REAL) inMod.PLatitude;
	SHARED REAL inPlon := (REAL) inMod.PLongitude;
	
	SHARED PickSortingField(recordof(Bair.Key_GeoHash()) R, unsigned fID) := CHOOSE(fID+1, 
			R.s0,  R.s1,  R.s2,  R.s3,  R.s4,  R.s5,  R.s6,  R.s7,  R.s8,  R.s9, 
			R.s10, R.s11, R.s12, R.s13, R.s14, R.s15, R.s16, R.s17, R.s18, R.s19,  
			R.s20, R.s21, R.s22, R.s23, R.s24, R.s25, R.s26, R.s27, R.s28, R.s29,  
			R.s30, R.s31, R.s32, R.s33, R.s34, R.s35, R.s36, R.s37, R.s38, R.s39,  
			R.s40, R.s41, R.s42, R.s43, R.s44, R.s45, R.s46, R.s47, R.s48, R.s49,  
			R.s50, R.s51, R.s52, R.s53, R.s54, R.s55, R.s56, R.s57, R.s58, R.s59,  
			R.s60, R.s61, R.s62, R.s63, R.s64, R.s65, R.s66, R.s67, R.s68, R.s69,  
			R.s70, R.s71, R.s72, R.s73, R.s74, R.s75, R.s76, R.s77, R.s78, R.s79,  
			R.s80, R.s81, R.s82, R.s83, R.s84, R.s85, R.s86, R.s87, R.s88, R.s89,  
			R.s90, R.s91, R.s92, R.s93, R.s94, R.s95, R.s96, R.s97, R.s98, R.s99,  
			R.s0);
	
	SHARED ccSet := MC.codes[1].codes;

	SHARED inBox(lat, lon) := macro 
			(
				((REAL) lon between minX and maxX)	and	
				((REAL) lat between minY and maxY)				
			)	
	endmacro;

	SHARED PolygonFilter(DATASET(BairRx_Common.Layouts.SearchRec) dInRecs) := FUNCTION
		
		InSeq := RECORD(BairRx_Common.Layouts.SearchRec)
			BairRx_Common.WKT.point_rec;
		END;
		dInRecsSeq		 := PROJECT(dInRecs, TRANSFORM(InSeq, SELF.lat := (REAL) LEFT.latitude,	SELF.lon := (REAL) LEFT.longitude, SELF.sequence := COUNTER, SELF := LEFT));		
		dInRecsChecked := BairRx_Common.WKT.Polygon.CheckPoints(inPolyDS, PROJECT(dInRecsSeq, TRANSFORM(BairRx_Common.WKT.point_rec, SELf := LEFT)));		
		dInRecsWithin	 := JOIN(dInRecsSeq, dInRecsChecked(belongs), LEFT.sequence = RIGHT.sequence, TRANSFORM(recordof(dInRecs), SELF := LEFT));
		
		RETURN dInRecsWithin;
		
	END;
					
	// A geo search is active as long as we have some coordinates *AND* not running a disjoint buffer search. 
	EXPORT boolean isGeoSpatialActive := (inClat<>0 AND inClon <> 0 AND inRadius > 0 OR (inMod.BoxMinX<>0 AND inMod.BoxMinY<>0 AND inMod.BoxMaxX<>0 AND inMod.BoxMaxY<>0) OR EXISTS(inPolyDS)) AND ~isBufferSearchDisjoint;
		
	SHARED GeoFetch(boolean fetchDelta, boolean skipDates = false, boolean isRaids = false) := FUNCTION
	
		geoDepth := LENGTH(TRIM(searchGrid[1].BOX));
		gh8BoxLen := geoDepth-4;
		isPrimaryView := BairRx_Common.DataRelation.IsPrimaryView(MC.data_relation);	
		
		dGeoIDs := JOIN(searchGrid, BairRx_Common.Keys.GeoHash(fetchDelta), 		
			KEYED(THISMODETYPE>0 // may not be needed? added as a precaution to avoid any unnecessary join in case of multiple modes in map search.
				AND (RIGHT.etype = THISMODETYPE)
				AND (RIGHT.class in ccSet)
				AND (LEFT.Box[1..4] = RIGHT.gh4)
				AND (skipDates OR (RIGHT.yyyymm >= sYYYYMM and RIGHT.yyyymm <= eYYYYMM))
				AND (~isRaids OR RIGHT.raids)
				)
			AND (gh8BoxLen < 1 OR LEFT.Box[5..] = RIGHT.gh8[1..gh8BoxLen])
			AND (skipDates OR (RIGHT.date >= sDate and RIGHT.date <= eDate))
			AND ((LEFT.Overlap = 1) OR inBox(RIGHT.latitude, RIGHT.longitude))
			AND (~searchByRadius OR (LEFT.Overlap = 1) OR (SALT32.MOD_LL.Distance((REAL)RIGHT.latitude,(REAL)RIGHT.longitude,inClat,inClon)<=inRadius))				
			AND (~isPrimaryView OR RIGHT.stamp=0)	
			AND (~inMod.AgencyDataOnly OR RIGHT.ori = inMod.AgencyORI)
		, TRANSFORM(BairRx_Common.Layouts.SearchRec, 
				SELF.gh12 := RIGHT.gh4+RIGHT.gh8,
				SELF.slim_sort := PickSortingField(RIGHT, SC.fID),
				SELF.distance := IF(SC.sort_by_distance, SALT32.MOD_LL.Distance((REAL)RIGHT.latitude,(REAL)RIGHT.longitude,inPlat,inPlon)*BairRx_Common.Constants.REAL_TO_INT_SCALE, 0), 				
				SELF.delta := fetchDelta,
				SELF.ori := IF(~filterByAgency OR RIGHT.ORI in allowedORISet, RIGHT.ori, SKIP),	
				SELF.depth := geoDepth,
				SELF := RIGHT) 
		, LIMIT(0));
				
		// no longer guaranteeing the sorting order if more than MAX_GEOHASH records. so just CHOOSEN() should suffice.
		dFetchIDs := CHOOSEN(dGeoIDs, BairRx_Common.Constants.MAX_GEOHASH);

		RETURN dFetchIDs;
	END;
	
	EXPORT geoIDs(boolean skipDates = false, boolean isRaids = false) := FUNCTION
		 		
		dMainIDs 	:= IF(~inMod.ExcludeMainRecs, GeoFetch(false, skipDates,isRaids), DATASET([],BairRx_Common.Layouts.SearchRec));
		dDeltaIDs := IF(~inMod.ExcludeDeltaRecs, GeoFetch(true, skipDates,isRaids), DATASET([],BairRx_Common.Layouts.SearchRec));	
		dMainOnly := JOIN(dMainIDs, dDeltaIDs, left.eid = right.eid, LEFT ONLY);
		dFetchIDs := dMainOnly + dDeltaIDs;
		dIDs			:= IF(searchByPolygon, PolygonFilter(dFetchIDs(searchByPolygon)), dFetchIDs);
		return IF(isGeoSpatialActive and exists(ccSet) and (skipDates OR (sDate>0 and eDate>0)) and (inMod.GeoSearchType <> BairRx_Common.Constants.GeoSearchType.None), dIDs);
	
	END;
	
	SHARED BoolGeoFetch(DATASET(BairRx_Common.Layouts.SearchRec) inIds, boolean fetchDelta, boolean skipDates = false, boolean isRaids = false) := FUNCTION
		
		geoDepth := LENGTH(TRIM(searchGrid[1].BOX));
		isPrimaryView := BairRx_Common.DataRelation.IsPrimaryView(MC.data_relation);	
		
		// this join is here temporarily. to be replaced with a merge/step join later on...		
		dGeoIDs := JOIN(inIds, BairRx_Common.Keys.GeoHash(fetchDelta), 		
			KEYED(THISMODETYPE>0
				AND	RIGHT.etype = THISMODETYPE
				AND RIGHT.class in ccSet
				AND LEFT.gh12[1..4] = RIGHT.gh4
				AND (skipDates OR (RIGHT.yyyymm >= sYYYYMM and RIGHT.yyyymm <= eYYYYMM))
				AND (~isRaids OR RIGHT.raids)
				AND RIGHT.eid = LEFT.eid
				)
			AND inBox(RIGHT.latitude, RIGHT.longitude)
			AND (~searchByRadius OR (SALT32.MOD_LL.Distance((REAL)RIGHT.latitude,(REAL)RIGHT.longitude,inClat,inClon)<=inRadius))				
			AND (~isPrimaryView OR RIGHT.stamp=0)
			AND (~inMod.AgencyDataOnly OR RIGHT.ori = inMod.AgencyORI)
		, TRANSFORM(BairRx_Common.Layouts.SearchRec, 
				SELF.gh12 := RIGHT.gh4+RIGHT.gh8,
				SELF.slim_sort := PickSortingField(RIGHT, SC.fID),
				SELF.distance := IF(SC.sort_by_distance, SALT32.MOD_LL.Distance((REAL)RIGHT.latitude,(REAL)RIGHT.longitude,inPlat,inPlon)*BairRx_Common.Constants.REAL_TO_INT_SCALE, 0), 	
				SELF.delta := fetchDelta,
				SELF.ori := IF(~filterByAgency OR RIGHT.ORI in allowedORISet, RIGHT.ori, SKIP),
				SELF.depth := geoDepth,
				SELF := RIGHT) 
		, LIMIT(0));
				
		dBoolFetchIDs := CHOOSEN(dGeoIDs, BairRx_Common.Constants.MAX_GEOHASH);
		
		RETURN dBoolFetchIDs;
	END;
	
	EXPORT boolIDs(DATASET(BairRx_Common.Layouts.SearchRec) inIds, boolean skipDates = false, boolean isRaids = false) := FUNCTION		
		
		dMainIDs := IF(~inMod.ExcludeMainRecs, BoolGeoFetch(inIds, false, skipDates, isRaids), DATASET([],BairRx_Common.Layouts.SearchRec));
		dDeltaIDs := IF(~inMod.ExcludeDeltaRecs, BoolGeoFetch(inIds, true, skipDates, isRaids), DATASET([],BairRx_Common.Layouts.SearchRec));	
		dMainOnly := JOIN(dMainIDs, dDeltaIDs, left.eid = right.eid, LEFT ONLY);
		dBoolFetchIDs := dMainOnly + dDeltaIDs;
		dIDs := IF(searchByPolygon, PolygonFilter(dBoolFetchIDs(searchByPolygon)), dBoolFetchIDs);
		RETURN IF(isGeoSpatialActive, dIDs);
		
	END;
	
	EXPORT Debug() := FUNCTION		
		geoDBG := false : STORED('GEODBG');
		dbgPriBBox := BairRx_Common.WKT.BoxAsPolygon(P_BBOX_MinY, P_BBOX_MinX, P_BBOX_MaxY, P_BBOX_MaxX);
		dbgComBBox := MAP(
						IsBufferSearch => BairRx_Common.WKT.PointBoxesAsMultiPolygon(inClat, inClon, inMod.BoxMinY,inMod.BoxMinX,inMod.BoxMaxY,inMod.BoxMaxX,P_BBOX_MinY, P_BBOX_MinX, P_BBOX_MaxY, P_BBOX_MaxX),
						searchByRadius => BairRx_Common.WKT.PointBoxAsMultiPolygon(inClat, inClon, minY, minX, maxY, maxX),
						BairRx_Common.WKT.BoxAsPolygon(minY, minX, maxY, maxX)
						);
		dbgL := { boolean geoactive; integer searchType; integer grid_len; integer grid_sz; REAL minX; REAL minY; REAL maxX; REAL maxY; REAL clat; REAL clon; REAL radius; REAL plat; REAL plon; STRING polygon; boolean buffersearch; boolean outerbox; boolean disjoinouterbox; STRING pri_bbox; STRING combo_bbox;};
		dbgR := IF(geoDBG, DATASET([{isGeoSpatialActive, inMod.GeoSearchType, LENGTH(searchGrid[1].Box), count(searchGrid), minX, minY, maxX, maxY, inClat, inClon, inRadius, inPlat, inPlon, inMod.Polygon, IsBufferSearch, hasOuterBox, IsOuterBoxDisjoint, dbgPriBBox, dbgComBBox}], dbgL),DATASET([], dbgL));		
		RETURN output (dbgR, named('GeoDebug'), EXTEND);
	END;
	
END;