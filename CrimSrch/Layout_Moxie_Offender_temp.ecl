export Layout_Moxie_Offender_temp
:=
record
    CrimSrch.Layout_FCRA_Offender;
	string150	image_link;
	string12	did;
	
//carrying these nonfcra fields over temporarily for use in Life EIR keys	---- corrections.layout_Offender
	string8		process_date;
	string8		file_date;
//	string60	offender_key;
//	string2		vendor;
//	string20	source_file;
	string2		record_type := '';
	string25	orig_state;
	string15	id_num;
	string56	pty_nm;
	string1		pty_nm_fmt;
//	string20	lname;		
//	string20	fname;	
//	string20	mname;
//	string6		name_suffix;
	string1		pty_typ;
	string1		nitro_flag;
//	string9		ssn;
	string35	case_num := '';
	string8		case_date := '';
//	string5   case_type := '';
//	string25	case_type_desc;
	string30	county_of_origin := '';
	string10	dle_num;
	string9		fbi_num;
	string10	doc_num;
	string10	ins_num;
	string2		citizenship;
//	string8		dob;
//	string8		dob_alias;
	string13	county_of_birth;
//	string25	place_of_birth;
	string25	street_address_1;
	string25	street_address_2;
	string25	street_address_3;
	string10	street_address_4;
	string10	street_address_5;
	string13	current_residence_county;
  string13	legal_residence_county;
	string3		race;
//	string30	race_desc;
//	string7		sex;
	string3		hair_color;
//	string15	hair_color_desc;
	string3		eye_color;
//	string15	eye_color_desc;
	string3		skin_color;
//	string15	skin_color_desc;
	string10	scars_marks_tattoos_1;
  string10	scars_marks_tattoos_2;
  string10	scars_marks_tattoos_3;
  string10	scars_marks_tattoos_4;
  string10	scars_marks_tattoos_5;
//	string3		height;
//	string3		weight;
	string5		party_status;
	string60	party_status_desc;
	string10	_3g_offender;
  string10	violent_offender;
  string10	sex_offender;
  string10	vop_offender;
//	string1		data_type;
	string26	record_setup_date;
	string45	datasource;
//	address.Layout_Address_Clean_Return;
	string18	county_name;
//	string12	did;
	string3		score;
	string9		ssn_appended;
	string1		curr_incar_flag;
	string1		curr_parole_flag;
	string1		curr_probation_flag;



  end
 ;