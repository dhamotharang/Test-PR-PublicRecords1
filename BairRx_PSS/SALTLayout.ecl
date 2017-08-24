IMPORT Bair,Bair_ExternalLinkKeys;
EXPORT SALTLayout := MODULE

	EXPORT LayoutIn 	:= RECORD(Bair_ExternalLinkKeys.Process_PS_Layouts.InputLayout)
		BOOLEAN IncludeEvents;
		BOOLEAN IncludeCFS;
		BOOLEAN IncludeCrash;
		BOOLEAN IncludeOffenders;
		BOOLEAN IncludeLPR;
		STRING  AgencyORI;				
		STRING	addr_clean_error; // from address cleaner
		STRING4 zip4; // from address cleaner
	END;

	EXPORT LayoutOut := RECORD
		Bair.Layout_composite.eid;
		Bair.Layout_composite.eid_hash;		
		Bair.Layout_composite.lexid;
		Bair.Layout_composite.prepped_rec_type;
		Bair.Layout_composite.data_provider_id;
		Bair_ExternalLinkKeys.Process_PS_Layouts.OutputLayout.data_provider_ori; // not sure why, but not defined in Layout_Composite...
		// NAME
		Bair.Layout_composite.prepped_name;
		Bair.Layout_composite.title;
		Bair.Layout_composite.fname;
		Bair.Layout_composite.mname;
		Bair.Layout_composite.lname;
		Bair.Layout_composite.name_suffix;
		Bair.Layout_composite.clean_gender;
		Bair.Layout_composite.name_type;
		// ADDRESS	
		Bair.Layout_composite.prepped_addr1;
		Bair.Layout_composite.prepped_addr2;
		Bair.Layout_composite.prim_range;
		Bair.Layout_composite.predir;
		Bair.Layout_composite.prim_name;
		Bair.Layout_composite.addr_suffix;
		Bair.Layout_composite.postdir;
		Bair.Layout_composite.unit_desig;
		Bair.Layout_composite.sec_range;
		Bair.Layout_composite.p_city_name;		
		Bair.Layout_composite.st;
		Bair.Layout_composite.zip;
		Bair.Layout_composite.zip4;
		Bair.Layout_composite.county;		
		Bair.Layout_composite.latitude;
		Bair.Layout_composite.longitude;
		Bair.Layout_composite.dob;
		Bair.Layout_composite.dt_first_seen;
		Bair.Layout_composite.dt_last_seen;
		// VEHICLE
		Bair.Layout_composite.plate;
		Bair.Layout_composite.plate_st;
		Bair.Layout_composite.make;
		Bair.Layout_composite.model;
		Bair.Layout_composite.style;
		Bair.Layout_composite.year;
		Bair.Layout_composite.color;	
		UNSIGNED4 vehicleid;
		INTEGER2 Record_Score; // Score for this particular record
		Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch - [keys_used,keys_failed];		
		// match data
		INTEGER2 Match_NAME_SUFFIX;
		INTEGER2 Match_FNAME;
		INTEGER2 Match_MNAME;
		INTEGER2 Match_LNAME;
		INTEGER2 Match_PRIM_RANGE;
		INTEGER2 Match_PRIM_NAME;
		INTEGER2 Match_SEC_RANGE;
		INTEGER2 Match_P_CITY_NAME;
		INTEGER2 Match_ST;
		INTEGER2 Match_ZIP;
		INTEGER2 Match_DOB;
		INTEGER2 Match_PHONE;
		INTEGER2 Match_DL_ST;
		INTEGER2 Match_DL;
		INTEGER2 Match_LEXID;
		INTEGER2 Match_POSSIBLE_SSN;
		INTEGER2 Match_CRIME;
		INTEGER2 Match_NAME_TYPE;
		INTEGER2 Match_CLEAN_GENDER;
		INTEGER2 Match_CLASS_CODE;
		INTEGER2 Match_DT_FIRST_SEEN;
		INTEGER2 Match_DT_LAST_SEEN;
		INTEGER2 Match_DATA_PROVIDER_ORI;
		INTEGER2 Match_VIN;
		INTEGER2 Match_PLATE;
		INTEGER2 Match_LATITUDE;
		INTEGER2 Match_LONGITUDE;
		INTEGER2 Match_SEARCH_ADDR1;
		INTEGER2 Match_SEARCH_ADDR2;
		INTEGER2 Match_MAINNAME;
		INTEGER2 Match_FULLNAME;
		// delta
		UNSIGNED4 sequence; 				// coming from Bair_ExternalLinkKeys.MEOW_PS() but I have no idea where it's actually defined
		BOOLEAN FullMatch_Required; // If the input enquiry is insisting upon full record match
		BOOLEAN Has_Fullmatch; 			// This UID has a fully matching record
		BOOLEAN RecordsOnly; 				// If the input enquiry only wants matching records returned
		BOOLEAN Is_Fullmatch; 			// This record matches completely
		BOOLEAN person_match;
		BOOLEAN vehicle_match;
		BOOLEAN phone_match;
		BOOLEAN match; 
	END;
	
END;	