export Layout_Common_Crim_Offender2
 := module
 export new := 
  record
    string8        process_date;
	string8		   file_date:= '';	//new field
    string60       offender_key;
    string2        vendor;
    string2        state_origin;
    string1        data_type;
    string20       source_file;
    string35       case_number;
    string40       case_court;
    string50       case_name;
    string5        case_type;
    string25       case_type_desc;
    string8        case_filing_dt;
    string56       pty_nm;
    string1        pty_nm_fmt;
    string20       orig_lname;
    string20       orig_fname;
    string20       orig_mname;
    string10       orig_name_suffix;
    string1        pty_typ;
    string1        nitro_flag;
    string9        orig_ssn;
    string10       dle_num;
    string9        fbi_num;
    string10       doc_num;
    string10       ins_num;
    string15       id_num;
    string25       dl_num;
    string2        dl_state;
    string2        citizenship;
    string8        dob;
    string8        dob_alias;
	string13	   county_of_birth:= ''; 	// new field
    string2        place_of_birth;
    string25       street_address_1;
    string25       street_address_2;
    string25       street_address_3;
    string10       street_address_4;
    string10       street_address_5;
	string13	   current_residence_county:= ''; 	//new field
	string13	   legal_residence_county:= ''; 	//new field
    string5        race;
    string30       race_desc;
    string1        sex;
    string5        hair_color;
    string25       hair_color_desc;
    string5        eye_color;
    string25       eye_color_desc;
    string5        skin_color;
    string25       skin_color_desc;
	string10	   scars_marks_tattoos_1:= ''; //new field
	string10	   scars_marks_tattoos_2:= ''; //new field
	string10	   scars_marks_tattoos_3:= ''; //new field
	string10	   scars_marks_tattoos_4:= ''; //new field
	string10	   scars_marks_tattoos_5:= ''; //new field
    string3        height;
    string3        weight;
    string10       party_status;
    string60       party_status_desc;
	string10	   _3g_offender:= ''; 		//new field
	string10	   violent_offender:= ''; 	//new field
	string10	   sex_offender:= ''; 		//new field
	string10	   vop_offender:= ''; 		//new field
	string26	   record_setup_date:= ''; 	//new field
    string10       prim_range;
    string2        predir;
    string28       prim_name;
    string4        addr_suffix;
    string2        postdir;
    string10       unit_desig;
    string8        sec_range;
    string25       p_city_name;
    string25       v_city_name;
    string2        state;
    string5        zip5;
    string4        zip4;
    string4        cart;
    string1        cr_sort_sz;
    string4        lot;
    string1        lot_order;
    string2        dpbc;
    string1        chk_digit;
    string2        rec_type;
    string2        ace_fips_st;
    string3        ace_fips_county;
    string10       geo_lat;
    string11       geo_long;
    string4        msa;
    string7        geo_blk;
    string1        geo_match;
    string4        err_stat;
    string5        title;
    string20       fname;
    string20       mname;
    string20       lname;
    string5        name_suffix;
    string3        cleaning_score;
  end;
  export previous := 
  record
    string8        process_date;
    string60       offender_key;
    string2        vendor;
    string2        state_origin;
    string1        data_type;
    string20       source_file;
    string35       case_number;
    string40       case_court;
    string50       case_name;
    string5        case_type;
    string25       case_type_desc;
    string8        case_filing_dt;
    string56       pty_nm;
    string1        pty_nm_fmt;
    string20       orig_lname;
    string20       orig_fname;
    string20       orig_mname;
    string10       orig_name_suffix;
    string1        pty_typ;
    string1        nitro_flag;
    string9        orig_ssn;
    string10       dle_num;
    string9        fbi_num;
    string10       doc_num;
    string10       ins_num;
    string15       id_num;
    string25       dl_num;
    string2        dl_state;
    string2        citizenship;
    string8        dob;
    string8        dob_alias;
    string2        place_of_birth;
    string25       street_address_1;
    string25       street_address_2;
    string25       street_address_3;
    string10       street_address_4;
    string10       street_address_5;
    string5        race;
    string30       race_desc;
    string1        sex;
    string5        hair_color;
    string25       hair_color_desc;
    string5        eye_color;
    string25       eye_color_desc;
    string5        skin_color;
    string25       skin_color_desc;
    string3        height;
    string3        weight;
    string10       party_status;
    string60       party_status_desc;
    string10       prim_range;
    string2        predir;
    string28       prim_name;
    string4        addr_suffix;
    string2        postdir;
    string10       unit_desig;
    string8        sec_range;
    string25       p_city_name;
    string25       v_city_name;
    string2        state;
    string5        zip5;
    string4        zip4;
    string4        cart;
    string1        cr_sort_sz;
    string4        lot;
    string1        lot_order;
    string2        dpbc;
    string1        chk_digit;
    string2        rec_type;
    string2        ace_fips_st;
    string3        ace_fips_county;
    string10       geo_lat;
    string11       geo_long;
    string4        msa;
    string7        geo_blk;
    string1        geo_match;
    string4        err_stat;
    string5        title;
    string20       fname;
    string20       mname;
    string20       lname;
    string5        name_suffix;
    string3        cleaning_score;
  end;
 end
 ;