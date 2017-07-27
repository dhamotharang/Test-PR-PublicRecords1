export Layout_FCRA_Offender := record
	string8		date_first_reported;
	string8		date_last_reported;
	string60	offender_key;
	string2		vendor;
	string2		state_of_origin;
	string1		data_type;
	string20	source_file;
	string1		off_name_type;
	string50	off_name;
	string20	orig_lname;
	string20	orig_fname;
	string20	orig_mname;
	string10	orig_name_suffix;
	string2		place_of_birth;
	string8		dob;
	string8		dob_alias;
	string9		orig_ssn;
	string20	offender_id_num_1;
	string10	offender_id_num_type_1;
	string20	offender_id_num_2;
	string10	offender_id_num_type_2;
	string8		sor_date_1;
	string28	sor_date_type_1;
	string8		sor_date_2;
	string28	sor_date_type_2;
	string8		sor_date_3;
	string28	sor_date_type_3;
	string50	sor_status;
	string20	sor_offender_category;
	string10	sor_risk_level_code;
	string50	sor_risk_level_desc;
	string25	sor_registration_type;
	string60	offender_status;
	string125	offender_address_1;
	string35	offender_address_2;
	string35	offender_address_3;
	string35	offender_address_4;
	string35	offender_address_5;
	string35	case_number;
	string40	case_court;
	string50	case_name;
	string5		case_type;
	string25	case_type_desc;
	string8		case_filing_date;
	string30	race_desc;
	string10	sex;
	string40	hair_color_desc;
	string40	eye_color_desc;
	string20	skin_color_desc;
	string3		height;
	string3		weight;
	string30	ethnicity;
	string3		age;
	string30	build_type;
	string200	scars_marks_tattoos;
	string1		fcra_conviction_flag;
	string1		fcra_traffic_flag;
	string8		fcra_date;
	string1		fcra_date_type;
	string8		conviction_override_date;
	string1		conviction_override_date_type;
	string2		offense_score;
	string10	prim_range;
	string2		predir;
	string28	prim_name;
	string4		addr_suffix;
	string2		postdir;
	string10	unit_desig;
	string8		sec_range;
	string25	p_city_name;
	string25	v_city_name;
	string2		state;
	string5		zip5;
	string4		zip4;
	string4		cart;
	string1		cr_sort_sz;
	string4		lot;
	string1		lot_order;
	string2		dpbc;
	string1		chk_digit;
	string2		rec_type;
	string2		ace_fips_st;
	string3		ace_fips_county;
	string10	geo_lat;
	string11	geo_long;
	string4		msa;
	string7		geo_blk;
	string1		geo_match;
	string4		err_stat;
	string5		title;
	string20	fname;
	string20	mname;
	string20	lname;
	string5		name_suffix;
	string3		cleaning_score;
	string9		ssn;
end;