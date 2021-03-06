import bipv2_strata;

EXPORT layouts := module
	
	export slim_layout_v1 := record
		unsigned6 rcid;
		unsigned6 dotid;
		unsigned6 empid;
		unsigned6 powid;
		unsigned6 proxid;
		unsigned6 seleid;
		unsigned6 lgid3;
		unsigned6 orgid;
		unsigned6 ultid;
		string2   	source;
		unsigned4 	dt_first_seen;
		unsigned4 	dt_last_seen;
		string30   	company_name_status_raw;
		string8 company_sic_code1;
		string8 company_sic_code2;
		string8 company_sic_code3;
		string8 company_sic_code4;
		string8 company_sic_code5;
		string6 company_naics_code1;
		string6 company_naics_code2;
		string6 company_naics_code3;
		string6 company_naics_code4;
		string6 company_naics_code5;
		string50 company_status_derived;
		unsigned6 cnt_prox_per_lgid3;
	end;

  EXPORT laysegmentation := 
  record
      string10	idName      ;
      unsigned6 id          ;
      integer   reccnt      ;
      string2   core        ;		// TC = tri core, DC = Dual Core, TS = trusted source, SS := Single Trusted Source
      string2   emergingCore;	  // Trusted source singleton
      string2   inactive    ;		// RI - Reported as inactive, NA - Inactive due to no activity
  end;

  export stats_layout := record
    string20 segType;
    string20 segSubType;
    unsigned4 total;
  end;

  export layout_Businesses := BIPV2_Strata.layouts.layout_Businesses;

  export layout_demographics := BIPV2_Strata.layouts.layout_Demographics_Strata;
  
//  export fieldstats := recordof(fieldstats_org.active_fieldStats);  //should be same for each id here

end;