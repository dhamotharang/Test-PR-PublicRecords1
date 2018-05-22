EXPORT Layout_Deact_GH := module

//History
	export History := RECORD
		string7 p7;
		string3 p3;
		string2 st;
		boolean current_flag;
		boolean business_flag;
		string2 src;
		string1 listing_type_bus;
		string1 listing_type_res;
		string1 listing_type_gov;
		string1 publish_code;
		string3 prior_area_code;
		string10 phone10;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string2 v_predir;
		string28 v_prim_name;
		string4 v_suffix;
		string2 v_postdir;
		string25 v_city_name;
		string5 z5;
		string4 z4;
		string5 county_code;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string32 designation;
		string5 name_prefix;
		string20 name_first;
		string20 name_middle;
		string20 name_last;
		string5 name_suffix;
		string120 listed_name;
		string254 caption_text;
		string1 omit_address;
		string1 omit_phone;
		string1 omit_locality;
		string64 see_also_text;
		unsigned6 did;
		unsigned6 hhid;
		unsigned6 bdid;
		string8 dt_first_seen;
		string8 dt_last_seen;
		string1 current_record_flag;
		string8 deletion_date;
		unsigned2 disc_cnt6;
		unsigned2 disc_cnt12;
		unsigned2 disc_cnt18;
		unsigned8 persistent_record_id;
		string7 phone7;
		string3 area_code;
		string address1;
  end;
	
//Base	
	export Temp := record
		unsigned  groupid			:= 0;
		unsigned8	vendor_first_reported_dt;
		unsigned8	vendor_last_reported_dt;
		string2 		action_code;
		string14		timestamp;
		string10		phone;
		string10  phone_swap;
		string255 filename;
		string60 	carrier_name;
		string 			filedate;
		unsigned8	swap_start_dt		:= 0;
		unsigned8	swap_end_dt			:= 0;
		string2			deact_code;
		unsigned8	deact_start_dt 	:= 0;
		unsigned8	deact_end_dt		:= 0;
		unsigned8	react_start_dt	:= 0;
		unsigned8	react_end_dt		:= 0;
		string2			is_react				:= '';
		string2			is_deact				:= '';
		unsigned8 porting_dt; 
		string 			pk_carrier_name;
		integer 		days_apart;
	end;

//Base Temp	
	export Temp2 := record
		Temp;
		integer did;
		integer bdid;
		integer addID;
	end;

end;