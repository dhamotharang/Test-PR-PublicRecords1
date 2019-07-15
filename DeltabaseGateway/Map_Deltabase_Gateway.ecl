IMPORT MDR, PhonesInfo, Std;

EXPORT Map_Deltabase_Gateway(string8 version) := FUNCTION

inFile 				:= DeltabaseGateway.File_Deltabase_Gateway.Historic_Results_Raw;

	DeltabaseGateway.Layout_Deltabase_Gateway.Historic_Results_Base fixFields(inFile l):= transform
		self.date_file_loaded							:= version[1..8];
		self.batch_job_id 								:= DeltabaseGateway._Functions.rmNull(trim(l.batch_job_id, left, right));
		self.sequence_number 							:= DeltabaseGateway._Functions.rmNull(trim(l.sequence_number, left, right));
		self.source 											:= DeltabaseGateway._Functions.rmNull(stringlib.stringtouppercase(trim(l.source, left, right)));
		self.vendor_transaction_id 				:= DeltabaseGateway._Functions.rmNull(stringlib.stringtouppercase(trim(l.vendor_transaction_id, left, right)));
		self.submitted_phonenumber 				:= DeltabaseGateway._Functions.rmNull(trim(l.submitted_phonenumber, left, right));
		self.optin_type 									:= DeltabaseGateway._Functions.rmNull(trim(l.optin_type, left, right));
		self.optin_method 								:= DeltabaseGateway._Functions.rmNull(trim(l.optin_method, left, right));
		self.optin_duration 							:= DeltabaseGateway._Functions.rmNull(trim(l.optin_duration, left, right));
		self.optin_id											:= DeltabaseGateway._Functions.rmNull(trim(l.optin_id, left, right));
		self.optin_version_id							:= DeltabaseGateway._Functions.rmNull(trim(l.optin_version_id, left, right));
		self.optin_timestamp 							:= stringlib.stringfilter(DeltabaseGateway._Functions.rmNull(trim(l.optin_timestamp, left, right)), '0123456789');
		self.result_phonenumber 					:= DeltabaseGateway._Functions.rmNull(trim(l.result_phonenumber, left, right));
		self.device_onetime_id 						:= DeltabaseGateway._Functions.rmNull(trim(l.device_onetime_id, left, right));
		self.device_session_id 						:= DeltabaseGateway._Functions.rmNull(trim(l.device_session_id, left, right));
		self.first_name 									:= DeltabaseGateway._Functions.rmNull(trim(l.first_name, left, right));
		self.middle_name 									:= DeltabaseGateway._Functions.rmNull(trim(l.middle_name, left, right));
		self.last_name 										:= DeltabaseGateway._Functions.rmNull(trim(l.last_name, left, right));
		self.business_name 								:= DeltabaseGateway._Functions.rmNull(trim(l.business_name, left, right));
		self.full_name 										:= DeltabaseGateway._Functions.rmNull(trim(l.full_name, left, right));
		self.ln_match_code 								:= DeltabaseGateway._Functions.rmNull(trim(l.ln_match_code, left, right));
		self.prim_range 									:= DeltabaseGateway._Functions.rmNull(trim(l.prim_range, left, right));
		self.predir 											:= DeltabaseGateway._Functions.rmNull(trim(l.predir, left, right));
		self.prim_name 										:= DeltabaseGateway._Functions.rmNull(trim(l.prim_name, left, right));
		self.addr_suffix 									:= DeltabaseGateway._Functions.rmNull(trim(l.addr_suffix, left, right));
		self.postdir 											:= DeltabaseGateway._Functions.rmNull(trim(l.postdir, left, right));
		self.unit_desig 									:= DeltabaseGateway._Functions.rmNull(trim(l.unit_desig, left, right));
		self.sec_range 										:= DeltabaseGateway._Functions.rmNull(trim(l.sec_range, left, right));
		self.city 												:= DeltabaseGateway._Functions.rmNull(trim(l.city, left, right));
		self.state 												:= DeltabaseGateway._Functions.rmNull(trim(l.state, left, right));
		self.zip 													:= DeltabaseGateway._Functions.rmNull(trim(l.zip, left, right));
		self.zip4 												:= DeltabaseGateway._Functions.rmNull(trim(l.zip4, left, right));
		self.county 											:= DeltabaseGateway._Functions.rmNull(trim(l.county, left, right));
		self.country 											:= DeltabaseGateway._Functions.rmNull(trim(l.country, left, right));
		self.imsi 												:= DeltabaseGateway._Functions.rmNull(trim(l.imsi, left, right));
		self.imsi_seensince 							:= DeltabaseGateway._Functions.rmNull(trim(l.imsi_seensince, left, right));
		self.imsi_trackedsince 						:= stringlib.stringfilter(DeltabaseGateway._Functions.rmNull(trim(l.imsi_trackedsince, left, right)), '0123456789')[1..8];
		self.iccid 												:= DeltabaseGateway._Functions.rmNull(trim(l.iccid, left, right));
		self.subscriber_id 								:= DeltabaseGateway._Functions.rmNull(trim(l.subscriber_id, left, right));
		self.call_forwarding_linked_toSubject  	:= DeltabaseGateway._Functions.rmNull(trim(l.call_forwarding_linked_toSubject, left, right));
		self.line_type 										:= DeltabaseGateway._Functions.rmNull(trim(l.line_type, left, right));
		self.carrier_name 								:= DeltabaseGateway._Functions.rmNull(trim(l.carrier_name, left, right));
		self.carrier_original_name 				:= DeltabaseGateway._Functions.rmNull(trim(l.carrier_original_name, left, right));
		self.carrier_category 						:= DeltabaseGateway._Functions.rmNull(trim(l.carrier_category, left, right));
		self.carrier_ocn 									:= DeltabaseGateway._Functions.rmNull(trim(l.carrier_ocn, left, right));
		self.carrier_mcc 									:= DeltabaseGateway._Functions.rmNull(trim(l.carrier_mcc, left, right));
		self.carrier_mnc 									:= DeltabaseGateway._Functions.rmNull(trim(l.carrier_mnc, left, right));
		self.lrn 													:= DeltabaseGateway._Functions.rmNull(trim(l.lrn, left, right));
		self.device_make 									:= DeltabaseGateway._Functions.rmNull(trim(l.device_make, left, right));
		self.device_model 								:= DeltabaseGateway._Functions.rmNull(trim(l.device_model, left, right));
		self.device_type 									:= DeltabaseGateway._Functions.rmNull(trim(l.device_type, left, right));
		self.deviceOS 										:= DeltabaseGateway._Functions.rmNull(trim(l.deviceOS, left, right));
		self.imei 												:= DeltabaseGateway._Functions.rmNull(trim(l.imei, left, right));
		self.imei_type 										:= DeltabaseGateway._Functions.rmNull(trim(l.imei_type, left, right));
		self.imei_seensince 							:= DeltabaseGateway._Functions.rmNull(trim(l.imei_seensince, left, right));
		self.imei_tracked_since 					:= DeltabaseGateway._Functions.rmNull(trim(l.imei_tracked_since, left, right));
		self.cnm_availability_indicator 	:= DeltabaseGateway._Functions.rmNull(trim(l.cnm_availability_indicator, left, right));
		self.cnm_presentation_indicator 	:= DeltabaseGateway._Functions.rmNull(trim(l.cnm_presentation_indicator, left, right));
		self.port_date 										:= stringlib.stringfilter(DeltabaseGateway._Functions.rmNull(trim(l.port_date, left, right)), '0123456789')[1..8];
		self.port_time										:= stringlib.stringfilter(DeltabaseGateway._Functions.rmNull(trim(l.port_date, left, right)), '0123456789')[9..];
		self.lata 												:= DeltabaseGateway._Functions.rmNull(trim(l.lata, left, right));
		self.reply_code 									:= DeltabaseGateway._Functions.rmNull(trim(l.reply_code, left, right));
		self.point_code 									:= DeltabaseGateway._Functions.rmNull(trim(l.point_code, left, right));
		self.prepaid 											:= DeltabaseGateway._Functions.rmNull(trim(l.prepaid, left, right));
		self.account_status 							:= DeltabaseGateway._Functions.rmNull(trim(l.account_status, left, right));
		self.language 										:= DeltabaseGateway._Functions.rmNull(trim(l.language, left, right));
		self.tele_type 										:= DeltabaseGateway._Functions.rmNull(trim(l.tele_type, left, right));
		self.bill_block 									:= DeltabaseGateway._Functions.rmNull(trim(l.bill_block, left, right));
		self.purchase_block 							:= DeltabaseGateway._Functions.rmNull(trim(l.purchase_block, left, right));
		self.loc_latitude 								:= DeltabaseGateway._Functions.rmNull(trim(l.loc_latitude, left, right));
		self.loc_longitude 								:= DeltabaseGateway._Functions.rmNull(trim(l.loc_longitude, left, right));
		self.loc_address 									:= DeltabaseGateway._Functions.rmNull(trim(l.loc_address, left, right));
		self.loc_accuracy 								:= DeltabaseGateway._Functions.rmNull(trim(l.loc_accuracy, left, right));
		self.sub_name_type								:= DeltabaseGateway._Functions.rmNull(trim(l.sub_name_type, left, right));
		self.sub_first_name 							:= DeltabaseGateway._Functions.rmNull(trim(l.sub_first_name, left, right));
		self.sub_last_name 								:= DeltabaseGateway._Functions.rmNull(trim(l.sub_last_name, left, right));
		self.sub_addr_type 								:= DeltabaseGateway._Functions.rmNull(trim(l.sub_addr_type, left, right));
		self.sub_addr1 										:= DeltabaseGateway._Functions.rmNull(trim(l.sub_addr1, left, right));
		self.sub_addr2 										:= DeltabaseGateway._Functions.rmNull(trim(l.sub_addr2, left, right));
		self.sub_city											:= DeltabaseGateway._Functions.rmNull(trim(l.sub_city, left, right));
		self.sub_state 										:= DeltabaseGateway._Functions.rmNull(trim(l.sub_state, left, right));
		self.sub_postal_code 							:= DeltabaseGateway._Functions.rmNull(trim(l.sub_postal_code, left, right));
		self.sub_country 									:= DeltabaseGateway._Functions.rmNull(trim(l.sub_country, left, right));
		self.customer_bill_acct_type 			:= DeltabaseGateway._Functions.rmNull(trim(l.customer_bill_acct_type, left, right));
		self.customer_bill_acct 					:= DeltabaseGateway._Functions.rmNull(trim(l.customer_bill_acct, left, right));
		self.device_mgmt_status 					:= DeltabaseGateway._Functions.rmNull(trim(l.device_mgmt_status, left, right));
		self.sub_business_name						:= DeltabaseGateway._Functions.rmNull(trim(l.sub_business_name, left, right));
		self.sub_email_address						:= DeltabaseGateway._Functions.rmNull(trim(l.sub_email_address, left, right));
		self.date_added										:= stringlib.stringfilter(l.date_added, '0123456789')[1..8];
		self.time_added										:= stringlib.stringfilter(l.date_added, '0123456789')[9..];
		self.iccid_seensince							:= stringlib.stringfilter(DeltabaseGateway._Functions.rmNull(trim(l.iccid_seensince, left, right)), '0123456789')[1..8];
		self.iccid_seensince_time					:= stringlib.stringfilter(DeltabaseGateway._Functions.rmNull(trim(l.iccid_seensince, left, right)), '0123456789')[9..];
		self.imsi_changedate							:= stringlib.stringfilter(DeltabaseGateway._Functions.rmNull(trim(l.imsi_changedate, left, right)), '0123456789')[1..8];
		self.imsi_activationdate					:= stringlib.stringfilter(DeltabaseGateway._Functions.rmNull(trim(l.imsi_activationdate, left, right)), '0123456789')[1..8];
		self.imei_changedate							:= stringlib.stringfilter(DeltabaseGateway._Functions.rmNull(trim(l.imei_changedate, left, right)), '0123456789')[1..8];
		self.loststolen_date							:= stringlib.stringfilter(DeltabaseGateway._Functions.rmNull(trim(l.loststolen_date, left, right)), '0123456789')[1..8];
		self 															:= l;
	end;
	
	cmnMap 			:= project(inFile, fixFields(left));
	
	//Concat current file with previous base
	concatFile	:= cmnMap + DeltabaseGateway.File_Deltabase_Gateway.Historic_Results_Base;	
	
	//Dedup logic used differs by source
	ddCC				:= dedup(sort(distribute(concatFile(std.str.find(source, 'ZUMIGO', 1)=0), hash(submitted_phonenumber)), submitted_phonenumber, source, -(date_added+time_added), -transaction_id, local), submitted_phonenumber, source, date_file_loaded, local);																									//Unique phones by source; Latest record kept.
	ddCCZum			:= dedup(sort(distribute(concatFile(std.str.find(source, 'ZUMIGO', 1)>0), hash(submitted_phonenumber)), submitted_phonenumber, source, -(date_added+time_added), -transaction_id, sequence_number, local), submitted_phonenumber, source, transaction_id, sequence_number, date_file_loaded, local);//Multiple records per phone. 
	ddConcat 		:= ddCC + ddCCZum;

	RETURN ddConcat;

END;