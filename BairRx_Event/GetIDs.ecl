IMPORT BairRx_Common, iesp;

EXPORT GetIDs(BairRx_Common.IParam.SearchParam inMod, boolean eid_download = false, boolean map_view = false, boolean isRaids =false) := FUNCTION
	
		MC := inMod.ModeContext(mID=BairRx_Common.Constants.Mode.EVE)[1];
		DR := MC.data_relation;
		
		// special filter to handle agency name expressions
		AGF := BairRx_Common.AgencyFilter(MC.filters, inMod.AgencyDataOnly, inMod.AgencyORI);
		expFilter	:= AGF.GetFiltered();
		filterByAgency := AGF.IsActive();
		allowedORIs := AGF.GetAllowedSrcORI();
				
		GH 		:= BairRx_Common.GetGeoHash(inMod, MC, filterByAgency, allowedORIs);	
		GIDs 	:= GH.GeoIDs(FALSE,isRaids);
		GC 		:= COUNT(GIDs);
		
		boolean booleanSearch := ~isRaids AND (inMod.KeyWord != '' or AGF.IsBooleanActive()) AND GH.isGeoSpatialActive AND GC > 0;
		
		BoolEIDs := IF ((booleanSearch AND GC < BairRx_Common.Constants.Filter.MaxFocusDocs)
								,PROJECT(GIDs,TRANSFORM(iesp.share.t_StringArrayItem,SELF.value := LEFT.EID)));
								
		// boolean search only if filters are enabled.
		dBoolSrchRecs := IF(booleanSearch, BairRx_Common.BooleanFilterSearch(inMod,BairRx_Common.Constants.SearchType.Event,expFilter,GH.SearchGrid,BoolEIDs,booleanSearch));		
				
		// geo hash filter in case of boolean searches to ensure first pass matches are truly within polygon/search radius.
		dSrchIDs := IF(booleanSearch, GH.boolIDs(dBoolSrchRecs), GIDs);			
		
		dIDs := IF((eid_download OR map_view) and ~BairRx_Common.DataRelation.IsPrimaryView(DR), DEDUP(SORT(dSrchIDs,eid,stamp),eid), dSrchIDs);

		RETURN dIDs;

END;