import STD;
EXPORT Build_Prepped_RDP (
	 string		pversion
) :=
FUNCTION

	Sprayed_RDP := Files(pversion).Sprayed.RDP;
			
	IdentityData := RECORD 
		string75 fn { virtual(logicalfilename) };
		Layouts.Sprayed.IdentityData;
	END;	
	
	IdentityData MapIDDT(Sprayed_RDP L) := TRANSFORM 

		SELF.Customer_Job_ID	:= '1'; 
		SELF.Batch_Record_ID	:= '1'; 
		SELF.Transaction_ID_Number :=	L.transaction_id;
		SELF.Reason_for_Transaction_Activity	:= 'Applicant Activity via LexisNexis'; 
		SELF.Date_of_Transaction	:= STD.Str.FindReplace( STD.Str.FindReplace( L.date_added,':',''),'-','')[1..8] ;
		SELF.DOB := L.dob[5..8] + L.dob[1..2] + L.dob[3..4];
		SELF.raw_First_name	:= L.first_name;
		SELF.raw_Middle_Name	:= L.middle_name;
		SELF.raw_Last_Name	:= L.last_name;
		SELF.raw_Orig_Suffix	:= L.suffix_name;
		SELF.Street_1	:= L.address;
		SELF.phone_number	:= L.phone;
		SELF.Cell_Phone	:= L.work_phone;
		SELF.Drivers_License_State:= 	L.dl;
		SELF.Drivers_License_Number:= 	L.dl_state;
		SELF.SSN:= 	L.ssn;
		SELF.LexID	:= L.response_lexid;
		SELF.IP_Address	:= L.ipaddr;
		SELF := L;
		SELF := [];
	END;

	RETURN(Project(Sprayed_RDP,MapIDDT(Left)));
	
	
end;


