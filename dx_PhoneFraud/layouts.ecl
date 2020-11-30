EXPORT layouts := MODULE

	EXPORT Raw_OTP := RECORD
		string20 	transaction_id;
		string20 	event_time;
		string30 	function_name;
		string30 	account_id;
		string30 	subject_id;
		string30 	customer_subject_id;
		string20 	otp_id;
		boolean  	verify_passed;
		string2  	otp_delivery_method;
		string2  	otp_preferred_delivery;
		string20 	otp_phone;
		string128 otp_email;
		string60  reference_code;
		integer5  product_id;						//integer11
		integer5  sub_product_id;				//integer11
		string30  subject_unique_id;
		string50  first_name;
		string50  last_name;
		string30  country;
		string30  state;
		string2   otp_type;
		integer1  otp_length;						//integer2
		string20  mobile_phone;
		string2   mobile_phone_country;
		string20  mobile_phone_carrier;
		string20  work_phone;
		string2   work_phone_country;
		string20  home_phone;
		string2   home_phone_country;
		string2   otp_language;
		string20  date_added;						
	END;
	
	EXPORT Base_OTP := RECORD
		string8		date_file_loaded;
		string20 	transaction_id;
		string8 	event_date;
		string6 	event_time;
		string30 	function_name;
		string30 	account_id;
		string30 	subject_id;
		string30 	customer_subject_id;
		string20 	otp_id;
		boolean  	verify_passed;
		string2  	otp_delivery_method;
		string2  	otp_preferred_delivery;
		string10 	otp_phone;
		string128 otp_email;
		string60 	reference_code;
		integer5 	product_id;						//integer11
		integer5 	sub_product_id;				//integer11
		string30 	subject_unique_id;
		string50 	first_name;
		string50 	last_name;
		string30 	country;
		string30 	state;
		string2  	otp_type;
		integer1 	otp_length;						//integer2
		string10 	mobile_phone;
		string2  	mobile_phone_country;
		string20 	mobile_phone_carrier;
		string10 	work_phone;
		string2  	work_phone_country;
		string10 	home_phone;
		string2  	home_phone_country;
		string2  	otp_language;
		string8  	date_added;						
		string6  	time_added;	
	END;

    EXPORT OTP_payload := Base_OTP - date_file_loaded;

    EXPORT Raw_spoofing := RECORD
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
	
	EXPORT Base_spoofing := RECORD
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
    EXPORT Spoofing_payload := Base_spoofing - date_file_loaded;
END;