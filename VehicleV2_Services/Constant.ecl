import iesp;
export Constant := module

	// Should these be in ut.limits?
	// Plus, we need to determine good values for these limits...
  export unsigned  VEHICLE_PENALT_THRESHOLD := 10;
	export unsigned2 MAX_CHILD_COUNT := 20;	
	export unsigned2 MAX_BRANDS_PER_VEHICLE := iesp.Constants.MV.MaxCountBrands;
	export unsigned2 PARTIES_PER_VEHICLE := 100;
	
	export unsigned2 VEHICLE_PER_KEY := 50;
	export unsigned2 VEHICLE_PER_DID  := 2000;
	export unsigned2 VEHICLE_PER_BDID := 2000;	
  export unsigned2 VEHICLE_PER_VIN := 2000;
  export unsigned2 VEHICLE_PER_TITLE := 50;
  export unsigned2 VEHICLE_PER_DL_NUMBER := 50;
  export unsigned2 VEHICLE_PER_LIC_PLATE := 10000;
  export unsigned2 VEHICLE_PER_BLUR_LICENSE := 1200; // 2016.04 actual count: SSSSSS -- 1052, ESSSSS -- 843, ...
  export unsigned2 VEHICLE_PER_MFD_ADDR := 10000;
	export unsigned2 VEHICLE_BATCH_LIMIT := 10000;

  // a limit on a number of VIN data records per VIN fragment; 
  // 2016.04: ~16,000 per first VIN 4 chars, ~5000 per first 6, ~5000 per first 8
  // the actual number of matches at a run-time will be indeed much smaller.
  EXPORT unsigned2 VINDATA_LIMIT := 5000;

	
	export string Realtime_val := 'REALTIME';
	export string Report_val := 'REPORT';
	export string All_val := 'ALL';
	export string Local_val := 'LOCAL';

	export string Realtime_val_out := 'RealTime';
	export string Local_val_out := 'Local';

	export unsigned1 VIN_VAL := 1;
	export unsigned1 LICPLATEANDSTATE_VAL := 2;
  export unsigned2 MAX_GATEWAY_RECORDS := 10000;
	export unsigned1 NAME_MATCH_MAX_VAL := 3;
	
	// list of states for local search 
	export SET OF String LOCAL_STATES_SEARCH := ['CO', 'DC', 'FL', 'IL', 'KY', 'LA', 'ME', 'MA', 'MI', 'MN', 'MS',
		'MO', 'MT', 'NE', 'NV', 'NY', 'NC', 'ND', 'OH', 'TN', 'TX', 'WI', 'WY'];
		
	/* List of POLK Permissible Use numbers that don't support surname + address searches */
	EXPORT SET OF STRING POLK_PERMISSIBLE_NOT_NAMEADDR := ['1P', '5', '6'];

	EXPORT EXP_SRCH := MODULE
		EXPORT STRING1 VIN_STANDARD := 'V';
		EXPORT STRING1 PLATE_ONLY := 'P';
		EXPORT STRING1 VIN_HOUSEHOLD := 'N';
		EXPORT STRING1 VIN_ONLY := 'Z';
		EXPORT STRING1 AUTHENTICATION := 'A';

		EXPORT STRING1 EXACT_VIN_MATCH := 'A';
		EXPORT STRING1 PLATE_MATCH := 'F';
		EXPORT STRING1 YEAR_MAKE_MODEL_MATCH := 'G';
		EXPORT STRING1 YEAR_MAKE_MATCH := 'J';
		EXPORT STRING1 PARTIAL_VIN_MATCH := 'H';
		EXPORT STRING1 PARTIAL_VIN_YEAR_MAKE_MODEL_MATCH := 'I';
		EXPORT STRING1 DEVELOPED_VEHICLE := 'D';
	END;

	/* List of experian gateway insurance usage states for gateway only search */
	// EXPORT GATEWAY_ONLY := SET(Codes.Key_Codes_V3(file_name='EXPERIAN_GATEWAY',field_name='INSURANCE_USAGE'),code);
	EXPORT UNSIGNED2 MAX_VEHS_PER_SRCH := 25;
	
	EXPORT HISTORY := MODULE
		EXPORT SET OF STRING CURRENT		:= ['','U'];
		EXPORT SET OF STRING EXPIRED		:= ['E','H','U'];
		EXPORT SET OF STRING HISTORICAL	:= ['E','H','U'];
		EXPORT SET OF STRING INCLUDEALL	:= ['','E','H','U'];
		EXPORT UNSIGNED1 USE_RECENT			:= 0; // CURRENT+EXPIRED
		EXPORT UNSIGNED1 USE_CURRENT		:= 1;
		EXPORT UNSIGNED1 USE_EXPIRED		:= 2;
		EXPORT UNSIGNED1 USE_HISTORICAL	:= 3;
		EXPORT UNSIGNED1 USE_ALL				:= 4;
	END;
end;