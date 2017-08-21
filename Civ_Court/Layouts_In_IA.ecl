IMPORT Civ_Court, ut;

EXPORT Layouts_In_IA := MODULE

	EXPORT Party_in	:= RECORD
		string18 	case_number;
		string9 	file_date;
		string10	blank1;
		string2 	filed_seq;
		string2 	judmt_indicator;
		string5 	people_role_code;
		string3 	people_status;
		string10 	people_id;
		string31 	last_name;
		string31 	first_name;
		string31 	middle_name;
		string9 	blank2;
	END;
	
	EXPORT PeopleIndx_in := RECORD
		string18	case_number;
		string31 	last_name;
		string31 	first_name;
		string31 	middle_name;
		string5 	people_role_code;
		string10 	birth_date;
		string2 	people_status;
		string13 	blank;
	END;

	
	EXPORT Crim_Case_in	:= RECORD
		string18	case_number;
		string10	case_initiated_date;
		string60	case_title;
		string45	blank1;
	END;
	
	EXPORT Judgmt_Atty_in	:= RECORD
		string18	case_number;
		string5 	atty_role_code;
		string3 	atty_status;
		string31 	atty_last_name;
		string31 	atty_first_name;
		string31 	atty_middle_name;
		string14	blank1;
	END;
	
	//Used only for filtering records
	EXPORT Crim_Charge_in	:= RECORD //RL = 133
		string18	case_number;
		string10	offense_date;
		string20	conviction_chrg;
		string9		blank1;
		string5		conviction_yr;
		string3		charge_count;
		string68	charge_desc;
	END;
		
	EXPORT Civil_join	:= RECORD
		string17 	case_number;
		string9 	file_date;
		string12 	filed_seq;
		string2 	judmt_indicator;
		string4 	people_role_code;
		string3 	people_status;
		string10 	people_id;
		string30 	last_name;
		string30 	first_name;
		string30 	middle_name;
		string9 	birth_date;
		string9 	case_initiated_date;
		string60	case_title;
		string5 	atty_role_code;
		string3 	atty_status;
		string30 	atty_last_name;
		string30 	atty_first_name;
		string60 	atty_middle_name;
		string68	charge_desc;
	END;
	
END;



