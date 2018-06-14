EXPORT Layout_PhoneFinder := MODULE

	///////////////////////////////////
	//Transactions/////////////////////
	///////////////////////////////////
	export Transactions_In := record
			string16	transaction_id;	
			string20 transaction_date;
			string60	user_id;
			string8 product_code;
			string16 company_id;
			string8 source_code;
			string20 batch_job_id;
			integer5 batch_acctno;
			integer5 response_time;
			string60 reference_code;
			string32 phonefinder_type;
			string32 submitted_lexid;
			string15 submitted_phonenumber;
			string20 submitted_firstname;
			string20 submitted_lastname;
			string20 submitted_middlename;
			string128 submitted_streetaddress1;
			string64 submitted_city;
			string16 submitted_state;
			string10 submitted_zip;
			string15 phonenumber;
			string16 risk_indicator;
			string32 phone_type;
			string32 phone_status;
			integer5 ported_count;
			string20 last_ported_date;
			integer5 otp_count;
			string20 last_otp_date;
			integer5 spoof_count;
			string20 last_spoof_date;
			string32 phone_forwarded;
			string20 date_added;
	end;

	export Transactions_Raw := record
			Transactions_In;
			string255 filename{virtual (logicalfilename)};
	end;
	
	export Transactions_History := record
			Transactions_In;
			string255 filename;
	end;
	
	export Transactions_Main := record
			string8	date_file_loaded;
			string16	transaction_id;	
			string8 transaction_date;
			string6 transaction_time;
			string60	user_id;
			string8 product_code;
			string16 company_id;
			string8 source_code;
			string20 batch_job_id;
			integer5 batch_acctno;
			integer5 response_time;
			string60 reference_code;
			string32 phonefinder_type;
			string32 submitted_lexid;
			string15 submitted_phonenumber;
			string20 submitted_firstname;
			string20 submitted_lastname;
			string20 submitted_middlename;
			string128 submitted_streetaddress1;
			string64 submitted_city;
			string16 submitted_state;
			string10 submitted_zip;
			string15 phonenumber;
			string16 risk_indicator;
			string32 phone_type;
			string32 phone_status;
			integer5 ported_count;
			string8 last_ported_date;
			string6 last_ported_time;
			integer5 otp_count;
			string8 last_otp_date;
			string6 last_otp_time;
			integer5 spoof_count;
			string8 last_spoof_date;
			string6 last_spoof_time;
			string32 phone_forwarded;
			string8	date_added;
			string6	time_added;
	end;
	
	///////////////////////////////////
	//Other Phones/////////////////////
	///////////////////////////////////
	export OtherPhones_In := record
			string16	transaction_id;
			integer5	sequence_number;
			integer5	phone_id;
			string15	phonenumber;
			string16 risk_indicator;
			string32 phone_type;
			string32 phone_status;
			string64 listing_name;
			string16 porting_code;
			string32 phone_forwarded;
			integer1 verified_carrier;
			string20 date_added;
	end;
	
	export OtherPhones_Raw := record
			OtherPhones_In;
			string255 filename{virtual (logicalfilename)};
	end;
	
	export OtherPhones_History := record
			OtherPhones_In;
			string255 filename;
	end;
	
	export OtherPhones_Main := record
			string8	date_file_loaded;
			string16	transaction_id;
			integer5	sequence_number;
			integer5	phone_id;
			string15	phonenumber;
			string16 risk_indicator;
			string32 phone_type;
			string32 phone_status;
			string64 listing_name;
			string16 porting_code;
			string32 phone_forwarded;
			integer1 verified_carrier;
			string8	date_added;
			string6	time_added;
	end;
	
	///////////////////////////////////
	//Identities///////////////////////
	///////////////////////////////////
	export Identities_In := record
			string16	transaction_id;
			integer5	sequence_number;
			string32	lexid;
			string128	full_name;
			string128	full_address;
			string64	city;
			string16	state;
			string10	zip;
			integer1	verified_carrier;
			string20 date_added;
	end;
	
	export Identities_Raw := record
			Identities_In;
			string255 filename{virtual (logicalfilename)};
	end;
	
	export Identities_History := record
			Identities_In;
			string255 filename;
	end;
	
	export Identities_Main := record
			string8	date_file_loaded;
			string16	transaction_id;
			integer5	sequence_number;
			string32	lexid;
			string128	full_name;
			string128	full_address;
			string64	city;
			string16	state;
			string10	zip;
			integer1	verified_carrier;
			string8	date_added;
			string6	time_added;
	end;
	
	///////////////////////////////////
	//Risk Indicators//////////////////
	///////////////////////////////////
	export RiskIndicators_In := record
			string16	transaction_id;
			integer5	phone_id;
			integer5	sequence_number;
			string20 date_added;
			integer5	risk_indicator_id;
			string16	risk_indicator_level;
			string256	risk_indicator_text;
			string32	risk_indicator_category;
	end;
	
	export RiskIndicators_Raw := record
			RiskIndicators_In;	
			string255 filename{virtual (logicalfilename)};
	end;
	
	export RiskIndicators_History := record
			RiskIndicators_In;
			string255 filename;
	end;
	
	export RiskIndicators_Main := record
			string8	date_file_loaded;
			string16	transaction_id;
			integer5	phone_id;
			integer5	sequence_number;
			integer5	risk_indicator_id;
			string16	risk_indicator_level;
			string256	risk_indicator_text;
			string32	risk_indicator_category;
			string8	date_added;
			string6	time_added;
	end;

END;