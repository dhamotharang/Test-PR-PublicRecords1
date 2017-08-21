EXPORT layout_OH_fairfield := MODULE

	EXPORT raw_in := RECORD
		string	line;
	END;
	
	//rec_type = 1 RL = 62
	EXPORT disposition	:= RECORD 
		string20	case_number;
		string1		rec_type;
		string8		file_date; /*yyyymmdd*/
		string25	case_term_desc;
		string8		case_term_date; /*yyyymmdd*/
	END;
	
	//rec_type = 2 RL = 135
	EXPORT Person	:= RECORD
		string20	case_number;
		string1		rec_type;
		string25	lname;
		string25	fname;
		string25	mname;
		string25	suffix;
		string8		dob;
		string3		alias_cnt;
		string3		charge_cnt;
	END;
	
	//rec_type = 3 RL = 176
	EXPORT charge	:= RECORD
		string20	case_number;
		string1		rec_type;
		string10	charge_code;
		string50	charge_desc;
		string25	charge_disp_desc;
		string8		charge_disp_date;
		string4		sent_days_jail;
		string4		sent_days_jail_susp;
		string4		sent_days_jail_prob;
		string50	charge_degree_off;
	END;
	
		//rec_type = 4 RL = 121
	EXPORT Alias	:= RECORD
		string20	case_number;
		string1		rec_type;
		string25	lname;
		string25	fname;
		string25	mname;
		string25	suffix;
	END;
END;