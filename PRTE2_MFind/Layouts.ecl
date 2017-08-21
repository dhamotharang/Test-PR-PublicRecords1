IMPORT MFind, address, standard;
EXPORT Layouts := module

	EXPORT layout_in := RECORD
		string84 trim_vid;
		string20 curr_name_last;
		string20 curr_name_first;
		string20 curr_name_middle;
		string curr_name_m_initial;
		string5 curr_name_suffix;
		string curr_name_gender;
		string8 dob;
		string9 ssn;
		string str_addr_1;
		string str_addr_2;
		string city;
		string2 state;
		string5 orig_zip;
		string20 home_state;
		string20 legal_res_state;
		string duty_base;
		string6 prim_occup;
		string6 duty_occup;
		string6 scnd_occup;
		string education;
		string source_of_entry;
		string mil_branch;
		string mil_status;
		string mil_pay_grade;
		string mil_active_date;
		string mil_est_sep_date;
		string mil_sep_date;
		string mil_service_yrs;
		string mil_prim_mos;
		string mil_duty_mos;
		string mil_scnd_mos;
		string cite_id;
		string file_id;
		string publication;
		string100 cust_name;
		string20 bug_num;
	END;
	
	EXPORT layout_base := RECORD 
		unsigned6	did;
		unsigned	did_score :=0;
	  layout_in;
		address.Layout_Clean_Name;
		address.Layout_Clean182;
	END;

	EXPORT layout_autokey := RECORD
		unsigned6	did;
		string84 trim_vid;
		standard.Addr Addr;
		standard.name name;
		unsigned1 zero := 0;
		string1  blank:='';
	END;

	EXPORT layout_keys := MFind.Layout_Clean_MFind; //did, vid
	
END;