﻿//DF-26089: Deltabase Gateway History Add Additional Fields

EXPORT Layout_Deltabase_Gateway := MODULE

	export Historic_Results_Raw := record
			string transaction_id;
			string batch_job_id;
			string sequence_number;
			string source;
			string vendor_transaction_id;
			string submitted_phonenumber;
			string optin_type;
			string optin_method;
			string optin_duration;
			string optin_id;
			string optin_version_id;
			string optin_timestamp;
			string result_phonenumber;
			string device_onetime_id;
			string device_session_id;
			integer lexid;
			integer busult_id;
			integer busorg_id;
			integer bussele_id;
			integer busprox_id;
			integer buspow_id;
			integer busemp_id;
			integer busdot_id;
			string first_name;
			string middle_name;
			string last_name;
			string business_name;
			string full_name;
			string ln_match_code;
			integer email_rec_key;
			string prim_range;
			string predir;
			string prim_name;
			string addr_suffix;
			string postdir;
			string unit_desig;
			string sec_range;
			string city;
			string state;
			string zip;
			string zip4;
			string county;
			string country;
			string imsi;
			string imsi_seensince;
			integer imsi_changedthis_time;
			integer imsi_change_count;
			string imsi_trackedsince;
			string iccid;
			string subscriber_id;
			integer call_forwarding;
			string call_forwarding_linked_toSubject;
			string line_type;
			string carrier_name;
			string carrier_original_name;
			string carrier_category;
			string carrier_ocn;
			string carrier_mcc;
			string carrier_mnc;
			integer carrier_identity_supported;
			integer carrier_location_supported;
			string lrn;
			string device_make;
			string device_model;
			string device_type;
			string deviceOS;
			string imei;
			string imei_type;
			string imei_seensince;
			integer imei_changed_this_time;
			integer imei_change_count;
			string imei_tracked_since;
			integer first_name_score;
			integer last_name_score;
			integer addr_score;
			string cnm_availability_indicator;
			string cnm_presentation_indicator;
			string port_date;
			string lata;
			string reply_code;
			string point_code;
			string prepaid;
			string account_status;
			string language;
			string tele_type;
			string bill_block;
			string purchase_block;
			string loc_latitude;
			string loc_longitude;
			string loc_address;
			string loc_accuracy;
			integer sub_position;
			integer sub_lexid;
			integer sub_busult_id;
			integer sub_busorg_id;
			integer sub_bussele_id;
			integer sub_busprox_id;
			integer sub_buspow_id;
			integer sub_busemp_id;
			integer sub_busdot_id;
			string sub_name_type;
			string sub_first_name;
			string sub_last_name;
			string sub_addr_type;
			string sub_addr1;
			string sub_addr2;
			string sub_city;
			string sub_state;
			string sub_postal_code;
			string sub_country;
			string customer_bill_acct_type;
			string customer_bill_acct;
			string device_mgmt_status;
			string sub_business_name;
			string date_added;
			string sub_email_address;
			integer billing_first_name_score;
			integer billing_last_name_score;
			integer business_name_score;
			integer email_address_score;
			string iccid_seensince;
			integer iccid_changedthis_time;
			string imsi_changedate;
			string imsi_activationDate;
			string imei_changedate;
			integer loststolen;
			string loststolen_date;
			string account_activation_date;
			string line_activation_date;
			string imei_activationdate;
			integer acct_tenure_min;
	end;
	
	export Historic_Results_Base := record
			string8		date_file_loaded;
			string20	transaction_id;
			string20	batch_job_id;
			string20	sequence_number;
			string20	source;
			string100	vendor_transaction_id;
			string15	submitted_phonenumber;
			string25	optin_type;
			string25	optin_method;
			string25	optin_duration;
			string25	optin_id;
			string25	optin_version_id;
			string50	optin_timestamp;
			string15	result_phonenumber;
			string100	device_onetime_id;
			string100	device_session_id;
			integer5	lexid;
			integer5	busult_id;
			integer5	busorg_id;
			integer5	bussele_id;
			integer5	busprox_id;
			integer5	buspow_id;
			integer5	busemp_id;
			integer5	busdot_id;
			string20	first_name;
			string20	middle_name;
			string20	last_name;
			string120	business_name;
			string120	full_name;
			string10	ln_match_code;
			integer5	email_rec_key;
			string10	prim_range;
			string2		predir;
			string28	prim_name;
			string4		addr_suffix;
			string2		postdir;
			string10	unit_desig;
			string8		sec_range;
			string25	city;
			string2		state;
			string5		zip;
			string4		zip4;
			string20	county;
			string20	country;
			string100	imsi;
			string20	imsi_seensince;
			integer1	imsi_changedthis_time;
			string20	imsi_changedate;
			integer5	imsi_change_count;
			string20	imsi_trackedsince;
			string20	imsi_activationdate;
			integer5  imsi_tenure_mindays;
			integer5  imsi_tenure_maxdays;
			string100	iccid;
			string8		iccid_seensince;
			string6		iccid_seensince_time;
			integer1	iccid_changedthis_time;
			string100	subscriber_id;
			integer1	call_forwarding;
			string10	call_forwarding_linked_tosubject;
			string20	line_type;
			string120	carrier_name;
			string120	carrier_original_name;
			string20	carrier_category;
			string20	carrier_ocn;
			string20	carrier_mcc;
			string20	carrier_mnc;
			integer1	carrier_identity_supported;
			integer1	carrier_location_supported;
			string20	lrn;
			string20	device_make;
			string20	device_model;
			string20	device_type;
			string20	deviceos;
			string100	imei;
			string20	imei_type;
			string20	imei_seensince;
			integer1	imei_changed_this_time;
			string20	imei_changedate;
			integer5	imei_change_count;
			string20	imei_tracked_since;
			string20	imei_activationdate;
			integer5	imei_tenure_mindays;
			integer5  imei_tenure_maxdays;
			integer5  sim_tenure_mindays;
			integer5  sim_tenure_maxdays; 
			integer5	first_name_score;
			integer5	last_name_score;
			integer5	addr_score;
			string10	cnm_availability_indicator;
			string10	cnm_presentation_indicator;
			string8		port_date;
			string6		port_time;
			string10	lata;
			string10	reply_code;
			string10	point_code;
			string10	prepaid;
			string10	account_status;
			string10	language;
			string10	tele_type;
			string10	bill_block;
			string10	purchase_block;
			string10	loc_latitude;
			string10	loc_longitude;
			string50	loc_address;
			string10	loc_accuracy;
			integer5	sub_position;
			integer5	sub_lexid;
			integer5	sub_busult_id;
			integer5	sub_busorg_id;
			integer5	sub_bussele_id;
			integer5	sub_busprox_id;
			integer5	sub_buspow_id;
			integer5	sub_busemp_id;
			integer5	sub_busdot_id;
			string50	sub_name_type;
			string20	sub_first_name;
			string20	sub_last_name;
			string50	sub_addr_type;
			string120	sub_addr1;
			string25	sub_addr2;
			string25	sub_city;
			string2		sub_state;
			string5		sub_postal_code;
			string50	sub_country;
			string120	sub_business_name;
			string50	sub_email_address;
			string10	customer_bill_acct_type;
			string25	customer_bill_acct;
			string100	device_mgmt_status;
			integer5	billing_first_name_score;
			integer5	billing_last_name_score;
			integer5	business_name_score;
			integer5	email_address_score;
			integer1	loststolen;
			string20	loststolen_date;
			string8		account_activation_date;
			integer5  acct_tenure_min;
			string8   line_activation_date;
			string8		date_added;
			string6		time_added;
	end;	
	
END;