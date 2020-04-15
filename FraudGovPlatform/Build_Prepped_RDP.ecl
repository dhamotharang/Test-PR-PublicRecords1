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
		DOB := L.dob[5..8] + L.dob[1..2] + L.dob[3..4] ;
		SELF.Transaction_ID := L.transaction_id;
		SELF.Customer_Job_ID	:= '1'; 
		SELF.Batch_Record_ID	:= '1'; 
		SELF.Reason_Description	:= 'Applicant Activity via LexisNexis'; 
		SELF.Date_of_Transaction	:= STD.Str.FindReplace( STD.Str.FindReplace( L.date_added,':',''),'-','')[1..8] ;
		SELF.DOB := DOB;
		SELF.raw_First_name	:= L.first_name;
		SELF.raw_Middle_Name	:= L.middle_name;
		SELF.raw_Last_Name	:= L.last_name;
		SELF.raw_Orig_Suffix	:= L.suffix_name;
		SELF.Street_1	:= L.address;
		SELF.City	:= L.City;
		SELF.State	:= L.State;
		SELF.Zip	:= L.Zip;
		SELF.phone_number	:= L.phone;
		SELF.Email_Address := L.email;
		SELF.SSN:= 	L.SSN;
		SELF.Drivers_License_State := L.dl_state;
		SELF.Drivers_License := L.dl;		
		SELF.Rawlinkid := L.response_lexid;
		SELF.IP_Address	:= STD.Str.FindReplace(L.ipaddr,'"','');
		SELF.Source_RIN := 9; //https://confluence.rsi.lexisnexis.com/display/GTG/Data+Source+Identification
		SELF := L;
		SELF := [];
	END;

	RETURN(Project(Sprayed_RDP,MapIDDT(Left)));
	
	
end;


