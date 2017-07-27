EXPORT Layout_Spoofing := MODULE

	EXPORT Raw := RECORD
		integer4 id;										//integer10
		string45 reference_id;
		string20 mode_type;
		string50 account_name;
		string20 event_time;						//timestamp
		string45 spoofed_phone_number;
		string45 destination_number;
		string45 source_phone_number;
		string20 ip_address;
		string15 neustar_lower_bound;
		string15 neustar_upper_bound;
		string30 vendor;
		string20 date_added;						//timestamp
		string30 user_added;						//remove
		//string20 date_changed;				//remove timestamp
		//string30 user_changed;				//remove
	END;
	
	EXPORT Base := RECORD
		string8  date_file_loaded;
		string10 phone;
		string1	 phone_origin;					//S - spoofed; D - destination; C - source;
		integer4 id;										//integer10
		string45 reference_id;
		string20 mode_type;
		string50 account_name;
		string8	 event_date;
		string6  event_time;						
		string20 ip_address;
		string15 neustar_lower_bound;
		string15 neustar_upper_bound;
		string30 vendor;
		string8  date_added;						
		string6  time_added;	
	END;

END;

