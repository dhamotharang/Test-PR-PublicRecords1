EXPORT Mapping_Common_OTP(string8 version) := FUNCTION

//exclude otp_id='' - 20160707 phone meeting
inFile := PhoneFraud.File_OTP.Raw(trim(_Functions.rmNull(otp_id), left, right)<>'');

	PhoneFraud.Layout_OTP.Base fixFields(inFile l):= transform
		self.date_file_loaded				:= version[1..8];
		self.transaction_id 				:= _Functions.rmPipe(_Functions.rmNull(l.transaction_id));
		
		//split event time from date
		self.event_date 						:= _Functions.clNum(l.event_time)[1..8];
		self.event_time							:= _Functions.clNum(l.event_time)[9..];
		
		self.function_name 					:= _Functions.rmNull(l.function_name);
		self.account_id 						:= _Functions.rmNull(l.account_id);
		self.subject_id 						:= _Functions.rmNull(l.subject_id);
		self.customer_subject_id 		:= _Functions.rmNull(l.customer_subject_id);
		self.otp_id 								:= _Functions.rmNull(l.otp_id);
		self.verify_passed 					:= l.verify_passed;
		self.otp_delivery_method 		:= _Functions.rmNull(l.otp_delivery_method);
		self.otp_preferred_delivery := _Functions.rmNull(l.otp_preferred_delivery);
		self.otp_phone 							:= _Functions.clNum(l.otp_phone);
		self.otp_email 							:= _Functions.rmNull(l.otp_email);
		self.reference_code 				:= stringlib.stringtouppercase(_Functions.rmNull(l.reference_code));
		self.product_id 						:= l.product_id;
		self.sub_product_id 				:= l.sub_product_id;
		self.subject_unique_id 			:= stringlib.stringtouppercase(_Functions.rmNull(l.subject_unique_id));
		self.first_name 						:= stringlib.stringtouppercase(_Functions.rmNull(l.first_name));
		self.last_name 							:= stringlib.stringtouppercase(_Functions.rmNull(l.last_name));
		self.country 								:= stringlib.stringtouppercase(_Functions.rmNull(l.country));
		self.state 									:= _Functions.clAlph(_Functions.rmNull(l.state));
		self.otp_type 							:= _Functions.rmNull(l.otp_type);
		self.otp_length 						:= l.otp_length;
		self.mobile_phone 					:= _Functions.clNum(l.mobile_phone);
		self.mobile_phone_country 	:= _Functions.clAlph(_Functions.rmNull(l.mobile_phone_country));
		self.mobile_phone_carrier 	:= _Functions.rmNull(l.mobile_phone_carrier);
		self.work_phone 						:= _Functions.clNum(l.work_phone);
		self.work_phone_country 		:= _Functions.clAlph(_Functions.rmNull(l.work_phone_country));
		self.home_phone 						:= _Functions.clNum(l.home_phone);
		self.home_phone_country 		:= _Functions.clAlph(_Functions.rmNull(l.home_phone_country));
		self.otp_language 					:= _Functions.clAlph(_Functions.rmNull(l.otp_language));
		
		//split date added from time
		self.date_added 						:= _Functions.clNum(l.date_added)[1..8];
		self.time_added 						:= _Functions.clNum(l.date_added)[9..];
		self         								:= l;
	END;
	
	cmnMap 			:= project(inFile, fixFields(left));
	
//Populate Phone If Available
	srt_phone 	:= sort(distribute(cmnMap, hash(otp_id)), otp_id, event_date+event_time, otp_phone, local);
		
	PhoneFraud.Layout_OTP.Base fixFields2(srt_phone l, srt_phone r):= transform
		self.otp_phone := if(trim(l.otp_phone, left, right)='', trim(r.otp_phone, left, right), l.otp_phone);	
		self := l;
	END;
	
	fixField 		:= join(srt_phone(otp_phone=''), srt_phone(otp_phone<>''),
											left.otp_id = right.otp_id and
											left.event_date = right.event_date,
											fixFields2(left, right), left outer, local);
	
	concatF			:= fixField+cmnMap(otp_phone<>'');	
	concatFile	:= concatF+ PhoneFraud.File_OTP.Base;	//-20200921 change to delta update
    //concatFile	:= join(concatF, distribute(PhoneFraud.File_OTP.Base, hash(transaction_id)), left.transaction_id = right.transaction_id, left only);
	ddConcat 		:= dedup(sort(distribute(concatFile, hash(transaction_id)), transaction_id, date_file_loaded, local), transaction_id, local) - PhoneFraud.File_OTP.Base;
	
	RETURN ddConcat;

END;