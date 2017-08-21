IMPORT Civ_Court, ut;

EXPORT Layouts_In_MS_Harrison := MODULE

	EXPORT raw_in := RECORD
		string	line;
	END;
	
	EXPORT Civil	:= RECORD
		string12 	case_num;
		string3 	seq_num;
		string3 	plt_def;
		string2 	cv_crim;
		string20 	case_type;
		string2 	status;
		string35 	entitiy_name;
		string8 	file_date;
		string8 	offense_date1;
		string30 	offense1;
		string30 	disposition1;
		string8 	disposition_date1;
		string8 	offense_date2;
		string30 	offense2;
		string30 	disposition2;
		string8 	disposition_date2;
		string8 	offense_date3;
		string30 	offense3;
		string30 	disposition3;
		string8 	disposition_date3;
		string8 	offense_date4;
		string30 	offense4;
		string30 	disposition4;
		string8 	disposition_date4;
		string8 	offense_date5;
		string30 	offense5;
		string30 	disposition5;
		string8 	disposition_date5;
		//string11 	unknown; Not used
		//string1		code := ''; Not used
	END;
	
	EXPORT Civil_norm	:= RECORD
		string12 	case_num;
		string3 	seq_num;
		string3 	plt_def;
		string2 	cv_crim;
		string20 	case_type;
		string2 	status;
		string35 	entitiy_name;
		string8 	file_date;
		string8 	offense_date;
		string30 	offense;
		string30 	disposition;
		string8 	disposition_date;
	END;
	
END;

