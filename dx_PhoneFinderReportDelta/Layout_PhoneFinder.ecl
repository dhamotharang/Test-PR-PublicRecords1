EXPORT Layout_PhoneFinder := MODULE

	//DF-23251: Add 'dx_' Prefix to Index Definitions
	
	///////////////////////////////////
	//Transactions/////////////////////
	///////////////////////////////////
	
	export Transactions_Main := record
			string8		date_file_loaded;
			string16	transaction_id;	
			string8 	transaction_date;
			string6 	transaction_time;
			string60	user_id;
			string8 	product_code;
			string16 	company_id;
			string8 	source_code;
			string20 	batch_job_id;
			integer5 	batch_acctno;
			integer5 	response_time;
			string60 	reference_code;
			string32 	phonefinder_type;
			unsigned8 submitted_lexid;
			string15 	submitted_phonenumber;
			string20 	submitted_firstname;
			string20 	submitted_lastname;
			string20 	submitted_middlename;
			string128 submitted_streetaddress1;
			string64 	submitted_city;
			string16 	submitted_state;
			string10 	submitted_zip;
			string15  orig_phonenumber;
			string15 	phonenumber;
			string16 	risk_indicator;
			string32 	phone_type;
			string32 	phone_status;
			integer5 	ported_count;
			string8 	last_ported_date;
			string6 	last_ported_time;
			integer5 	otp_count;
			string8 	last_otp_date;
			string6 	last_otp_time;
			integer5 	spoof_count;
			string8 	last_spoof_date;
			string6 	last_spoof_time;
			string32 	phone_forwarded;
			string8		date_added;
			string6		time_added;
	end;
	
	export Transactions_Index := record
			Transactions_Main-[date_file_loaded, orig_phonenumber];
	end;
	
	///////////////////////////////////
	//Other Phones/////////////////////
	///////////////////////////////////
	
	export OtherPhones_Main := record
			string8		date_file_loaded;
			string16	transaction_id;
			integer5	sequence_number;
			integer5	phone_id;
			string15  orig_phonenumber;
			string15	phonenumber;
			string16 	risk_indicator;
			string32 	phone_type;
			string32 	phone_status;
			string64 	listing_name;
			string16 	porting_code;
			string32 	phone_forwarded;
			integer1 	verified_carrier;
			string8		date_added;
			string6		time_added;
	end;
	
	export OtherPhones_Index := record
			OtherPhones_Main-[date_file_loaded, orig_phonenumber];
	end;
	
	///////////////////////////////////
	//Identities///////////////////////
	///////////////////////////////////
	
	export Identities_Main := record
			string8		date_file_loaded;
			string16	transaction_id;
			integer5	sequence_number;
			unsigned8	lexid;
			string128	full_name;
			string128	full_address;
			string64	city;
			string16	state;
			string10	zip;
			integer1	verified_carrier;
			string8		date_added;
			string6		time_added;
	end;
	
	export Identities_Index := record
			Identities_Main-date_file_loaded;
	end;
	
	///////////////////////////////////
	//Risk Indicators//////////////////
	///////////////////////////////////
	
	export RiskIndicators_Main := record
			string8		date_file_loaded;
			string16	transaction_id;
			integer5	phone_id;
			integer5	sequence_number;
			integer5	risk_indicator_id;
			string16	risk_indicator_level;
			string256	risk_indicator_text;
			string32	risk_indicator_category;
			string8		date_added;
			string6		time_added;
	end;
	
	export RiskIndicators_Index := record
			RiskIndicators_Main-date_file_loaded;
	end;
	
	////////////////////////////////////
	//Additional Transactions Indexes///
	////////////////////////////////////
	
	export Transactions_CompanyId := record
			string16 	company_id;
			string8 	transaction_date;
			string16	transaction_id;	
	end;

	export Transactions_CompanyRefCode := record
			string16 	company_id;
			string60	reference_code;
			string8 	transaction_date;
			string16	transaction_id;	
	end;
	
	export Transactions_Date := record
			string8 	transaction_date;
			string16	transaction_id;	
	end;
	
	export Transactions_RefCode := record
			string60	reference_code;
			string8 	transaction_date;
			string16	transaction_id;	
	end;
	
	export Transactions_UserID := record
			string60	user_id;
			string8 	transaction_date;
			string16	transaction_id;	
	end;
	
END;