EXPORT Layout_PPR_Extract := RECORD
	STRING12	ln_fares_id;
	STRING		sortby_date;
	STRING10	prim_range;
	STRING2		predir;	
	STRING28	prim_name;
	STRING4		suffix;
	STRING10	unit_desig;
	STRING8		sec_range;
	STRING2		postdir;
	STRING25	v_city_name;
	STRING2		st;
	STRING5		zip;
	STRING1		vendor_source_flag;
	STRING45	apna_or_pin_number;
	STRING2		duplicate_apn_multiple_address_id;
	STRING4		year_built;
	STRING4		standardized_land_use_code;
	STRING 		standardized_land_use_desc := '';
END;

