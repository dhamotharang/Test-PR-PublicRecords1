EXPORT Layout_WA_Okanogan := MODULE

	// EXPORT raw_in := RECORD
		// string	line;
	// END;
	
	EXPORT	raw_in	:= RECORD
		string8	booking_date;
		string4	booking_time;
		//string10 log_num;
		string30	lfm_name;
		string6	id_num;
		string3	age;
		string1	race;
		string1	sex;
		string60	p_addl_charge; //multiple charges normalized
		string20	officer;
		string15	billing;
		string1	CRT;
		string40	meth_rel_date_time;
		string10	Comp_num;
		string	SGT_Rev;
	END;
	
END;
