IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared, ut, Inquiry_AccLogs;
EXPORT Build_Prepped_InquiryLogs (
	 string		pversion
) :=
FUNCTION

	Sprayed_InquiryLogs := Files(pversion).Sprayed.InquiryLogs;
			
	IdentityData := RECORD 
		string75 fn { virtual(logicalfilename) };
		Layouts.Sprayed.IdentityData;
	END;	
	
	IdentityData MapIDDT(Sprayed_InquiryLogs L) := TRANSFORM 
	
			SELF.Customer_Job_ID	:= ''; 
			SELF.Batch_Record_ID	:= ''; 
			SELF.Transaction_ID_Number	:= L.search_info.transaction_id; 
			SELF.Reason_for_Transaction_Activity	:= ''; 	
			SELF.Date_of_Transaction	:= L.search_info.datetime[1..8]; 												
			SELF.LexID	:= 0; 
			SELF.raw_Full_Name	:= L.person_q.full_name; 
			SELF.raw_Title	:= L.person_q.title;
			SELF.raw_First_name	:= L.person_q.fname;
			SELF.raw_Middle_Name	:= L.person_q.mname;
			SELF.raw_Last_Name	:= L.person_q.lname;
			SELF.raw_Orig_Suffix	:= L.person_q.name_suffix; 
			SELF.SSN	:= if(L.person_q.ssn<>'',L.person_q.ssn,L.person_q.appended_ssn);
			SELF.SSN4	:= ''; 
			SELF.Address_Type	:= ''; 
			SELF.Street_1	:= L.person_q.address;
			SELF.Street_2	:= '';
			SELF.City	:= L.person_q.city;
			SELF.State	:= L.person_q.state;
			SELF.Zip	:= L.person_q.zip;
			SELF.Mailing_Street_1	:= ''; 
			SELF.Mailing_Street_2	:= ''; 
			SELF.Mailing_City	:= ''; 
			SELF.Mailing_State	:= ''; 
			SELF.Mailing_Zip	:= ''; 
			SELF.County	:= L.person_q.fips_county;
			SELF.Contact_Type	:= ''; 
			SELF.phone_number	:= ''; 
			SELF.Cell_Phone	:= L.person_q.personal_phone; 
			SELF.dob	:= L.person_q.dob;
			SELF.Email_Address	:= L.person_q.email_address; 
			SELF.Drivers_License_State	:= L.person_q.dl_st; 
			SELF.Drivers_License_Number	:= L.person_q.dl; 
			SELF.Bank_Routing_Number_1	:= ''; 
			SELF.Bank_Account_Number_1	:= ''; 
			SELF.Bank_Routing_Number_2	:= ''; 
			SELF.Bank_Account_Number_2	:= ''; 
			SELF.Ethnicity	:= ''; 
			SELF.Race	:= ''; 
			SELF.Case_ID	:= ''; 
			SELF.Client_ID	:= '';
			SELF.Head_of_Household_indicator	:= ''; 
			SELF.Relationship_Indicator	:= ''; 
			SELF.IP_Address	:= L.person_q.ipaddr; 
			SELF.Device_ID	:= ''; 
			SELF.Unique_number	:= ''; 
			SELF.MAC_Address	:= ''; 
			SELF.Serial_Number	:= ''; 
			SELF.Device_Type	:= ''; 
			SELF.Device_identification_Provider	:= '';  
			SELF.geo_lat	:= L.person_q.geo_lat; 
			SELF.geo_long	:= L.person_q.geo_long;  
			SELF.source_input := 'InquiryLogs-' + L.Source;
			SELF := L;
			SELF := [];
	END;

	RETURN(Project(Sprayed_InquiryLogs,MapIDDT(Left)));
	
	
end;


