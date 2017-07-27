/* Parameters to be passed into scoring products. All parameters should:
	- Be appropriately forward-looking (eg, boca shell version 255 errs on the side of inefficient rather than incorrect)
	- Have default values:
		- Reasonable permissive defaults (eg, least permissive GLB/DPPA)
		- Most probable option (given what future products are expected to use)
		- Efficient enabling/disabling in the absense of a clear choice
*/
import gateway;

export Scoring_Parameters := INTERFACE
	export unsigned1 DPPA                                       := 0;
	export unsigned1 GLB                                        := 8;
	export boolean   isUtility                                  := false;
	export boolean   ln_branded                                 := false;
	export boolean   ofac_only                                  := true;
	export boolean   suppressNearDups                           := false;
	export boolean   require2Ele                                := false;
	export boolean   from_BIID                                  := false;
	export boolean   isFCRA                                     := false;
	export boolean   ExcludeWatchLists                          := false;
	export boolean   from_IT1O                                  := false;
	export unsigned1 ofac_version                               := 1;
	export boolean   include_ofac                               := FALSE;
	export boolean   include_additional_watchlists              := false;
	export real      global_watchlist_threshold                 := 0.84;
	export integer2  dob_radius                                 := -1;
	export unsigned1 BSversion                                  := 255;
	export boolean   runSSNCodes                                := true;
	export boolean   runBestAddrCheck                           := true;
	export boolean   runChronoPhoneLookup                       := true;
	export boolean   runAreaCodeSplitSearch                     := true;
	export boolean   allowCellphones                            := false;
	export string10  ExactMatchLevel                            := iid_constants.default_ExactMatchLevel;
	export string50  DataRestriction                            := iid_constants.default_DataRestriction;
	export string10  CustomDataFilter                           := '';
	export boolean   runDLverification                          := false;
	export boolean   includeRelativeInfo                        := false;
	export boolean   includeDLInfo                              := false;
	export boolean   includeVehInfo                             := false;
	export boolean   includeDerogInfo                           := false;
	export boolean   NugenReasons                               := true; // IID 'nugen' only affects reason codes; this name is slightly more obvious
	export boolean   includeGong                                := false;
	export boolean   RemoveFares                                := false;
	export boolean   DoScore                                    := false;
	export boolean   ADL_Based_Shell                            := false;
	export dataset(Gateway.Layouts.Config) gateways 						:= Gateway.Constants.void_gateway;
	export unsigned1 AppendBest																	:= 0;
	export string50  DataPermission                            	:= iid_constants.default_DataPermission;
END;