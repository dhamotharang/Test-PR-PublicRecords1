IMPORT BairRx_Common, iesp;

EXPORT GetIDs(BairRx_Common.IParam.SearchParam inMod,boolean isRaids = false, boolean skipDates = true) := FUNCTION
	
		MC := inMod.ModeContext(mID=BairRx_Common.Constants.Mode.OFF)[1];
		DR := MC.data_relation;
		SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);	
		
		// special filter to handle agency name expressions
		AGF := BairRx_Common.AgencyFilter(MC.filters, inMod.AgencyDataOnly, inMod.AgencyORI);
		expFilter	:= AGF.GetFiltered();
		filterByAgency := AGF.IsActive();
		allowedORIs := AGF.GetAllowedSrcORI();
				
		
		// skip mode set to disable other modes when going through geo hash fetch.
		GH := BairRx_Common.GetGeoHash(inMod, MC, filterByAgency, allowedORIs);				
		GIDs := GH.geoIDs(skipDates, isRaids);
		GC := COUNT(GIDs);
		
		boolean booleanSearch := ~isRaids AND MC.filter_search AND GH.isGeoSpatialActive AND GC > 0;
		
		BoolEIDs := IF ((booleanSearch AND GC < BairRx_Common.Constants.Filter.MaxFocusDocs)
								,PROJECT(GIDs,TRANSFORM(iesp.share.t_StringArrayItem,SELF.value := LEFT.EID)));
								
		// boolean search only if filters are enabled.
		dBoolSrchRecs := IF(booleanSearch, BairRx_Common.BooleanFilterSearch(inMod, BairRx_Common.Constants.SearchType.Offender, expFilter, GH.SearchGrid, BoolEIDs, booleanSearch));				
				
		// geo hash filter in case of boolean searches to ensure first pass matches are truly within polygon/search radius.
		dIDs := IF(booleanSearch, GH.boolIDs(dBoolSrchRecs, SkipDates), GIDs);

		RETURN dIDs;

END;