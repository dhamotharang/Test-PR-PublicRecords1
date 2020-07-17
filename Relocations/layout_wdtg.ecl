import dx_Gong;

export layout_wdtg := module

	// inherit types from current system
	shared base := dx_Gong.layouts.i_history_zip_name;

	// subset of base data needed for wdtg-specific keys
	export narrow := record
		// base.zip5;
		// base.p_name_first;

		base.listed_name;
		base.name_prefix;
		base.name_first;
		base.name_middle;
		base.name_last;
		base.name_suffix;

		// string1 listing_type_bus;
		// string1 listing_type_res;
		// string1 listing_type_gov;
		// string1 publish_code;
		// string3 prior_area_code;

		base.prim_range;
		base.predir;
		base.prim_name;
		base.suffix;
		base.postdir;
		base.unit_desig;
		base.sec_range;
		base.p_city_name;
		// string2 v_predir;
		// string28 v_prim_name;
		// string4 v_suffix;
		// string2 v_postdir;
		// string25 v_city_name;
		base.st;
		base.z5;
		base.z4;

		// string5 county_code;
		base.geo_lat;
		base.geo_long;
		// string4 msa;
		// string32 designation;
		// string254 caption_text;
		// string1 omit_address;
		// string1 omit_phone;
		// string1 omit_locality;
		// string64 see_also_text;

		base.did;
		// unsigned integer6 hhid;
		// unsigned integer6 bdid;

		base.phone10;
		base.dt_first_seen;
		base.dt_last_seen;
		base.current_record_flag;
		base.deletion_date;

		// unsigned integer2 disc_cnt6;
		// unsigned integer2 disc_cnt12;
		// unsigned integer2 disc_cnt18;
	end;

	// output layout of WDTG services
	export final := record
		base.dph_name_last;
		narrow;
		unsigned2 penalt := 0;
	end;

end;
