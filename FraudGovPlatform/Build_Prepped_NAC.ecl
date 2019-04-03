import STD;
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

			searchpattern := '([0-9])\\w+';
			sw := STD.Str.SplitWords( regexfind(searchpattern, l.fn,0), '_');
			vDate := sw[1];
			SELF.Customer_Job_ID := '';
			SELF.Batch_Record_ID := '';
			SELF.Transaction_ID_Number := L.ESPTransactionId;
			SELF.Reason_for_Transaction_Activity:= '';
			SELF.Date_of_Transaction := vDate;
			SELF.LexID := 0;
			SELF.raw_Full_Name := l.SearchFullName;
			SELF.raw_Title := '';
			SELF.raw_First_name := l.SearchFirstName;
			SELF.raw_Middle_Name := l.SearchMiddleName;
			SELF.raw_Last_Name := l.SearchLastName;
			SELF.raw_Orig_Suffix := l.SearchSuffix;
			SELF.SSN := l.SearchSSN;
			SELF.SSN4 := '';
			SELF.Address_Type := '';
			SELF.Street_1 := l.SearchAddress1StreetAddress1;
			SELF.Street_2 := l.SearchAddress1StreetAddress2;
			SELF.City := l.SearchAddress1City;
			SELF.State := l.SearchAddress1State;
			SELF.Zip := l.SearchAddress1Zip;
			SELF.Mailing_Street_1 := l.SearchAddress2StreetAddress1;
			SELF.Mailing_Street_2 := l.SearchAddress2StreetAddress2;
			SELF.Mailing_City := l.SearchAddress2City;
			SELF.Mailing_State := l.SearchAddress2State;
			SELF.Mailing_Zip := l.SearchAddress2Zip;
			SELF.County := '';
			SELF.Contact_Type := '';
			SELF.phone_number := l.ClientPhone;
			SELF.Cell_Phone := '';
			SELF.dob := l.SearchDOB;
			SELF.Email_Address := l.ClientEmail;
			SELF.Drivers_License_State := '';
			SELF.Drivers_License_Number := '';
			SELF.Bank_Routing_Number_1 := '';
			SELF.Bank_Account_Number_1 := '';
			SELF.Bank_Routing_Number_2 := '';
			SELF.Bank_Account_Number_2 := '';
			SELF.Ethnicity := l.ClientEthnicity;
			SELF.Race := l.ClientRace;
			SELF.Case_ID := l.SearchCaseId;
			SELF.Client_ID := l.SearchClientId;
			SELF.Head_of_Household_indicator := '';
			SELF.Relationship_Indicator := '';
			SELF.IP_Address := l.enduserip;
			SELF.Device_ID := '';
			SELF.Unique_number := '';
			SELF.MAC_Address := '';
			SELF.Serial_Number := '';
			SELF.Device_Type := '';
			SELF.Device_identification_Provider	:= '';
			SELF.geo_lat := '';
			SELF.geo_long := '';
			SELF.source_input := 'MSH_NAC';
			SELF := L;
			SELF := [];
	END;

	bucket_1_n_2 := Sprayed_NAC(ActivityType in ['1','2']);
	EXPORT NACIDDTUpdate := Project(dedup(bucket_1_n_2,all),MapIDDT(Left));
	
	KnownFraud := RECORD 
		string75 fn { virtual(logicalfilename) };
		Layouts.Sprayed.KnownFraud;
	END;	

	KnownFraud MapKNFD(Sprayed_NAC L) := TRANSFORM 
			searchpattern := '([0-9])\\w+';
			sw := STD.Str.SplitWords( regexfind(searchpattern, l.fn,0), '_');
			vDate := sw[1];
			vTime := sw[2];
			SELF.customer_event_id := L.SequenceNumber;
			SELF.reported_date := vDate;
			SELF.reported_time := vTime;
			SELF.reported_by := '';
			SELF.event_date := '';
			SELF.event_end_date := '';
			SELF.event_location := '';
			SELF.event_type_1 := '';
			SELF.event_type_2 := '';
			SELF.event_type_3 := '';
			SELF.case_id := L.CaseID;
			SELF.client_id := L.ClientID;
			SELF.head_of_household_indicator := '';
			SELF.relationship_indicator := '';
			SELF.lexid := 0;
			SELF.raw_title := '';
			SELF.raw_first_name := L.ClientFirstName;
			SELF.raw_middle_name := L.ClientMiddleName;
			SELF.raw_last_name := L.ClientLastName;
			SELF.raw_orig_suffix := '';
			SELF.raw_full_name := '';
			SELF.name_risk_code := '';
			SELF.ssn := L.ClientSSN;
			SELF.ssn_risk_code := '';
			SELF.dob := L.ClientDOB;
			SELF.dob_risk_code := '';
			SELF.Drivers_License_Number := '';
			SELF.Drivers_License_State := '';
			SELF.drivers_license_risk_code := '';
			SELF.Street_1 := L.CasePhysicalStreet1;
			SELF.Street_2 := L.CasePhysicalStreet2;
			SELF.city := L.CasePhysicalCity;
			SELF.state := L.CasePhysicalState;
			SELF.zip := L.CasePhysicalZip;
			SELF.physical_address_risk_code := '';
			SELF.mailing_Street_1 := L.CaseMailStreet1;
			SELF.mailing_Street_2 := L.CaseMailStreet2;
			SELF.mailing_city := L.CaseMailCity;
			SELF.mailing_state := L.CaseMailState;
			SELF.mailing_zip := L.CaseMailZip;
			SELF.mailing_address_risk_code := '';
			SELF.address_date := '';
			SELF.address_type := '';
			SELF.county := '';
			SELF.phone_number := L.ClientPhone;
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
			SELF.email_address := L.ClientEmail;
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
			SELF.Customer_Program := L.CaseBenefitType;
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
			SELF.source_input := 'MSH_NAC';
			SELF := L;
			SELF := [];
	END;

	bucket_4 := Sprayed_NAC(ActivityType ='4');
	intraState := bucket_4(casemailstate = SearchAddress1State and casemailstate <> '' and SearchAddress1State <> '');
	interState := bucket_4(casemailstate <> SearchAddress1State);	

	Sprayed_NAC NormIt(Sprayed_NAC L, UNSIGNED C) := TRANSFORM
		self.casestate := CHOOSE(C,L.casestate,L.SearchAddress1State);
		self.casebenefittype := CHOOSE(C,L.casebenefittype,L.searchbenefittype);
		self.caseid := CHOOSE(C,L.caseid,L.searchcaseid);
		self.caselastname := CHOOSE(C,L.caselastname,L.SearchLastName);
		self.casefirstname := CHOOSE(C,L.casefirstname,L.SearchFirstName);
		self.casemiddlename := CHOOSE(C,L.casemiddlename,L.SearchMiddleName);
		self.casephysicalstreet1 := CHOOSE(C,L.casephysicalstreet1,L.SearchAddress1StreetAddress1);
		self.casephysicalstreet2 := CHOOSE(C,L.casephysicalstreet2,L.SearchAddress1StreetAddress2);
		self.casephysicalcity := CHOOSE(C,L.casephysicalcity,L.SearchAddress1City);
		self.casephysicalstate := CHOOSE(C,L.casephysicalstate,L.SearchAddress1State);
		self.casephysicalzip := CHOOSE(C,L.casephysicalzip,L.SearchAddress1Zip);
		self.casemailstreet1 := CHOOSE(C,L.casemailstreet1,L.SearchAddress2StreetAddress1);
		self.casemailstreet2 := CHOOSE(C,L.casemailstreet2,L.SearchAddress2StreetAddress2);
		self.casemailcity := CHOOSE(C,L.casemailcity,L.SearchAddress2City);
		self.casemailstate := CHOOSE(C,L.casemailstate,L.SearchAddress2State);
		self.casemailzip := CHOOSE(C,L.casemailzip,L.SearchAddress2Zip);
		self.clientid := CHOOSE(C,L.clientid,L.SearchClientId);
		self.clientlastname := CHOOSE(C,L.clientlastname,L.SearchLastName);
		self.clientfirstname := CHOOSE(C,L.clientfirstname,L.SearchFirstName);
		self.clientmiddlename := CHOOSE(C,L.clientmiddlename,L.SearchMiddleName);
		self.clientssn := CHOOSE(C,L.clientssn,L.SearchSSN);
		self.clientdob := CHOOSE(C,L.clientdob,L.SearchDOB);
		SELF := L;
	END;

	normRec := normalize(intraState, 2, NormIt(LEFT, COUNTER));

	comb := normRec + interState;

	EXPORT NACKNFDUpdate := Project(dedup(comb,all),MapKNFD(Left));
	
	
end;


