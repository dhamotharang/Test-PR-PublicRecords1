EXPORT layout_temp_offender :=  record
 
 hygenics_crim.layout_in_defendant;
 string40	 j_RecordID;
 string2	 j_StateCode;
 string1   name_type_hd;
 // string115 j_Name;
 // string50	 j_LastName;
 // string50	 j_FirstName;
 // string40	 j_MiddleName; 
 // string15	 j_Suffix;
 // string8	 j_DOB;
 
 // string20	 j_AddressType;
 // string150 j_Street;
 // string20	 j_Unit;
 // string50	 j_City;
 // string2	 j_State;
 // string9	 j_Zip;
 
 string5  	title;
 string20 	fname;
 string20 	mname;
 string20 	lname;
 string5  	name_suffix;
 string3  	cleaning_score;
	
 string10 	prim_range;
 string2  	predir;
 string28 	prim_name;
 string4  	addr_suffix;
 string2  	postdir;
 string10 	unit_desig;
 string8  	sec_range;
 string25 	p_city_name;
 string25 	v_city_name;
 string2 	  state;
 string5  	zip5;
 string4  	zip4;
 string4  	cart;
 string1  	cr_sort_sz;
 string4  	lot;
 string1  	lot_order;
 string2  	dpbc;
 string1  	chk_digit;
 string2  	rec_type;
 string2  	ace_fips_st;
 string3	  ace_fips_county;
 string10 	geo_lat;
 string11 	geo_long;
 string4  	msa;
 string7  	geo_blk;
 string1  	geo_match;
 string4  	err_stat;
 
 unsigned6 	did	:= 0;
 unsigned1 	did_score := 0;
 string9 	  ssn := '';
 string1    address_in_cache;
 string     street_address_1;
 string     street_address_2;
end;