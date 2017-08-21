EXPORT rNameAddress := MODULE

	EXPORT rName := RECORD
		string73  name;
		string5 	name_prefix;
		string20 	name_first;
		string20 	name_middle;
		string20 	name_last;
		string5 	name_suffix;
		string3 	name_score;
	END;

	EXPORT rAddress := RECORD
		string182 address;
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
		string2 	ace_fips_st;
		string3 	fipscounty;
		string10 	geo_lat;
		string11 	geo_long;
		string4 	msa;
		string7 	geo_blk;
		string1 	geo_match;
		string4	 	err_stat;
	END;

END;