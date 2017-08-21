IMPORT Civ_Court, ut;

EXPORT Layouts_In_NJ := MODULE

	EXPORT raw_in	:= RECORD
		string7	report_number;
		string3	venue_id;
		string3 court_code;
		string2 report_request_number;
		string4 docketed_judgement_year;
		string6 docketed_judgement_seq_num;
		string2 docketed_judgement_type_code;
		string3 debt_number;
		string1 record_type_code;
		string1 party_type_indicator;
		string272	line;
	END;
	
	EXPORT case_header	:= RECORD
		string7	report_number;
		string3	venue_id;
		string3 court_code;
		string2 report_request_number;
		string4 docketed_judgement_year;
		string6 docketed_judgement_seq_num;
		string2 docketed_judgement_type_code;
		string3 debt_number;
		string1 record_type_code;  // Code 'A'
		string8	report_request_date;
		string8 report_from_date;
		string8 report_to_date;
		string1 record_type_code_2;
		string10 docketed_judgement_number;
		string12 nonacms_docket_number;
		string3 nonacms_venue_id;
		string2 nonacms_docket_type;
		string35 filler1;
		string3 case_type_code;
		string55 case_title;
		string8 case_filed_date;
		string10 acms_docket_number;
		string3 acms_venue_id;
		string3 acms_court_code;
	END;
	
	EXPORT judgement	:= RECORD
		string7	report_number;
		string3	venue_id;
		string3 court_code;
		string2 report_request_number;
		string4 docketed_judgement_year;
		string6 docketed_judgement_seq_num;
		string2 docketed_judgement_type_code;
		string3 debt_number;
		string1 record_type_code;  // Code 'B'
		string1 record_type_code1;
		string10 docketed_judgement_number;
		string10 judgement_number;
		string1 judgement_status_code;
		string8 judgement_status_date;
		string9 judgement_orig_amt;
		string9 judgement_orig_taxed_cost_amt;
		string9 judgement_orig_interest_amt;
		string9 judgement_orig_atty_fee_amt;
		string9 judgement_other_award_orig_amt;
		string9 judgement_due_amt;
		string9 judgement_due_taxed_cost_amt;
		string9 judgement_due_interest_amt;
		string9 judgement_due_atty_fee_amt;
		string9 judgement_other_award_fee_amt;
		string4 judgement_judgement_time;
		string8 judgement_docket_date;
		string8 judgement_entered_date;
		string8 judgement_issue_date;
	END;

	EXPORT debts	:= RECORD
		string7	report_number;
		string3	venue_id;
		string3 court_code;
		string2 report_request_number;
		string4 docketed_judgement_year;
		string6 docketed_judgement_seq_num;
		string2 docketed_judgement_type_code;
		string3 debt_number;
		string1 record_type_code;  // Code 'C'
		string1 record_type_code1;
		string10 docketed_judgement_number;
		string3 debt_number1;
		string1 devt_status_code;
		string8 debt_status_date;
		string8 entered_date;
		string9 party_orig_amt;
		string9 party_orig_taxed_cost_amt;
		string9 party_orig_interest_amt;
		string9 party_orig_atty_fee_amt;
		string9 party_other_award_orig_amt;
		string9 party_due_amt;
		string9 party_due_taxed_cost_amt;
		string9 party_due_interest_amt;
		string9 party_due_atty_fee_amt;
		string9 party_other_award_due_amt;
		string55 debt_comments;
	END;
	
	EXPORT party	:= RECORD
		string7	report_number;
		string3	venue_id;
		string3 court_code;
		string2 report_request_number;
		string4 docketed_judgement_year;
		string6 docketed_judgement_seq_num;
		string2 docketed_judgement_type_code;
		string3 debt_number;
		string1 record_type_code;  	//Code 'D'
 		string1 party_type_indicator; //Type '0' or '1'
		string1 party_record_type_code;
		string1 party_type_indicator1; //creditor/debtor
		string10 docketed_judgement_number;
		string3 debt_number1;
		string30 party_name;
		string2 party_role_type_code;
		string8 ptydebt_status_date;
		string2 ptydebt_status_code;
		string20 atty_firm_last_name;
		string9 atty_firm_first_name;
		string1 atty_firm_middle_init;
		string35	nonatty_comments;
		string10 party_initials;
		string36 party_street_name;
		string36 party_addt_street_name;
		string16 party_city_name;
		string2 party_state_code;
		string9 party_zip_code;
		string3 party_affiliation_code;
		string3 party_number;
	END;
	
	EXPORT party_alias	:= RECORD
		string7	report_number;
		string3	venue_id;
		string3 court_code;
		string2 report_request_number;
		string4 docketed_judgement_year;
		string6 docketed_judgement_seq_num;
		string2 docketed_judgement_type_code;
		string3 debt_number;
		string1 record_type_code;  	//Code 'D'
 		string1 party_type_indicator; //Type '2'
		string1 party_record_type_code;
		string1 party_type_indicator1; 	//alias
		string10 docketed_judgement_number;
		string3 debt_number1;
		string65	party_alternate_name;
		string30 	party_name;
		string2	alternate_type_code;
		string3 party_number;
	END;
	
	EXPORT party_guardian	:= RECORD
		string7	report_number;
		string3	venue_id;
		string3 court_code;
		string2 report_request_number;
		string4 docketed_judgement_year;
		string6 docketed_judgement_seq_num;
		string2 docketed_judgement_type_code;
		string3 debt_number;
		string1 record_type_code;  	//Code 'D'
 		string1 party_type_indicator; //Type '3'
		string1 party_record_type_code;
		string1 party_type_indicator1; //guardian
		string10 docketed_judgement_number;
		string3 debt_number1;
		string65	party_alternate_name;
		string30 	party_name;
		string3	guardian_affiliation_code;		//field not used
		string3 party_number;
	END;

	EXPORT jdgmt_notes	:= RECORD
		string7	report_number;
		string3	venue_id;
		string3 court_code;
		string2 report_request_number;
		string4 docketed_judgement_year;
		string6 docketed_judgement_seq_num;
		string2 docketed_judgement_type_code;
		string3 debt_number;
		string1 record_type_code;		//Code 'E'
		//string8 date_entered;
		string1 record_type_code1;
		string10 docketed_judgement_number;
		string75 jdgcomm_comments;
		string8 jdg_entered_date;
	END;
	
END;

		


