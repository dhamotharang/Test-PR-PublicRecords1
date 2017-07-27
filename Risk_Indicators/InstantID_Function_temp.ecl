
export InstantID_Function_temp(DATASET(Layout_Input) indata, dataset(Layout_Gateways_In) gateways,
													unsigned1 dppa, unsigned1 glb, 
													boolean isUtility=false, boolean ln_branded, 
													unsigned3 history_date=999999, boolean ofac_only=true,
													BOOLEAN suppressNearDups=false, boolean require2Ele=false,
													boolean from_BIID = false, boolean isFCRA = false, boolean ExcludeWatchLists = false, boolean from_IT1O=false,
													unsigned1 ofac_version =1,boolean include_ofac = FALSE, boolean include_additional_watchlists =false,
													real global_watchlist_threshold =.84,integer2 dob_radius = -1, unsigned1 BSversion=1,
													boolean runSSNCodes=true, boolean runBestAddrCheck=true, boolean runChronoPhoneLookup=true,	boolean runAreaCodeSplitSearch=true,
													boolean allowCellphones=false, 
													string10 ExactMatchLevel=iid_constants.default_ExactMatchLevel,
													string50 DataRestriction=iid_constants.default_DataRestriction,
													string10 CustomDataFilter='') :=
FUNCTION

	base := Risk_Indicators.iid_base_function(indata, gateways, dppa, glb, isUtility, ln_branded, history_date, 
								ofac_only, suppressNearDups, require2ele, from_biid, isFCRA,  excludewatchlists, from_IT1O, 
								ofac_version, include_ofac, include_additional_watchlists, global_watchlist_threshold, dob_radius, bsversion,
								runSSNCodes, runBestAddrCheck, runChronoPhoneLookup, runAreaCodeSplitSearch,  // optimization options	
								allowCellphones, ExactMatchLevel, DataRestriction, CustomDataFilter);	
	return base;
	
END;

