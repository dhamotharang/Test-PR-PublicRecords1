EXPORT Layouts := module

	export vendor_mainLayout := Record
		string8		org_corporate_id;
		string300	org_name;
		string100	address_1;
		string100	address_2;
		string75	city;
		string50	state;
		string50	zip;
		string100	province;
		string100	country;
		string100	mailing_address_1;
		string100	mailing_address_2;
		string50	mailing_city;
		string50	mailing_state;
		string50	mailing_zip;
		string100	mailing_province	;
		string100	mailing_country	;
		string300	agent_name	;
		string100	agent_address1	;
		string100	agent_address2	;
		string100	agent_city	;
		string50	agent_state	;
		string50	agent_zip	;
		string100	agent_mailing_address1	;
		string100	agent_mailing_address2	;
		string50	agent_mailing_city	;
		string50	agent_mailing_state	;
		string50	agent_mailing_zip	;
		string10	craid	;
		string50	corp_home_state	;
		string100	corp_country	;
		string10	corp_date	;
		string20	corp_term	;
		string1		entity_status	;
		string4		ar_year	;
		string2		entity_type	;
		string1		llc_managed_ind	;
	end;

	export vendor_mainLayoutBase := Record
	
		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		vendor_mainLayout;
		
	end;
	
	export vendor_amendLayout:= Record
	 	string8		org_corporate_id;
		string20	amendment_id;
		string3		change_type;
		string10	date_of_change;
	end;

	export vendor_amendLayoutBase := RECORD
	
		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		vendor_amendLayout;
		
	end;
	
	export vendor_arLayout:= Record
	  string8		org_corporate_id;
		string20	ann_report_id;
		string3		change_type;
		string10	date_of_change;
		string4 	ar_year;
	end;

	export vendor_arLayoutBase := RECORD
	
		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		vendor_arLayout;
		
	end;
	
	export Temp_mainLayout:=record
			
		 vendor_mainLayout;
		 string4 flag; //will used to Drop records when accent symbols found in company names!
				 
	end;

end;