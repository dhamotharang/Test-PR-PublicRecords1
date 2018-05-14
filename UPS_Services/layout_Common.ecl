﻿export layout_Common := RECORD
	UNSIGNED6 rollup_key;
	STRING7   rollup_key_type;  // a Constants.TAG_ROLLUP_KEY* value

	UNSIGNED4 dt_first_seen;
	UNSIGNED4 dt_last_seen;
	STRING10  phone;
	STRING25  fname;
	STRING25  mname;
	STRING25  lname;
	STRING120 company_name;
	STRING5   name_suffix;
	STRING10  prim_range;
	STRING2   predir;
	STRING28  prim_name;
	STRING4   suffix;
	STRING2   postdir;
	STRING10  unit_desig;
	STRING8   sec_range;
	STRING25  city_name;
	STRING2   state;
	STRING5   zip;
	string6   postalcode;
	STRING4   zip4;

	UNSIGNED2 score_name;
	UNSIGNED2 score_addr;
	// UNSIGNED2 score_addrStreet;
	// UNSIGNED2 score_addrCityStZip;
	UNSIGNED2 score_phone;
	STRING1   listing_type;
	string1	  history_flag;
END;
