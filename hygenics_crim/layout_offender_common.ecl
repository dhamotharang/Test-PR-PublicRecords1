import address;

export layout_offender_common := record
	string8		process_date;
	string8		file_date:='';
	string60	offender_key;
	string2		vendor;
	string20	source_file;
	string2		record_type := '';
	string2		orig_state;
	string15	id_num:='';
	string56	pty_nm:='';
	string1		pty_nm_fmt:='';
	string20    orig_lname:= '';				//new field added
    string20    orig_fname:= '';				//new field added
    string20    orig_mname:= '';				//new field added
    string10    orig_name_suffix:= '';			//new field added
	string20	lname:='';		
	string20	fname:='';	
	string20	mname:='';
	string6		name_suffix:='';
	string1		pty_typ:='';
	string1		nitro_flag:='';
	string9		ssn:='';
	string35	case_num := '';
	string40    case_court	:= '';    			//new field added
	string8		case_date := '';
	string5   	case_type := '';
	string25	case_type_desc;
	string30	county_of_origin := '';
	string10	dle_num :='';
	string9		fbi_num :='';
	string10	doc_num :='';
	string10	ins_num :='';
	//string15    id_num := '';					//new field added
    string25    dl_num := '';					//new field added
    string2     dl_state := '';					//new field added
	string2		citizenship :='';
	string8		dob:='';
	string8		dob_alias:='';
	string13	county_of_birth;
	string2		place_of_birth:='';
	string25	street_address_1:='';
	string25	street_address_2:='';
	string25	street_address_3:='';
	string10	street_address_4:='';
	string10	street_address_5:='';
	string13	current_residence_county;
	string13	legal_residence_county;
	string3		race_code:='';
	string30	race_desc:='';
	string1		sex:='';
	string3		hair_color:='';
	string15	hair_color_desc:='';
	string3		eye_color:='';
	string15	eye_color_desc:='';
	string3		skin_color:='';
	string15	skin_color_desc:='';
	string10	scars_marks_tattoos_1:='';
	string10	scars_marks_tattoos_2:='';
	string10	scars_marks_tattoos_3:='';
	string10	scars_marks_tattoos_4:='';
	string10	scars_marks_tattoos_5:='';
	string3		height:='';
	string3		weight:='';
	string5		party_status:='';
	string60	party_status_desc:='';
	string10	_3g_offender:='';
	string10	violent_offender:='';
	string10	sex_offender:='';
	string10	vop_offender:='';
	string1		data_type;
	string26	record_setup_date;
	address.Layout_Address_Clean_Return;
	string3		ace_fips_county;
	string12	did;
	string9		ssn_appended;
	string1		curr_incar_flag := '';
	string1		curr_parole_flag := '';
	string1		curr_probation_flag := '';
	string8  	src_upload_date := '';			//new field added
	string3     Age := '';						//new field added
	string150   image_link := '';				//new field added
end;