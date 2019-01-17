export BS_LIBIN := INTERFACE
	export unsigned1 bs_dppa;
	export unsigned1 bs_glb;
	export boolean bs_isUtility := false;
	export boolean bs_isLN := false;
	export boolean bs_require2Ele := false;

	// optimization options
	export boolean bs_includeRelativeInfo := true;
	export boolean bs_includeDLInfo := true;
	export boolean bs_includeVehInfo := true;
	export boolean bs_includeDerogInfo := true;
	
	export unsigned1 bs_BSversion := 1;
	export boolean	bs_IsPreScreen := false;
	export boolean bs_doScore := false;
	export boolean bs_ADL_Based_Shell := false;

	export boolean bs_OFAC_Only := TRUE;
	export boolean bs_SuppressNearDups := FALSE;
	export boolean bs_From_BIID := FALSE;
	export boolean bs_ExcludeWatchLists := FALSE;
	export boolean bs_From_IT1O := FALSE;
	export unsigned1 bs_OFAC_Version := 1;
	export boolean bs_Include_OFAC := FALSE;
	export boolean bs_Include_additional_watchlists := FALSE;
	export real bs_Global_watchlist_threshold := 0.84;

	export boolean bs_nugen :=  false;
	export boolean bs_filter_out_fares := false;
	export string50 bs_DataRestriction := risk_indicators.iid_constants.default_DataRestriction;
	export unsigned1 bs_AppendBest := 0;
	export unsigned8 bs_BSOptions := 0;
	export string50 bs_DataPermission := risk_indicators.iid_constants.default_DataPermission;
	export boolean IN_isDirectToConsumer := false;
	export boolean bs_IncludeLnJ := false;
  export integer2 bs_ReportingPeriod := 84;
  export string100 bs_IntendedPurpose := '';
END;