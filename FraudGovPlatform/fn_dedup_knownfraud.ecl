EXPORT fn_dedup_knownfraud(inputs):=FUNCTIONMACRO

			only_contributed := inputs(regexfind('KNOWNRISK|SAFELIST',inputs.filename,nocase));
			everything_else  := inputs(~regexfind('KNOWNRISK|SAFELIST',inputs.filename,nocase));
			in_srt := sort(only_contributed , reported_date,reported_time,reported_by,event_date,event_end_date,event_location,event_type_1,event_type_2,event_type_3,Household_ID,Customer_Person_ID,head_of_household_indicator,relationship_indicator,Rawlinkid,raw_Title,raw_First_name,raw_Middle_Name,raw_Last_Name,raw_Orig_Suffix,raw_Full_Name,name_risk_code,ssn,ssn_risk_code,dob,dob_risk_code,Drivers_License,Drivers_License_State,drivers_license_risk_code,street_1,street_2,city,state,zip,physical_address_risk_code,mailing_street_1,mailing_street_2,mailing_city,mailing_state,mailing_zip,mailing_address_risk_code,address_date,address_type,county,phone_number,phone_risk_code,cell_phone,cell_phone_risk_code,work_phone,work_phone_risk_code,contact_type,contact_date,carrier,contact_location,contact,call_records,in_service,email_address,email_address_risk_code,email_address_type,email_date,host,alias,location,ip_address,ip_address_fraud_code,ip_address_date,version,isp,device_id,device_date,device_risk_code,unique_number,MAC_Address,serial_number,device_type,device_identification_provider,bank_routing_number_1,bank_account_number_1,bank_account_1_risk_code,bank_routing_number_2,bank_account_number_2,bank_account_2_risk_code,appended_provider_id,business_name,tin,fein,npi,tax_preparer_id,business_type_1,business_date,business_risk_code,Customer_Program,start_date,end_date,amount_paid,region_code,investigator_id,reason_description,investigation_referral_case_id,investigation_referral_date_opened,investigation_referral_date_closed,customer_fraud_code_1,customer_fraud_code_2,type_of_referral,referral_reason,disposition,mitigated,mitigated_amount,external_referral_or_casenumber,cleared_fraud,reason_cleared_code,filename);

			{inputs} RollupUpdate({only_contributed} l, {only_contributed} r) := 
			transform
					SELF.source_rec_id := if(l.source_rec_id < r.source_rec_id,l.source_rec_id, r.source_rec_id); // leave always previous Unique_Id 
					self := l;
			end;

			in_ddp := rollup( in_srt
					,RollupUpdate(left, right)
					,reported_date,reported_time,reported_by,event_date,event_end_date,event_location,event_type_1,event_type_2,event_type_3,Household_ID,Customer_Person_ID,head_of_household_indicator,relationship_indicator,Rawlinkid,raw_Title,raw_First_name,raw_Middle_Name,raw_Last_Name,raw_Orig_Suffix,raw_Full_Name,name_risk_code,ssn,ssn_risk_code,dob,dob_risk_code,Drivers_License,Drivers_License_State,drivers_license_risk_code,street_1,street_2,city,state,zip,physical_address_risk_code,mailing_street_1,mailing_street_2,mailing_city,mailing_state,mailing_zip,mailing_address_risk_code,address_date,address_type,county,phone_number,phone_risk_code,cell_phone,cell_phone_risk_code,work_phone,work_phone_risk_code,contact_type,contact_date,carrier,contact_location,contact,call_records,in_service,email_address,email_address_risk_code,email_address_type,email_date,host,alias,location,ip_address,ip_address_fraud_code,ip_address_date,version,isp,device_id,device_date,device_risk_code,unique_number,MAC_Address,serial_number,device_type,device_identification_provider,bank_routing_number_1,bank_account_number_1,bank_account_1_risk_code,bank_routing_number_2,bank_account_number_2,bank_account_2_risk_code,appended_provider_id,business_name,tin,fein,npi,tax_preparer_id,business_type_1,business_date,business_risk_code,Customer_Program,start_date,end_date,amount_paid,region_code,investigator_id,reason_description,investigation_referral_case_id,investigation_referral_date_opened,investigation_referral_date_closed,customer_fraud_code_1,customer_fraud_code_2,type_of_referral,referral_reason,disposition,mitigated,mitigated_amount,external_referral_or_casenumber,cleared_fraud,reason_cleared_code,filename
			);
			
			d_all := in_ddp + everything_else;
			
			return d_all;

ENDMACRO;