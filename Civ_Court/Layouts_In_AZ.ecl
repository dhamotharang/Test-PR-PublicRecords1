IMPORT Civ_Court, ut;

EXPORT Layouts_In_AZ := MODULE

	EXPORT CS_in	:= RECORD
		string8	case_id;
		string8	court_id;
		string21	full_case_num;
		string60	case_title;
		string60	judicial_officer_name;
		string10	filing_date;
		string10	disposition_date;
		string25	case_category;
	END;
	
	EXPORT Party_in	:= RECORD
		string8	prty_id;
		string8	case_id;
		string1	source_system_prty_type_parta;
		//string5	source_system_prty_type_partb;
		string35	source_system_prty_description;
		string8	court_id;
		string13	case_search_key;
		string90	prty_name;
		string10	birth_date;
		string25	City; 
		string2	State ;
		string9	Zip;
		string21	full_case_num;
		string12	f_name;
		string60	l_name;
		string2	prty_search_key;
		string1	prty_gender;
		string1	state_id;
		string60	prty_origin;
		string1	reg_hold_flag;
		string1	failure_to_appear_flag;
	END;
	
	EXPORT Addr_In	:= RECORD
		string8	prty_id;
		string8	case_id;
		string30	Address_1;
		string30	Address_2;
		string25	City;
		string2 	State;
		string9	Zip;
		string2	Country;
		string10	Phone;
	END;
	
	EXPORT Event_in	:= RECORD
		string8	case_id;
		string8	prty_id;
		string10	evnt_date;
		string30	evnt_description;
		string6	prty_type;
	END;
	
	EXPORT Civil_In	:= RECORD //all inputs joined
		string8  case_id;
		string8  court_id;
		string21 full_case_num;
		string60 case_title;
		string60 judicial_officer_name;
		string10 filing_date;
		string10 disposition_date;
		string35 case_category;
		string8  prty_id;
		string1  source_system_prty_type_parta;
		//string5  party_source_system_prty_type_partb;
		string35 source_system_prty_description;
		string8  party_court_id;
		string15 party_case_search_key;
		string90 party_prty_name;
		string10 party_birth_date;
		string25 party_city;
		string2  party_state;
		string9  party_zip;
		string21 party_full_case_num;
		string12 party_f_name;
		string60 party_l_name;
		string2  prty_search_key;
		string1  prty_gender;
		string1  party_state_id;
		string60 prty_origin;
		string30 Address_1;
		string30 Address_2;
		string25 city;
		string2 state;
		string9 zip;
		string2 country;
		string10 phone;
	END;
	
	EXPORT CivilEvent_in	:= RECORD //Civil_Party join with event to get court_id, case_num, and party_case_search_key
		string8  court_id;
		string8  prty_id;
		string21 full_case_num;
		string15 party_case_search_key;
		string10 evnt_date;
		string30 evnt_description;
	END;
	
END;



