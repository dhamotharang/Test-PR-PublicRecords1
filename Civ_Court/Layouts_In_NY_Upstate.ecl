IMPORT Civ_Court, ut;

EXPORT Layouts_In_NY_Upstate := MODULE

	EXPORT CAS	:= RECORD
	 string2 	county_code;
   string15	 idxno;
   string2 	case_status;
   string15	calendar_no;
   string1 	prelim_conf_indic;
   string40	plaintiff;
   string40 	defendant;
   string1 	municipality_indic;
   string1 	complexity_indic;
   string10	disposition_date;
   string10	rji_dispos_deadline;
   string10	rji_pre_noi_deadline;
   string10 	rji_noi_disp_deadline;
   string10 	rji_was_filed_with_cc;
   string10 	noi_was_filed;
   string1 	jury_status;
   string5 	action_type;
   string20 	action_description;
   string1 	damage_sought;
   string1 	general_preference;
   string3 	rji_type;
   string10 	case_began;
   string20 	rji_comment_for_other;
   string3 	trial_time_estima;
   string5 	justice;
   string1 	bill_of_partic_served;
   string10 	certif_of_read_filed;
   string10 	certif_of_read_due;
   string10 	noi_filed;
   string10 	noi_due;
   string10	 last_stat_conf_sched;
   string10 	last_stat_conf_held;
   string10 	last_pre_tr_conf_sched;
   string10 	last_pre_tr_conf_held;
   string10	 last_prelim_conf_req;
   string10 	last_prelim_conf_sched;
   string10 	last_prelim_conf_held;
   string2 	pj_case_status;
   string5 	pj_justice;
   string1 	status_type;
   string2 	court_code;
   string15 	upstate_rji_no;
   string10 	last_update_date;
   string15 	second_upstate_file_no;
   string10 	compliance_conf_sched_date;
   string10 	compliance_conf_held_date;
   string10 	last_compliance_conf_date;
   string2 	crlf;
	END;
	
	EXPORT ATY	:= RECORD
	 string2 	county_code;
   string15	 idxno;
   string9 	attorney_id;
   string3 	entry_seq;
   string1 	attorney_type;
   string28 	attorney_client;
   string10 	attorney_retainer;
   string1 	attorney_who_for;
   string10 	date_terminated;
   string1 	attorney_status;
   string40 	attorney_name;
   string7 	attorney_reg_id;
   string2 	crlf;
	END;
	
	EXPORT MTN	:= RECORD
	 string2 	county_code;
   string15	 idxno;
   string3 	motion_seq;
   string10 	submission_date;
   string255 	motion_description;
   string5 	justice;
   string5 	relief_sought;
   string1 	applying_party;
   string1 	opposing_party;
   string10 	applying_filed;
   string10 	opposing_filed;
   string10 	date_of_decision;
   string1 	motion_status;
   string255 	essentials_of_decision;
   string1 	type_of_decision;
   string10 	order_signed_date;
   string10 	motion_due_date;
   string5 	motion_effect;
	 string10 original_motion_date;
   string20 decision_comment;
   string5 	proceed_type;
	 string1	unknown_code;
	 string11 filler;
   string2 	crlf;
	END;
	
	EXPORT APR	:= RECORD
		string2 	county_code;
		string15	 idxno;
		string3 	motion_seq;
		string3 	apprearance_seq;
		string10 	appearance_date;
		string3 	series;
		string20 	appearance_time;
		string5 	court_part;
		string6 	appearance_type;
		string5 	justice;
		string5 	action;
		string20 	appearance_comment1;
		string20 	appearance_comment2;
		string2 	crlf;
	END;
	
	EXPORT County_lkp	:= RECORD
		string2		code;
		string13	description;
		string1		crlf;
	END;
	
	EXPORT Case_status_lkp	:= RECORD
		string2		code;
		string52	description;
		string1		crlf;
	END;
	
	EXPORT Apr_type_lkp	:= RECORD
		string6		code;
		string30	description;
		string1		crlf;
	END;
	
	EXPORT Action_type_lkp	:= RECORD
		string2		code;
		string5		action_type;
		string100	description;
		string2		crlf;
	END;
	
	EXPORT Justice_lkp	:= RECORD
		string2 	county_code;
		string5 	justice;
		string7 	cars_id;
		string100 literal_justice_name;
		string15	justice_last_name;
		string15 	justice_first_name;
		string5 	part_no;
		string1 	status;
		string1 	justice_type;
		string5 	part_num;
		string10 	menmonic;
		string40 	justice_address;
		string30 	justice_city_state;
		string10 	justice_zip;
		string20 	justice_phone;
		string2 	crlf;
	END;
	
END;








