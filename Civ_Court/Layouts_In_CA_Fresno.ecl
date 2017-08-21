Import Civ_Court, ut;

EXPORT Layouts_in_CA_Fresno := MODULE

	EXPORT Civil_in := RECORD
		STRING16	case_number;
		STRING		Case_title;
		STRING51 	case_type;
		STRING		case_subtype;
		STRING10	file_date;
		STRING10	Case_status_date;
		STRING 		current_case_status;
	END;
	
/* - Old lookup files. Not part of new layout
	EXPORT court_codes_1 := RECORD
		string2	court_type_cd;
		string2	court_cd_new;
	END;
	
	EXPORT court_codes_2	:= RECORD
		string2		court_type_cd;
		string20	court_desc;
	END;
	
	EXPORT loc_codes	:= RECORD
		string2		loc_cd;
		string40	loc_desc;
	END;
	
	EXPORT party_codes	:= RECORD
		string4		party_type_cd;
		string40	party_type_desc;
		string2		master_type_cd;
	END;
*/	
END;
