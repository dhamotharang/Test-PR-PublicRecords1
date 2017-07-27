import address;

export Layouts :=
module

	shared max_size := _Dataset().max_record_size;

	export Input :=
	record, maxlength(max_size)
		string DATE     ;
		string ADDRESS  ;
		string SUFFIX   ;
		string CITY     ;
		string STATE   	;
		string ZIP_CODE ;
		string COMMENTS ;
	end;
	
	export Base :=
	record, maxlength(max_size)
		string8		dt_first_reported;
		string8		dt_last_reported;
		string 		ADDRESS;
		string 		SUFFIX;
		string 		CITY;
		string 		STATE;
		string 		ZIP_CODE;
		string 		COMMENTS;
		string10 	prim_range;
		string2 	predir;
		string28 	prim_name;
		string4 	addr_suffix;
		string2 	postdir;
		string10 	unit_desig;
		string8 	sec_range;
		string25 	p_city_name;
		string25 	v_city_name;
		string2 	st;
		string5 	zip;
		string4 	zip4;
		string4 	cart;
		string1 	cr_sort_sz;
		string4 	lot;
		string1 	lot_order;
		string2 	dpbc;
		string1 	chk_digit;
		string2 	record_type;
		string3 	county;
		string10 	geo_lat;
		string11 	geo_long;
		string4 	msa;
		string7 	geo_blk;
		string1 	geo_match;
		string4 	err_stat;
		unsigned8 	raw_aid;
		unsigned8 	ace_aid;
	end;

	export temporary :=
	module
	
		export StandardizeInput := 
		record, maxlength(max_size)
			unsigned8	unique_id;
			string100 	address1;
			string50	address2;
			Base;
		end;
		
		export UniqueId := 
		record, maxlength(max_size)
			unsigned8	unique_id;
			Base;
		end;

	end;

end;