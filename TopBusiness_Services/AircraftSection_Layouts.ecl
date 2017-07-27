import iesp,TopBusiness;

export AircraftSection_Layouts := module;

	export rec_OptionsLayout := record
		boolean lnbranded;
		boolean internal_testing;
	  string1 businessReportFetchLevel;
	end;
	
	export rec_input := record
		string25 acctno;
	  iesp.share.t_BusinessIdentity;
	end;	
	
	export rec_AircraftRecord := record		
		string25 acctno;
		iesp.share.t_BusinessIdentity;
		iesp.TopBusinessReport.t_topbusinessAircraft;		
	end;		
	
	export rec_party_layout := record
	   string30  serial_number;
		 string8  n_number;
		 string8  cert_issue_date;
		 string1  current_flag; 
		 string8  date_last_seen; // more populated than cert_issue_date and varies more
														 // than last_action_date
		string120 compname;
		string20 lname;
		string20 fname;
		string20 mname;
		string5 name_suffix;
		string5 title;
		iesp.share.t_Address address;
	end;
	
	export rec_layout := record
	  iesp.share.t_BusinessIdentity;	
		string2  source;
		string30 source_docid;
		string10 source_party;
		string8  aircraft_number; // may or may not need this depending if data team builds a new key
		                          //using serial_number -- or n_number.
		string30  serial_number;
		string1  current_prior_flag;  // either A - active H - historical for faa source		
		string8  date_last_seen; // more populated than cert_issue_date and varies more
		                       // than last_action_date
    string8  model_year; //  string8 	year_mfr; in data
		string20 model_name; // string20 model_name in data
		string8  registration_date;  // cert_issue_date in data
		string8  registration_number; // n_number					      	
		string13 	type_aircraft;
		integer   engines;
		string30 	aircraft_mfr_name;
		iesp.share.t_NameAndCompany registration_name;
		iesp.share.t_Address registration_address;	
  end;		
	
	export rec_AircraftParent := record	
		rec_layout;
		dataset(rec_party_layout) Prior_Parties { 
		              maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_AIRCRAFT_PARTY_RECORDS)};
		dataset(rec_party_layout) Current_Parties { 
		              maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_AIRCRAFT_PARTY_RECORDS)};
	end;
	
	export rec_linkids_plus_AircraftDetail := record
		iesp.share.t_businessIdentity;		
		string1   current_prior_flag;
		iesp.TopBusinessReport.t_TopbusinessAircraft;    
  end;		

	export rec_linkids_plus_AircraftRecord := record
	  string25  acctno;
		iesp.share.t_businessIdentity;
		iesp.TopBusinessReport.t_TopbusinessAircraftSummary;
	end;			
	
	export rec_final := record
	  string25 acctno;
		iesp.topbusinessReport.t_TopBusinessAircraftSection;		
	end;	
 end;