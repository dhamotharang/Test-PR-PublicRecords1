import Phonesplus_v2;

EXPORT Layout_common := module

	export sourceRefIn := record
		string 			OCN_Master;
		string 			Carrier_Name;
		string 			Serv;
		string 			Line;
		string      Prepaid;
		string 			High_Risk_Indicator;
		string 			Spid;								//IConectiv
		string 			Operator_Full_Name; //IConectiv Name
		string 			OCN;
	end;
	
	export sourceRefBase_temp := record
		string8 dt_first_reported;
		string8 dt_last_reported;
		string8 dt_start;
		string8 dt_end;
		string  ocn;
		string  carrier_name;
		string  name;
		string1 serv;
		string1 line;
		string2 prepaid;
		string2 high_risk_indicator;
		string  spid;
		string  operator_full_name;
		boolean is_current;
	end;
	
	export sourceRefBase := record
		string8 dt_first_reported;
		string8 dt_last_reported;
		string8 dt_start;
		string8 dt_end;
		string8  ocn;
		string60  carrier_name;
		string60  name;
		string1 serv;
		string1 line;
		string2 prepaid;
		string2 high_risk_indicator;
		unsigned8	activation_dt;
		string5	number_in_service;
		string10  spid;
		string  operator_full_name;
		boolean is_current;
	end;
	
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
	/*unsigned6 	did 							:= 0;
		string20  	lname;
		unsigned6		bdid							:= 0;
		string120 	listed_name;*/
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
		
	export lidbRespProcess := record
		string 			reference_id;
		unsigned8 	dt_first_reported;
		unsigned8		dt_last_reported;
		//unsigned8		dt_start;	
		//unsigned8		dt_end;
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
		//boolean		is_current 					:= false;
	end;
	
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
		//string1Â Â  	service_type
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
		string60		subpoena_company_name			:= '';
		string60		subpoena_contact_name			:= '';
		string60		subpoena_carrier_address	:= '';
		string20		subpoena_carrier_city			:= '';
		string20		subpoena_carrier_state		:= '';
		string5			subpoena_carrier_zip			:= '';
		string30		subpoena_email						:= '';
		string10 		subpoena_contact_phone		:= '';
		string10 		subpoena_contact_fax			:= '';
end;

end;