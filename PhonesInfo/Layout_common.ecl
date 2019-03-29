IMPORT dx_PhonesInfo, Phonesplus_v2;

	//DF-23525: Phones Metadata - Split Key into Transaction & Phone Type
	//DF-24397: Create Dx-Prefixed Keys

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
	
	//Carrier Reference Layout
	//dx_PhonesInfo.Layout.sourceRefBase
	
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
	
	//Phones Transaction Base Layout
	//dx_PhonesInfo.Layouts.Phones_Transaction_Main;
	
	//Phones Type Base Layout
	//dx_PhonesInfo.Layouts.Phones_Type_Main;

end;