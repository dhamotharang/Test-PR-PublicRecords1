IMPORT Risk_Indicators;

EXPORT ICommonInstantId := INTERFACE
  export boolean isUtility := FALSE; //?

  EXPORT boolean ofac_only := TRUE;
  EXPORT boolean suppressNearDups := FALSE;
  EXPORT boolean require2Ele := FALSE;
  EXPORT boolean from_BIID := FALSE;
  EXPORT boolean ExcludeWatchLists := FALSE;
  EXPORT boolean from_IT1O := FALSE;
  EXPORT unsigned1 ofac_version := 1;
  EXPORT boolean include_ofac := FALSE;
  EXPORT boolean include_additional_watchlists := FALSE;
  EXPORT real global_watchlist_threshold := .84;
  EXPORT integer2 dob_radius := -1;
  EXPORT unsigned1 BSversion := 1;
  EXPORT boolean runSSNCodes := FALSE;
  EXPORT boolean runBestAddrCheck := FALSE;
  EXPORT boolean runChronoPhoneLookup := FALSE;
  EXPORT boolean runAreaCodeSplitSearch := TRUE;
  EXPORT boolean allowCellphones := FALSE;
  EXPORT string10 ExactMatchLevel := Risk_Indicators.iid_constants.default_ExactMatchLevel;
  EXPORT string10 CustomDataFilter := '';
  EXPORT boolean runDLverification := FALSE;
  EXPORT unsigned2 EverOccupant_PastMonths := 0;
  EXPORT unsigned4 EverOccupant_StartDate := 99999999;
  EXPORT unsigned1 append_best := 0;
  EXPORT unsigned8 BSOptions := 0;
  EXPORT unsigned3 LastSeenThreshold := Risk_Indicators.iid_constants.oneyear;
  EXPORT string20 companyID := '';
  EXPORT boolean IncludeNAPData := FALSE;
  EXPORT string100 IntendedPurpose := '';
END;
