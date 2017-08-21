IMPORT Address, BIPV2;

EXPORT Layouts := MODULE

  EXPORT Input := RECORD
		STRING12  occupation_id;
		STRING15  first_name;
		STRING15  middle_name;
		STRING20  last_name;
		STRING4   suffix;
		STRING40  address;
		STRING10  prim_range;
		STRING2   predir;
		STRING28  prim_name;
		STRING4   addr_suffix;
		STRING2   postdir;
		STRING4   unit_type;
		STRING8   unit_number;
		STRING28  city;
		STRING2   state;
		STRING5   zip;
		STRING4   zip4;
		STRING3   bar;
		STRING2   ace_rec_type;
		STRING4   cart;
		STRING2   census_state_code;  //fips_state
		STRING3   census_county_code; //fips_county
		STRING5   county_code_desc;
		STRING6   census_tract;
		STRING1   census_block_group; //geo_blk
		STRING1   match_code;         //geo_match
		STRING9   latitude;           //geo_lat... different length
		STRING9   longitude;          //geo_long... different length
		STRING2   mail_score;
		STRING1   residential_business_ind;
		STRING30  employer_name;
		STRING12  family_id;
		STRING12  individual_id;
		STRING9   abi_number;
		STRING50  industry_title;
		STRING50  occupation_title;
		STRING50  specialty_title;
		STRING6   sic_code;
		STRING2   naics_group;
		STRING2   license_state;
		STRING12  license_id;
		STRING25  license_number;
		STRING8   exp_date;
		STRING1   status_code;
		STRING8   effective_date;
		STRING8   add_date;
		STRING8   change_date;
		STRING4   year_licensed;      // year issued
		STRING1   carriage_return;
	END;

  EXPORT Base := RECORD
	  Input - [carriage_return];
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;

		// clean/description fields
		STRING8   clean_effective_date;
		STRING8   clean_exp_date;
		STRING8   clean_add_date;
		STRING8   clean_change_date;
		STRING4   clean_year_licensed;
		STRING30  status_code_desc;
		
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED8 lnpid;
		Address.Layout_Clean182_fips clean_address;
		Address.Layout_Clean_Name    clean_name;
		BIPV2.IDlayouts.l_xlink_ids;
		STRING    src;
		UNSIGNED8 source_rec_id;
  END;

END;
