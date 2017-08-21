EXPORT PhoneFraud := MODULE

	SHARED	lSubDirName					:=	'';
	SHARED	lCSVVersion					:=	'20090706';
	SHARED	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

//OTP
	EXPORT rthor_data400_key_phonefraud_otp := RECORD
		string10 otp_phone;
		string20 transaction_id;
		string8 event_date;
		string6 event_time;
		string30 function_name;
		string30 account_id;
		string30 subject_id;
		string30 customer_subject_id;
		string20 otp_id;
		boolean verify_passed;
		string2 otp_delivery_method;
		string2 otp_preferred_delivery;
		string128 otp_email;
		string60 reference_code;
		integer5 product_id;
		integer5 sub_product_id;
		string30 subject_unique_id;
		string50 first_name;
		string50 last_name;
		string30 country;
		string30 state;
		string2 otp_type;
		integer1 otp_length;
		string10 mobile_phone;
		string2 mobile_phone_country;
		string20 mobile_phone_carrier;
		string10 work_phone;
		string2 work_phone_country;
		string10 home_phone;
		string2 home_phone_country;
		string2 otp_language;
		string8 date_added;
		string6 time_added;
		unsigned8 __internal_fpos__;
	END;
	
	EXPORT dthor_data400_key_phonefraud_otp := dataset([], rthor_data400_key_phonefraud_otp);	
	
//Spoofing	
	EXPORT rthor_data400_key_phonefraud_spoofing := RECORD				
		string10 phone;
		string1 phone_origin;					//S - spoofed; D - destination; C - source;
		integer4 id;
		string45 reference_id;
		string20 mode_type;
		string50 account_name;
		string8 event_date;
		string6 event_time;
		string20 ip_address;
		string15 neustar_lower_bound;
		string15 neustar_upper_bound;
		string30 vendor;
		string8 date_added;
		string6 time_added;
		unsigned8 __internal_fpos__;
	END;
	
	EXPORT dthor_data400_key_phonefraud_spoofing := dataset([], rthor_data400_key_phonefraud_spoofing);	

END;