import BIPV2; 
export assorted_layouts := MODULE

	EXPORT lic_plate_key_payload_fields := RECORD
		string2 state_origin;
		string6 dph_lname;
		string20 pfname;
		boolean is_minor;
		string30 vehicle_key;
		string15 iteration_key;
		string15 sequence_key;
		boolean is_current;
		unsigned integer4 date;
		string8 orig_dob;
		string9 use_ssn;
		string20 fname;
		string20 lname;
		string20 mname;
		string2 predir;
		string28 prim_name;
		string10 prim_range;
		string4 addr_suffix;
		string2 postdir;
		string8 sec_range;
		string25 v_city_name;
		string5 zip5;
		string70 append_clean_cname;
		string1 state_type :='C';
 END;



	EXPORT standard__addr := RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 v_city_name;
   string2 st;
   string5 zip5;
   string4 zip4;
   string2 addr_rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 cbsa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
  END;

  EXPORT standard__name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

  export layout_common := RECORD
   string30 vehicle_key;
   string15 iteration_key;
   string15 sequence_key;
   unsigned integer1 zero;
	 unsigned4 lookup_bit;
	 string2	 Source_Code;
   unsigned integer6 append_did;
   unsigned integer6 append_bdid;
   string70 append_clean_cname;
   string9 append_ssn;
   string9 append_fein;
   standard__addr company_addr;
   standard__addr person_addr;
   standard__name person_name;
  string1 orig_name_type;
  string1 history;
  unsigned integer4 reg_latest_effective_date;
  unsigned integer4 reg_latest_expiration_date;
  unsigned integer4 ttl_latest_issue_date;
  END;
  
	export matched_party_rec := RECORD
   		string1 orig_name_type;	
	 // vehiclev2_services.Layout_Report_Party;
	 	string70		Orig_Name;
		VehicleV2_Services.layout_vehicle_party_out.layout_standard_name;
   		VehicleV2_Services.layout_vehicle_party_out.layout_standard_address;
	END;
	
  export layout_match_flags := RECORD
		string1 surnameFlag;
		string1 fullNameFlag;
		string1 addressMatchFlag;
	END;

  export layout_crim_indicators := RECORD
    boolean HasCriminalConviction := false;
    boolean IsSexualOffender := false;
  END;

	export layout_registrant := RECORD
		VehicleV2_Services.Layout_vehicle_party_out.layout_vehicle_party_registrant and not [append_did, append_bdid];
		string3 age;
		string12 append_did;
		string12 append_bdid;
		BIPV2.IDlayouts.l_header_ids;
		layout_match_flags matchFlags;
    	layout_crim_indicators;
		string10   geo_lat := '';
		string11   geo_long := '';
		string8 title_issue_date;
		string1 name_source_cd;
		string30 name_source;
		string17 title_number; 		// populated with data from ExperianVIN gateway	
		string30 reported_name;		// populated with data from ExperianVIN gateway	
	END;

	export layout_owner := RECORD
		VehicleV2_Services.Layout_vehicle_party_out.layout_vehicle_party_owner and not [append_did, append_bdid];
		string3 age;
		string12 append_did;
		string12 append_bdid;
		BIPV2.IDlayouts.l_header_ids;
		layout_match_flags matchFlags;
    layout_crim_indicators;
		string10   geo_lat := '';
		string11   geo_long := '';
		string30 reported_name;
	END;
	
	export layout_lienholder := RECORD
		VehicleV2_Services.Layout_vehicle_party_out.layout_vehicle_party_lienholder and not [append_did, append_bdid];
		string3 age;
		string12 append_did;
		string12 append_bdid;
		BIPV2.IDlayouts.l_header_ids;
		layout_match_flags matchFlags;
    layout_crim_indicators;
		string70 std_lienholder_name;
		string10   geo_lat := '';
		string11   geo_long := '';
		string1 name_source_cd;
		string30 name_source;
	END;
	
	export layout_lessee_or_lessor := RECORD
		VehicleV2_Services.Layout_vehicle_party_out.layout_vehicle_party_lessor and not [append_did, append_bdid];
		string3 age;
		string12 append_did;
		string12 append_bdid;
		BIPV2.IDlayouts.l_header_ids;
		layout_match_flags matchFlags;
    layout_crim_indicators;
		string10   geo_lat := '';
		string11   geo_long := '';
		string1 name_source_cd;
		string30 name_source;
	END;

	export layout_lessee := RECORD
		VehicleV2_Services.Layout_vehicle_party_out.layout_vehicle_party_lessee and not [append_did, append_bdid];
		string3 age;
		string12 append_did;
		string12 append_bdid;
		BIPV2.IDlayouts.l_header_ids;
		layout_match_flags matchFlags;
    layout_crim_indicators;
		string10   geo_lat := '';
		string11   geo_long := '';
	end;
	
	export layout_brand := RECORD		
		string10 brand_date;	
		string2 brand_state;
		string3 brand_code;
		string50 brand_type := '';				
	end;	
	
END;	
