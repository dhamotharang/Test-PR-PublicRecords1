EXPORT PhonesMetadata := module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20090706';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

	export rthor_data400_key_phones_ported_metadata := RECORD
		string10 phone;
		string30 reference_id;
		string5 source;
		unsigned8 dt_first_reported;
		unsigned8 dt_last_reported;
		string2 phonetype;
		string3 reply_code;
		string10 local_routing_number;
		string6 account_owner;
		string60 carrier_name;
		string10 carrier_category;
		string5 local_area_transport_area;
		string10 point_code;
		string3 country_code;
		string1 dial_type;
		string10 routing_code;
		unsigned8 porting_dt;
		string6 porting_time;
		string2 country_abbr;
		unsigned8 vendor_first_reported_dt;
		string6 vendor_first_reported_time;
		unsigned8 vendor_last_reported_dt;
		string6 vendor_last_reported_time;
		unsigned8 port_start_dt;
		string6 port_start_time;
		unsigned8 port_end_dt;
		string6 port_end_time;
		unsigned8 remove_port_dt;
		boolean is_ported;
		string1 serv;
		string1 line;
		string10 spid;
		string60 operator_fullname;
		string5 number_in_service;
		string2 high_risk_indicator;
		string2 prepaid;
		string10 phone_swap;
		unsigned8 swap_start_dt;
		string6 swap_start_time;
		unsigned8 swap_end_dt;
		string6 swap_end_time;
		string2 deact_code;
		unsigned8 deact_start_dt;
		string6 deact_start_time;
		unsigned8 deact_end_dt;
		string6 deact_end_time;
		unsigned8 react_start_dt;
		string6 react_start_time;
		unsigned8 react_end_dt;
		string6 react_end_time;
		string2 is_deact;
		string2 is_react;
		unsigned8 call_forward_dt;
		string15 caller_id;
		string60 subpoena_company_name;
		string60 subpoena_contact_name;
		string60 subpoena_carrier_address;
		string20 subpoena_carrier_city;
		string20 subpoena_carrier_state;
		string5 subpoena_carrier_zip;
		string30 subpoena_email;
		string10 subpoena_contact_phone;
		string10 subpoena_contact_fax;
		unsigned8 __internal_fpos__;
	END;

	export dthor_data400_key_phones_ported_metadata := dataset([], rthor_data400_key_phones_ported_metadata);

	export rthor_data400_key_phones_metadata_carrier_reference := RECORD
		string8 ocn;
		string60 name;
		string8 dt_first_reported;
		string8 dt_last_reported;
		string8 dt_start;
		string8 dt_end;
		string60 carrier_name;
		string1 serv;
		string1 line;
		string2 prepaid;
		string2 high_risk_indicator;
		unsigned8 activation_dt;
		string5 number_in_service;
		string10 spid;
		string operator_full_name;
		boolean is_current;
		unsigned8 __internal_fpos__;
	END;

	export dthor_data400_key_phones_metadata_carrier_reference := dataset([], rthor_data400_key_phones_metadata_carrier_reference);
	
end;