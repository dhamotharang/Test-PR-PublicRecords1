IMPORT tools,STD, FraudGovPlatform_Validation, ut, Inquiry_AccLogs;
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
	
			SELF.Customer_Job_ID	:= '1'; 
			SELF.Batch_Record_ID	:= '1'; 
			SELF.Transaction_ID	:= L.search_info.transaction_id; 
			SELF.Date_of_Transaction	:= L.search_info.datetime[1..8]; 												
			SELF.raw_Full_Name	:= L.person_q.full_name; 
			SELF.raw_Title	:= L.person_q.title;
			SELF.raw_First_name	:= L.person_q.fname;
			SELF.raw_Middle_Name	:= L.person_q.mname;
			SELF.raw_Last_Name	:= L.person_q.lname;
			SELF.raw_Orig_Suffix	:= L.person_q.name_suffix; 
			SELF.SSN	:= if(L.person_q.ssn<>'',L.person_q.ssn,L.person_q.appended_ssn);
			SELF.Street_1	:= L.person_q.address;
			SELF.City	:= L.person_q.city;
			SELF.State	:= L.person_q.state;
			SELF.Zip	:= L.person_q.zip;
			SELF.County	:= L.person_q.fips_county;
			SELF.Cell_Phone	:= L.person_q.personal_phone; 
			SELF.dob	:= L.person_q.dob;
			SELF.Email_Address	:= L.person_q.email_address; 
			SELF.Drivers_License_State	:= L.person_q.dl_st; 
			SELF.Drivers_License	:= L.person_q.dl; 
			SELF.IP_Address	:= L.person_q.ipaddr; 
			SELF.geo_lat	:= L.person_q.geo_lat; 
			SELF.geo_long	:= L.person_q.geo_long;  
			SELF := L;
			SELF := [];
	END;

	RETURN(Project(Sprayed_InquiryLogs,MapIDDT(Left)));
	
	
end;


