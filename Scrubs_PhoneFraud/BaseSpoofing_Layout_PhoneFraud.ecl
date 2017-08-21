import phonefraud;

EXPORT BaseSpoofing_Layout_PhoneFraud := RECORD
		string8  date_file_loaded;
		string10 phone;
		string1	 phone_origin;					//S - spoofed; D - destination; C - source;
		integer4 id_value;										//integer10
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