import iesp;

export Constants := MODULE

		export max_names := iesp.Constants.BPS.ROLLUP_MAX_COUNT_NAMES;

		export max_ssns := iesp.Constants.BPS.ROLLUP_MAX_COUNT_SSNS;

		export max_dates := iesp.Constants.BPS.ROLLUP_MAX_COUNT_SSNS;
		
		export max_phones := iesp.Constants.BPS.ROLLUP_MAX_COUNT_PHONES;

		export max_rids := iesp.Constants.BPS.ROLLUP_MAX_COUNT_SOURCES;
		 
		export max_dls := iesp.Constants.BPS.ROLLUP_MAX_COUNT_DLS;

		export type_phones_plus := 3;  // phones plus data
		
		export MIN_LNAME := 4; //CheckSearchService requirement

		export string picklist_gateway_name := 'picklist';

    // bit mask informational codes for the picklist
    export PICKLIST_CODES := module
      export unsigned2 FCRA_RI := 1;
      // use 2, 4, 8, etc. for the future codes 
    end;
END;