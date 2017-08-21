import address;
export Layouts :=
module

	export out :=
	module

		export Business_summary :=
		record
			string12		bdid;
			string120 	company_name;
			string100		address_line_1;
			string100		mailing_address;
			string30		city;
			string2			state;
			string9			zip;
			string4			zip4;
			string10		phone;
			string1			bankruptcy_indicator;	
			string1			OB_indicator;
			string9			fein;
			string9			duns_number;
			string1			Dnb_record;
			string2			crlf := '\r\n';
		end;
	
		export Business_contacts :=
		record
			string12									bdid;
			string12 									did;
			Address.Layout_Clean_Name Contact_Name;
			string1										is_best_contact_name;
			string30									company_title;
			string10									phone;
			string100									address_line_1;
			string100									mailing_address;
			string30									city;
			string2										state;
			string5										zip;
			string4										zip4;
			string1										contact_address_same_as_business_address;
			string1										Dnb_record;	
			string2										crlf := '\r\n';
		end;
	
		export Liens_and_Judgements :=
		record
			string crap;
		end;
		
		export Crim_offender :=
		record
	string12	did;
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
	string2		crlf := '\r\n';
		end;
		
		export crim_offense :=
		record
	string12	did;
	string8		date_first_reported;
	string8		date_last_reported;
	string60	offender_key;
	string50	orig_offense_key;
	string2		state_of_origin;
	string2		vendor;
	string20	source_file;
	string50	off_name;
	string8		off_date;
	string20	off_code;
	string31	charge;
	string3		counts;
	string320	off_desc_1;
	string180	off_desc_2;
	string1		off_type;
	string2		off_level;
	string1		sor_off_victim_minor;
	string3		sor_off_victim_age;
	string10	sor_off_victim_gender;
	string30	sor_off_victim_relationship;
	string8		arrest_date;
	string20	arrest_off_code;
	string75	arrest_off_desc;
	string5		arrest_off_level;
	string20	arrest_off_statute;
	string70	arrest_statute_desc;
  string8   arrest_disp_date;
  string60  arrest_disp_desc;
	string10	le_agency_code;
	string50	le_agency_desc;
	string35	le_agency_case_number;
	string35	traffic_ticket_number;
	string35	case_number;
	string10	court_code;
	string40	court_desc;
	string30	court_final_plea;
	string20	court_off_code;
	string75	court_off_desc;
	string5		court_off_level;
	string20	court_statute;
	string70	court_statute_desc;
	string8		conv_date;
	string2		conv_county_code;
	string30	conv_county;
	string8		court_disp_date;
	string5		court_disp_code;
	string40	court_disp_desc;
	string8		sent_date;
	string3		sent_code;
	string5		sent_comp;
	string250	sent_desc_1;
	string120	sent_desc_2;
	string100	sent_desc_3;
	string100	sent_desc_4;
	string8		inc_adm_date;
	string60	fcra_offense_key;
	string1		fcra_conviction_flag;
	string1		fcra_traffic_flag;
	string8		fcra_date;
	string1		fcra_date_type;
	string8		conviction_override_date;
	string1		conviction_override_date_type;
	string2		offense_score;
	string2		crlf := '\r\n';
		end;

		export uccs :=
		record
			string crap;
		end;

	end;

end;