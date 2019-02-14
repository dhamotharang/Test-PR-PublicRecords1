IMPORT Phonesplus_v2;

EXPORT Layout_common := module

	//Source Reference Review	Layout
	export sourceRefReview_in := record
		string ocn;
		string carrier_name;
		string serv;
		string line;
		string spid;
		string operator_full_name;
		string country;
		string override_file;
		string is_new;
	end;
	
	export sourceRefReview := record
		sourceRefReview_in;
		string255 filename{virtual (logicalfilename)};
	end;
	
	export sourceRefReviewHist := record
		sourceRefReview_in;
		string255 filename;
	end;
	
	//Source Reference Base Layout
	export sourceRefBase := record
		string8 dt_first_reported;
		string8 dt_last_reported;
		string8 dt_start;						//LERG file received
		string8 dt_end;
		string8 ocn;
		string60 carrier_name;
		string60 name;
		string1 serv;
		string1 line;
		string2 prepaid;
		string2 high_risk_indicator;
		unsigned8	activation_dt;
		string5	number_in_service;
		string10 spid;
		string60 operator_full_name;
		boolean is_current;
		string1 override_file;
		string1	data_type;
		string2	ocn_state;
		string4	overall_ocn;
		string4	target_ocn;
		string4	overall_target_ocn;
		string25 ocn_abbr_name;
		string1	rural_lec_indicator;
		string1 small_ilec_indicator;
		string10 category;
		string30 carrier_address1;
		string30 carrier_address2;
		string15 carrier_floor;
		string15 carrier_room;
		string30 carrier_city;
		string2	carrier_state;
		string9	carrier_zip;
		string10 carrier_phone;
		string80 affiliated_to;
		string45 overall_company;
		string20 contact_function;
		string60 contact_name;	
		string30 contact_title;
		string30 contact_address1;
		string30 contact_address2;
		string30 contact_city;
		string2	contact_state;
		string9	contact_zip;
		string10 contact_phone;
		string10 contact_fax;
		string60 contact_email;
		string70 contact_information;
		string10 prim_range;
		string2	predir;
		string28 prim_name;
		string4	addr_suffix;
		string2	postdir;
		string10 unit_desig;
		string8	sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2	st;
		string5	z5;
		string4	zip4;
		string4	cart;
		string1	cr_sort_sz;
		string4	lot;
		string1	lot_order;
		string2	dpbc;
		string1	chk_digit;
		string2	rec_type;
		string2	ace_fips_st;
		string3	fips_county;
		string10 geo_lat;
		string11 geo_long;
		string4	msa;
		string7	geo_blk;
		string1	geo_match;
		string4	err_stat;
		unsigned8 append_rawaid;
		string5 address_type;
		string5 privacy_indicator;
		//string2 country;
	end;
	
	//Ported Base File
	export portedMain := record
		string5			source;
		string2 		phoneType;
		string3   	country_code							:= '';
		string10  	phone;
		string1  		dial_type									:= '';
		string10  	spid											:= '';
		string60		service_provider					:= '';
		string1   	service_type							:= '';
		string10  	routing_code							:= '';
		unsigned8   porting_dt								:= 0;
		string6			porting_time							:= '';
		string2   	country_abbr							:= '';
		unsigned8		vendor_first_reported_dt;
		string6			vendor_first_reported_time:= '';
		unsigned8		vendor_last_reported_dt;
		string6			vendor_last_reported_time:= '';
		unsigned8		port_start_dt;
		string6			port_start_time;
		unsigned8		port_end_dt;
		string6			port_end_time;
		unsigned8   remove_port_dt;
		boolean			is_ported;
	end;
	
	export inFile := record
		string   		reference_id;
	  string10 		phone;
	end;
	
	export lidbSendHistory := record						//BUG203495
		string 			reference_id := '';
		string10 		phone;
		unsigned6		did:=0;
		string8			file_date := '';
	end;

	export lidbSend := record										//BUG203495
		string 			reference_id := '';
		string10 		phone;
	end;

	export lidbRespRecvd := record
		string 			reference_id;
		string10 		phone;
		string3 		reply_code;
		string10 		local_routing_number;
		string4 		account_owner;
		string55 		carrier_name;
		string10 		carrier_category;
		string5 		local_area_transport_area;
		string9 		point_code; 									//3 digits - network; 3 digits - cluster; 3 digits = member
	end;
	
	//LIDB Base Layout
	export lidbRespProcess := record
		string 			reference_id;
		unsigned8 	dt_first_reported;
		unsigned8		dt_last_reported;
		string10 		phone;
		string3 		reply_code;
		string10 		local_routing_number;
		string6 		account_owner;
		string60 		carrier_name;
		string10 		carrier_category;
		string5 		local_area_transport_area;
		string9 		point_code; 								//3 digits - network; 3 digits - cluster; 3 digits = member
		string1 		serv;
		string1 		line;
		string 			spid;
		string			operator_fullname					:= '';
		unsigned8		activation_dt							:= 0;
		string5			number_in_service					:= '';
		string2			high_risk_indicator				:= '';
		string2			prepaid										:= '';
	end;
	
	//Phones Metadata Base Layout
	export portedMetadata_Main := record
		string30 		reference_id							:= '';
		string5			source										:= '';
		unsigned8 	dt_first_reported					:= 0;
		unsigned8		dt_last_reported					:= 0;
		string10 		phone											:= '';
		string2			phonetype									:= '';
		string3 		reply_code								:= '';
		string10 		local_routing_number			:= '';
		string6			account_owner							:= '';
		string60 		carrier_name							:= '';
		string10 		carrier_category					:= '';
		string5 		local_area_transport_area	:= '';
		string10 		point_code								:= ''; 
		string3			country_code							:= '';
		string1			dial_type									:= '';
		string10 		routing_code							:= '';
		unsigned8		porting_dt								:= 0;
		string6			porting_time							:= '';
		string2			country_abbr							:= '';
		unsigned8		vendor_first_reported_dt	:= 0;
		string6			vendor_first_reported_time:= '';
		unsigned8		vendor_last_reported_dt		:= 0;
		string6			vendor_last_reported_time	:= '';
		unsigned8		port_start_dt							:= 0;
		string6			port_start_time						:= '';
		unsigned8		port_end_dt								:= 0;
		string6			port_end_time							:= '';
		unsigned8		remove_port_dt						:= 0;
		boolean			is_ported									:= false;
		string1 		serv											:= '';
		string1 		line											:= '';
		string10 		spid											:= '';
		string60		operator_fullname					:= '';
		string5			number_in_service					:= '';
		string2			high_risk_indicator				:= '';
		string2			prepaid										:= '';
		string10 		phone_swap								:= '';
		unsigned8		swap_start_dt							:= 0;
		string6			swap_start_time						:= '';
		unsigned8		swap_end_dt								:= 0;
		string6			swap_end_time							:= '';
		string2			deact_code								:= '';
		unsigned8		deact_start_dt						:= 0;
		string6			deact_start_time					:= '';
		unsigned8		deact_end_dt							:= 0;
		string6			deact_end_time						:= '';
		unsigned8		react_start_dt						:= 0;
		string6			react_start_time					:= '';
		unsigned8		react_end_dt							:= 0;
		string6			react_end_time						:= '';
		string2			is_deact									:= '';
		string2			is_react									:= '';
		unsigned8		call_forward_dt						:= 0;
		string15		caller_id									:= '';
	end;
	
	//DF-23525: Phones Metadata - Split Key into Transaction & Phone Type
	
	//Phones Transaction Base Layout
	export Phones_Transaction_Main := record
		string10 		phone;
		string5			source;
		string2			transaction_code;
		unsigned8		transaction_dt;
		string6			transaction_time;
		unsigned8		vendor_first_reported_dt;
		string6			vendor_first_reported_time;
		unsigned8		vendor_last_reported_dt;
		string6			vendor_last_reported_time;
		string3			country_code;
		string2			country_abbr;
		string10 		routing_code;
		string1			dial_type;
		string10 		spid;
		string60 		carrier_name;
		string10 		phone_swap;
		unsigned4   global_sid;		//CCPA Requirement
		unsigned8   record_sid;		//CCPA Requirement
	end;
	
	//Phones Type Base Layout
	export Phones_Type_Main := record
		string10 		phone;
		string5			source;
		unsigned8		vendor_first_reported_dt;
		string6			vendor_first_reported_time;
		unsigned8		vendor_last_reported_dt;
		string6			vendor_last_reported_time;
		string30 		reference_id;
		string3 		reply_code;
		string10 		local_routing_number;
		string6			account_owner;
		string60 		carrier_name;
		string10 		carrier_category;
		string5 		local_area_transport_area;
		string10 		point_code; 
		string1 		serv;
		string1 		line;
		string10 		spid;
		string60		operator_fullname;
		string2			high_risk_indicator;
		string2			prepaid;
		unsigned4   global_sid;		//CCPA Requirement
		unsigned8   record_sid;		//CCPA Requirement
	end;

end;