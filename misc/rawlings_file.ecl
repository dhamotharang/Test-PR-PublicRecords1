layout_in := record
	string inp_FIRST_NAME;
	string inp_LAST_NAME;
	string inp_orig_SSN;
	string inp_orig_DOB;
	string inp_orig_CITY;
	string inp_orig_STATE_ABBR;
	string inp_orig_ZIP;
	string inp_orig_DATE_OF_LOSS;
	string inp_RAWLINGS_KEY;
	end;
in := dataset('~thor::temp::rawlings_file_ii_20100420',layout_in,csv(separator('\t')));


layout_clean := record
	layout_in;
	//
	string9 inp_ssn;
	string4 inp_ssn4;
	//
	string8 inp_DOB;
	string8 inp_DOL;
	//
	string5 inp_title;
	string20 inp_fname;
	string20 inp_mname;
	string20 inp_lname;
	string5	inp_name_suffix;
	//
	string10  inp_prim_range;
	string2   inp_predir;
	string28  inp_prim_name;
	string4   inp_addr_suffix;
	string2   inp_postdir;
	string10  inp_unit_desig;
	string8   inp_sec_range;
	string25  inp_p_city_name;
	string25  inp_v_city_name;
	string2   inp_state;
	string5   inp_zip5;
	string4   inp_zip4;
	string4   inp_cart;
	string1   inp_cr_sort_sz;
	string4   inp_lot;
	string1   inp_lot_order;
	string2   inp_dpbc;
	string1   inp_chk_digit;
	string2   inp_rec_type;
	string2   inp_ace_fips_st;
	string3   inp_county;
	string10  inp_geo_lat;
	string11  inp_geo_long;
	string4   inp_msa;
	string7   inp_geo_blk;
	string1   inp_geo_match;
	string4   inp_err_stat;
	//
	unsigned6 inp_did := 0;
	end;

export rawlings_file := dataset('~thor_200::temp::rawlings_dided_20100420',layout_clean,flat);
