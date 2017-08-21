import address,BIPV2;

EXPORT layouts := MODULE

	
  	export base	:= RECORD
   		unsigned1   Prepped_rec_type:=0
   		,unsigned6 eid_hash:=0
   		,string23 eid:=''
   		,string50 data_provider_ori
   		,UNSIGNED2 data_provider_id
   		,STRING73 incident
   		,STRING crime
   		,STRING name_type
   		,STRING orig_address
   		,STRING50 orig_city
   		,STRING5 orig_st
   		,string10 orig_zip
   
   		,string100 orig_sid
   		,STRING27 vin
   		,STRING25 plate
   		,STRING30 plate_st
   		,STRING41 make
   		,STRING50 model
   		,STRING30 style
   		,STRING20 color
   		,string5	wd_make
   		,string50 wd_model
   		,string3	wd_color
   		,string2 wd_bodystyle
   		,string vehicle_type
   		,unsigned4 veh_id
   		,unsigned4 vehicleid
   		,STRING8 year
   		,string18  latitude
   		,string20  longitude
   		,STRING36 dl
   		,STRING24 dl_st
   		,string10  phone:=''
   		,unsigned4  dob:=0
   		,unsigned4  age:=0
			,unsigned4 clean_report_date
   		,string9  possible_ssn:=''
   		,STRING50 orig_officer
   		,STRING125 orig_name
   		,STRING100 orig_moniker
   		,STRING    orig_gender
   		,STRING3 name_hint
   		,STRING100 Prepped_name
   		// ,string		Phone_Parsed:=''
   		,STRING100 clean_company_name
   		,address.Layout_Clean_Name.title
   		,address.Layout_Clean_Name.fname
   		,address.Layout_Clean_Name.mname
   		,address.Layout_Clean_Name.lname
   		,address.Layout_Clean_Name.name_suffix
   		,STRING	Clean_gender
   		,Integer	class_code
   		,unsigned4 dt_first_seen:=0
   		,unsigned4 dt_last_seen:=0
   		,unsigned4 dt_vendor_first_reported:=0
   		,unsigned4 dt_vendor_last_reported:=0
   
   		,String60  Prepped_addr1:=''
   		,String35  Prepped_addr2:=''
   
   		,address.Layout_Clean182.prim_range
   		,address.Layout_Clean182.predir
   		,address.Layout_Clean182.prim_name
   		,address.Layout_Clean182.addr_suffix
   		,address.Layout_Clean182.postdir
   		,address.Layout_Clean182.unit_desig
   		,address.Layout_Clean182.sec_range
   		,address.Layout_Clean182.p_city_name
   		,address.Layout_Clean182.v_city_name
   		,address.Layout_Clean182.st
   		,address.Layout_Clean182.zip
   		,address.Layout_Clean182.zip4
   		,address.Layout_Clean182.cart
   		,address.Layout_Clean182.cr_sort_sz
   		,address.Layout_Clean182.lot
   		,address.Layout_Clean182.lot_order
   		,address.Layout_Clean182.dbpc
   		,address.Layout_Clean182.chk_digit
   		,address.Layout_Clean182.rec_type
   		,string2		fips_st:=''
   		,string3		county:=''
   		,address.Layout_Clean182.geo_lat
   		,address.Layout_Clean182.geo_long
   		,address.Layout_Clean182.msa
   		,address.Layout_Clean182.geo_blk
   		,address.Layout_Clean182.geo_match
   		,address.Layout_Clean182.err_stat
   		,unsigned1 Sequence := 0
   		,string75	 Search_Addr1
   		,string40	 Search_Addr2
   		,unsigned8 lexid:=0
   		,unsigned1 lexid_score:=0
   
   		,unsigned2 xadl2_Weight
   		,unsigned2 xadl2_Score 
   		,unsigned4 xadl2_keys_used // A bitmap of the keys used
   		,unsigned2 xadl2_distance 
   		,string20 xadl2_matches // Indicator of what fields contributed to the DID match.
   
   		,UNSIGNED6 bdid:=0
   		,UNSIGNED1 bdid_score := 0
   		,BIPV2.IDlayouts.l_xlink_ids
   	end;

	
	export Bair_Sequence_Flag := RECORD
		unsigned1 Sequence := 0;
	END;	
	
	export Phone_Parse := RECORD
		string23 eid:=''
		,string12 Phone := ''
		,Boolean	Iscurrent
	END;	
	
	Export veh_wd_hole := Record
		unsigned2 wd_MAKE_CODE;
		unsigned3 wd_MODEL_description;
		unsigned1 wd_COLOR_CODE;
		unsigned1 wd_state_code;
		unsigned3 wd_zip;
		unsigned2 wd_body_code;
		string23 	EID;
		unsigned4 wd_veh_id :=0;
		unsigned2 wd_YEAR_MAKE;	
		string25  wd_PLATE_NUMBER;
		string27  wd_VIN;
		string1   wd_gender;
		unsigned1 wd_years_since_1900;
		unsigned1 wd_orig_state;
		unsigned1 wd_person_source;
		
	End;
	

	Export Body_index := Record
		string2		wd_bodystyle;
		unsigned2	i;
		string50	body_style_desc;
		string20		category;
	end;
	
	Export Make_index := Record
	string5		wd_make;
	unsigned2	i;
	end;
	
	Export Model_index := Record
	string50	wd_model;
	unsigned3	i;
	end;
	
	END;

