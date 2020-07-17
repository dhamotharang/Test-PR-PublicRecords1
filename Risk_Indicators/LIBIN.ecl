﻿import Risk_Indicators;

export LIBIN := INTERFACE
  export unsigned1 dppa;
  export unsigned1 glb; 
  export boolean isUtility := false; 
  export boolean ln_branded; 
  export boolean ofac_only :=true;
  export boolean suppressNearDups :=false; 
  export boolean require2Ele :=false;
  export boolean from_BIID := false; 
  export boolean isFCRA := false; 
  export boolean ExcludeWatchLists := false; 
  export boolean from_IT1O :=false;
  export unsigned1 ofac_version :=1;
  export boolean include_ofac := FALSE; 
  export boolean include_additional_watchlists :=false;
  export real global_watchlist_threshold :=.84;
  export integer2 dob_radius := -1; 
  export unsigned1 BSversion:=1;
  export boolean runSSNCodes:=true;
  export boolean runBestAddrCheck:=true;
  export boolean runChronoPhoneLookup :=true;
  export boolean runAreaCodeSplitSearch :=true;
  export boolean allowCellphones :=false;
  export string10 ExactMatchLevel := Risk_Indicators.iid_constants.default_ExactMatchLevel;
  export string50 DataRestriction := Risk_Indicators.iid_constants.default_DataRestriction;
  export string10 CustomDataFilter :='';
  export boolean runDLverification :=false;
  export unsigned2 EverOccupant_PastMonths := 0;
  export unsigned4 EverOccupant_StartDate := 99999999;
  export unsigned1 append_best := 0;
  export unsigned8 BSOptions := 0;
  export unsigned3 LastSeenThreshold := Risk_Indicators.iid_constants.oneyear;
  export string20 companyID := '';
  export string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission;
  export boolean IncludeNAPData := false;
  export string100 IntendedPurpose := '';
  
  // CCPA parameters
  export unsigned1 iid_LexIdSourceOptout := 1;
  export string16 iid_TransactionID := '';
  export string16 iid_BatchUID := '';
  export unsigned6 iid_GlobalCompanyId := 0;
  
  /* Field for email verification added */
  export string5 IndustryClass := '';
END;
	
