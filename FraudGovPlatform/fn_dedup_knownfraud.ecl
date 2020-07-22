EXPORT fn_dedup_knownfraud(inputs):=FUNCTIONMACRO
    IMPORT ut;
    in_srt := sort(inputs , Customer_Id, Customer_State, Customer_Agency_Vertical_Type, Customer_Program,reported_date, reported_time,
    reported_by,event_date,event_end_date,event_location,event_type_1,event_type_2,event_type_3,Household_ID,Customer_Person_ID,
    head_of_household_indicator,relationship_indicator,Rawlinkid,raw_Title,raw_First_name,raw_Middle_Name,raw_Last_Name,
    raw_Orig_Suffix,raw_Full_Name,name_risk_code,ssn,ssn_risk_code,dob,dob_risk_code,Drivers_License,Drivers_License_State,
    drivers_license_risk_code,street_1,street_2,city,state,zip,physical_address_risk_code,mailing_street_1,mailing_street_2,
    mailing_city,mailing_state,mailing_zip,mailing_address_risk_code,address_date,address_type,county,phone_number,phone_risk_code,
    cell_phone,cell_phone_risk_code,work_phone,work_phone_risk_code,contact_type,contact_date,carrier,contact_location,contact,
    call_records,in_service,email_address,email_address_risk_code,email_address_type,email_date,host,alias,location,ip_address,
    ip_address_fraud_code,ip_address_date,version,isp,device_id,device_date,device_risk_code,Unique_number,MAC_Address,serial_number,
    device_type,device_identification_provider,bank_routing_number_1,bank_account_number_1,bank_account_1_risk_code,
    bank_routing_number_2,bank_account_number_2,bank_account_2_risk_code,appended_provider_id,business_name,tin,fein,npi,
    tax_preparer_id,business_type_1,business_date,business_risk_code,Customer_Program,start_date,end_date,amount_paid,region_code,
    investigator_id,reason_description,investigation_referral_case_id,investigation_referral_date_opened,
    investigation_referral_date_closed,customer_fraud_code_1,customer_fraud_code_2,type_of_referral,referral_reason,disposition,
    mitigated,mitigated_amount,external_referral_or_casenumber,cleared_fraud,reason_cleared_code,source, rin_source, source_rec_id); // -customer_event_id

    new_rec := record
		inputs;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen; 
		unsigned4 dt_vendor_last_reported; 
		unsigned4 dt_vendor_first_reported;
	end;
    
    {new_rec} RollupUpdate({new_rec} l, {new_rec} r) := 
    transform
        SELF.source_rec_id := if(l.source_rec_id < r.source_rec_id,l.source_rec_id, r.source_rec_id); // leave always previous Unique_Id 
        SELF.process_date := if(l.process_date < r.process_date,l.process_date, r.process_date);        
		SELF.dt_first_seen := ut.EarliestDate(l.Process_Date,r.Process_Date); 
		SELF.dt_last_seen := max(l.Process_Date,r.Process_Date);
		SELF.dt_vendor_last_reported := max(l.FileDate, r.FileDate);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.FileDate, r.FileDate);
		SELF.filedate := ut.EarliestDate(l.FileDate, r.FileDate); // leave always previous Process_Date
		SELF.filename := if(l.FileDate < r.FileDate,l.filename, r.filename); // leave always previous Filename
        self := l;
    end;

    in_ddp := rollup( 
        project(in_srt, transform(new_rec, 
            self.dt_first_seen:= left.Process_Date; 
            self.dt_last_seen:= left.Process_Date; 
            self.dt_vendor_last_reported:= left.FileDate; 
            self.dt_vendor_first_reported:= left.FileDate;		 
            self := left))
        ,RollupUpdate(left, right)
        ,Customer_Id, Customer_State, Customer_Agency_Vertical_Type, Customer_Program,  reported_date,reported_time,
        reported_by,event_date,event_end_date,event_location,event_type_1,event_type_2,event_type_3,Household_ID,
        Customer_Person_ID,head_of_household_indicator,relationship_indicator,Rawlinkid,raw_Title,raw_First_name,raw_Middle_Name,
        raw_Last_Name,raw_Orig_Suffix,raw_Full_Name,name_risk_code,ssn,ssn_risk_code,dob,dob_risk_code,Drivers_License,
        Drivers_License_State,drivers_license_risk_code,street_1,street_2,city,state,zip,physical_address_risk_code,
        mailing_street_1,mailing_street_2,mailing_city,mailing_state,mailing_zip,mailing_address_risk_code,address_date,
        address_type,county,phone_number,phone_risk_code,cell_phone,cell_phone_risk_code,work_phone,work_phone_risk_code,
        contact_type,contact_date,carrier,contact_location,contact,call_records,in_service,email_address,email_address_risk_code,
        email_address_type,email_date,host,alias,location,ip_address,ip_address_fraud_code,ip_address_date,version,isp,device_id,
        device_date,device_risk_code,Unique_number,MAC_Address,serial_number,device_type,device_identification_provider,
        bank_routing_number_1,bank_account_number_1,bank_account_1_risk_code,bank_routing_number_2,bank_account_number_2,
        bank_account_2_risk_code,appended_provider_id,business_name,tin,fein,npi,tax_preparer_id,business_type_1,business_date,
        business_risk_code,Customer_Program,start_date,end_date,amount_paid,region_code,investigator_id,reason_description,
        investigation_referral_case_id,investigation_referral_date_opened,investigation_referral_date_closed,customer_fraud_code_1,
        customer_fraud_code_2,type_of_referral,referral_reason,disposition,mitigated,mitigated_amount,external_referral_or_casenumber,
        cleared_fraud,reason_cleared_code,source, rin_source //// -customer_event_id
    );
            
    return in_ddp;

ENDMACRO;