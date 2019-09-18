EXPORT fn_dedup_delta(inputs):=FUNCTIONMACRO
	IMPORT ut;
	in_srt := sort(inputs, customer_id,transaction_id,Date_of_Transaction,Household_ID,Customer_Person_ID,Customer_Program,Reason_for_Transaction_Activity,inquiry_source,customer_county,customer_state,customer_agency_vertical_type,ssn,dob,Rawlinkid,raw_full_name,raw_title,raw_first_name,raw_middle_name,raw_last_name,raw_Orig_Suffix,full_address,street_1,city,state,zip,county,mailing_street_1,mailing_city,mailing_state,mailing_zip,mailing_county,phone_number,ultid,orgid,seleid,tin,Email_Address,appended_provider_id,lnpid,npi,ip_address,device_id,professional_id,bank_routing_number_1,bank_account_number_1,Drivers_License_State,Drivers_License,geo_lat,geo_long,file_type,deceitful_confidence,reason_description,event_type_1,event_entity_1, reported_by, reported_date);

	new_rec := record
		inputs;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen; 
		unsigned4 dt_vendor_last_reported; 
		unsigned4 dt_vendor_first_reported;
	end;
	new_rec RollupUpdate(new_rec l, new_rec r) := 
	transform
		SELF.source_rec_id := if(l.source_rec_id < r.source_rec_id,l.source_rec_id, r.source_rec_id); // leave always previous source_rec_id 
		SELF.process_date := if(l.process_date < r.process_date,l.process_date, r.process_date); // leave always previous Process_Date
		SELF.filedate := ut.EarliestDate(l.FileDate, r.FileDate); // leave always previous Process_Date
		SELF.filename := if(l.FileDate < r.FileDate,l.filename, r.filename); // leave always previous Filename
		SELF.InqLog_ID := if(l.InqLog_ID < r.InqLog_ID,l.InqLog_ID, r.InqLog_ID); // leave always previous InqLog_ID
		SELF.dt_first_seen := ut.EarliestDate(l.Process_Date,r.Process_Date); 
		SELF.dt_last_seen := max(l.Process_Date,r.Process_Date);
		SELF.dt_vendor_last_reported := max(l.FileDate, r.FileDate);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.FileDate, r.FileDate);
		self := l;
	end;

	in_ddp := rollup( project(in_srt, transform(new_rec, 
		 self.dt_first_seen:= left.Process_Date; 
		 self.dt_last_seen:= left.Process_Date; 
		 self.dt_vendor_last_reported:= left.FileDate; 
		 self.dt_vendor_first_reported:= left.FileDate;		 
		 self := left))
		,RollupUpdate(left, right)
		,customer_id,transaction_id,Date_of_Transaction,Household_ID,Customer_Person_ID,Customer_Program,Reason_for_Transaction_Activity,inquiry_source,customer_county,customer_state,customer_agency_vertical_type,ssn,dob,Rawlinkid,raw_full_name,raw_title,raw_first_name,raw_middle_name,raw_last_name,raw_Orig_Suffix,full_address,street_1,city,state,zip,county,mailing_street_1,mailing_city,mailing_state,mailing_zip,mailing_county,phone_number,ultid,orgid,seleid,tin,Email_Address,appended_provider_id,lnpid,npi,ip_address,device_id,professional_id,bank_routing_number_1,bank_account_number_1,Drivers_License_State,Drivers_License,geo_lat,geo_long,file_type,deceitful_confidence,reason_description,event_type_1,event_entity_1,reported_by,STD.Str.FindReplace( STD.Str.FindReplace( reported_date,':',''),'-','')[1..8]
	);

	return in_ddp;
ENDMACRO;