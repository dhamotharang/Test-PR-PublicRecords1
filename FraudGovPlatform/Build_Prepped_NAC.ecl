EXPORT Build_Prepped_NAC(
	string pversion
) :=
MODULE
	

	Shared Sprayed_NAC := Files(pversion).Sprayed.NAC;

	IdentityData := RECORD 
		string75 fn { virtual(logicalfilename) };
		Layouts.Sprayed.IdentityData;
	END;	

	IdentityData MapIDDT(Sprayed_NAC L) := TRANSFORM 
			SELF.Customer_Name					:= '';
			SELF.Customer_Account_Number	:= '196969851'; 
			SELF.Customer_State					:= 'FL';
			SELF.Customer_County				:= '001';
			SELF.Customer_Agency				:= ''; 														
			SELF.Customer_Agency_Vertical_Type	:= 'S';
			SELF.Customer_Program				:= 'N';  // NAC SNAP
			SELF.Customer_Job_ID				:= ''; 
			SELF.Batch_Record_ID				:= ''; 
			SELF.Transaction_ID_Number		:= ''; 
			SELF.Reason_for_Transaction_Activity	:= ''; 	
			SELF.Date_of_Transaction			:= '';											
			SELF.LexID								:= 0;
			SELF.raw_Full_Name					:= l.SearchFullName;
			SELF.raw_Title							:= '';
			SELF.raw_First_name					:= l.SearchFirstName;
			SELF.raw_Middle_Name				:= l.SearchMiddleName;
			SELF.raw_Last_Name					:= l.SearchLastName;
			SELF.raw_Orig_Suffix				:= l.SearchSuffix;
			SELF.SSN									:= l.SearchSSN;
			SELF.SSN4									:= ''; 
			SELF.Address_Type						:= ''; 
			SELF.Street_1							:= l.SearchAddress1StreetAddress1;
			SELF.Street_2							:= l.SearchAddress1StreetAddress2;
			SELF.City									:= l.SearchAddress1City;
			SELF.State								:= l.SearchAddress1State;
			SELF.Zip									:= l.SearchAddress1Zip;
			SELF.Mailing_Street_1				:= l.SearchAddress2StreetAddress1;
			SELF.Mailing_Street_2				:= l.SearchAddress2StreetAddress2;
			SELF.Mailing_City						:= l.SearchAddress2City;
			SELF.Mailing_State					:= l.SearchAddress2State; 
			SELF.Mailing_Zip						:= l.SearchAddress2Zip;
			SELF.County								:= '';
			SELF.Contact_Type						:= ''; 
			SELF.phone_number						:= ''; 
			SELF.Cell_Phone						:= '';
			SELF.dob									:= l.SearchDOB;
			SELF.Email_Address					:= '';
			SELF.Drivers_License_State		:= '';
			SELF.Drivers_License_Number		:= '';
			SELF.Bank_Routing_Number_1		:= ''; 
			SELF.Bank_Account_Number_1		:= ''; 
			SELF.Bank_Routing_Number_2		:= ''; 
			SELF.Bank_Account_Number_2		:= ''; 
			SELF.Ethnicity							:= ''; 
			SELF.Race									:= ''; 
			SELF.Case_ID								:= l.SearchCaseId;
			SELF.Client_ID							:= '';
			SELF.Head_of_Household_indicator	:= ''; 
			SELF.Relationship_Indicator		:= ''; 
			SELF.IP_Address						:= l.enduserip;
			SELF.Device_ID							:= ''; 
			SELF.Unique_number					:= ''; 
			SELF.MAC_Address						:= ''; 
			SELF.Serial_Number					:= ''; 
			SELF.Device_Type						:= ''; 
			SELF.Device_identification_Provider	:= '';  
			SELF.geo_lat								:= '';
			SELF.geo_long							:= '';
			SELF.source_input 					:= 'NAC';
			SELF := L;
			SELF := [];
	END;

	EXPORT NACIDDTUpdate := Project(dedup(Sprayed_NAC(ActivityType in ['1','2']),all),MapIDDT(Left));
	
	KnownFraud := RECORD 
		string75 fn { virtual(logicalfilename) };
		Layouts.Sprayed.KnownFraud;
	END;	

	KnownFraud MapKNFD(Sprayed_NAC L) := TRANSFORM 
			SELF.customer_name := '';
			SELF.customer_account_number := '196969851';
			SELF.customer_state := 'FL';
			SELF.customer_county := '001';
			SELF.customer_agency := '';
			SELF.customer_agency_vertical_type := 'S';
			SELF.customer_event_id := '';
			SELF.reported_date := '';
			SELF.reported_time := '';
			SELF.reported_by := '';
			SELF.event_date := '';
			SELF.event_end_date := '';
			SELF.event_location := '';
			SELF.event_type_1 := '';
			SELF.event_type_2 := '';
			SELF.event_type_3 := '';
			SELF.case_id := l.CaseID;
			SELF.client_id := '';
			SELF.head_of_household_indicator := '';
			SELF.relationship_indicator := '';
			SELF.lexid := 0;
			SELF.raw_title := '';
			SELF.raw_first_name := l.ClientFirstName;
			SELF.raw_middle_name := l.ClientMiddleName;
			SELF.raw_last_name := l.ClientLastName;
			SELF.raw_orig_suffix := '';
			SELF.raw_full_name := '';
			SELF.name_risk_code := '';
			SELF.ssn := l.ClientSSN;
			SELF.ssn_risk_code := '';
			SELF.dob := l.ClientDOB;
			SELF.dob_risk_code := '';
			SELF.Drivers_License_Number := '';
			SELF.Drivers_License_State := '';
			SELF.drivers_license_risk_code := '';
			SELF.Street_1 := '';
			SELF.Street_2 := '';
			SELF.city := '';
			SELF.state := '';
			SELF.zip := '';
			SELF.physical_address_risk_code := '';
			SELF.mailing_Street_1 := '';
			SELF.mailing_Street_2 := '';
			SELF.mailing_city := '';
			SELF.mailing_state := '';
			SELF.mailing_zip := '';
			SELF.mailing_address_risk_code := '';
			SELF.address_date := '';
			SELF.address_type := '';
			SELF.county := '';
			SELF.phone_number := l.ClientPhone;
			SELF.phone_risk_code := '';
			SELF.cell_phone := '';
			SELF.cell_phone_risk_code := '';
			SELF.work_phone := '';
			SELF.work_phone_risk_code := '';
			SELF.contact_type := '';
			SELF.contact_date := '';
			SELF.carrier := '';
			SELF.contact_location := '';
			SELF.contact := '';
			SELF.call_records := '';
			SELF.in_service := '';
			SELF.email_address := l.ClientEmail;
			SELF.email_address_risk_code := '';
			SELF.email_address_type := '';
			SELF.email_date := '';
			SELF.host := '';
			SELF.alias := '';
			SELF.location := '';
			SELF.ip_address := '';
			SELF.ip_address_fraud_code := '';
			SELF.ip_address_date := '';
			SELF.version := '';
			SELF.isp := '';
			SELF.device_id := '';
			SELF.device_date := '';
			SELF.device_risk_code := '';
			SELF.unique_number := '';
			SELF.mac_address := '';
			SELF.serial_number := '';
			SELF.device_type := '';
			SELF.device_identification_provider := '';
			SELF.bank_routing_number_1 := '';
			SELF.bank_account_number_1 := '';
			SELF.bank_account_1_risk_code := '';
			SELF.bank_routing_number_2 := '';
			SELF.bank_account_number_2 := '';
			SELF.bank_account_2_risk_code := '';
			SELF.appended_provider_id := 0;
			SELF.business_name := '';
			SELF.tin := '';
			SELF.fein := '';
			SELF.npi := '';
			SELF.tax_preparer_id := '';
			SELF.business_type_1 := '';
			SELF.business_date := '';
			SELF.business_risk_code := '';
			SELF.Customer_Program := 'N';
			SELF.start_date := '';
			SELF.end_date := '';
			SELF.amount_paid := '';
			SELF.region_code := '';
			SELF.investigator_id := '';
			SELF.reason_description := '';
			SELF.investigation_referral_case_id := '';
			SELF.investigation_referral_date_opened := '';
			SELF.investigation_referral_date_closed := '';
			SELF.customer_fraud_code_1 := '';
			SELF.customer_fraud_code_2 := '';
			SELF.type_of_referral := '';
			SELF.referral_reason := '';
			SELF.disposition := '';
			SELF.mitigated := '';
			SELF.mitigated_amount := '';
			SELF.external_referral_or_casenumber := '';
			SELF.cleared_fraud := '';
			SELF.reason_cleared_code := '';
			SELF.source_input := 'NAC';
			SELF := L;
			SELF := [];
	END;

	EXPORT NACKNFDUpdate := Project(dedup(Sprayed_NAC(ActivityType ='4'),all),MapKNFD(Left));
	
	
end;


