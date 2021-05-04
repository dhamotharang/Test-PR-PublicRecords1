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
		DOB:=STD.STr.SplitWords(L.BirthDate,'/'); //5/1/1959 
		SELF.Transaction_ID := L.Transaction_ID;
		SELF.Customer_Job_ID	:= '1'; 
		SELF.Batch_Record_ID	:= '1'; 
		SELF.Reason_Description	:= 'Applicant Activity via LexisNexis'; 
		SELF.Date_of_Transaction	:= STD.Str.FindReplace( STD.Str.FindReplace( L.TransactionDate,':',''),'/','')[1..8] ;
		SELF.DOB := 
			trim(DOB[3])+
		if(length(trim(DOB[1]))=2,trim(DOB[1]),'0'+trim(DOB[1])) +
		if(length(trim(DOB[2]))=2,trim(DOB[2]),'0'+trim(DOB[2]));
		SELF.raw_First_name	:= L.FirstName;
		SELF.raw_Middle_Name	:= L.MiddleName;
		SELF.raw_Last_Name	:= L.LastName;
		SELF.raw_Orig_Suffix	:= L.Suffix;
		SELF.Street_1	:= L.Street1;
		SELF.Street_2	:= L.Street2;
		SELF.City	:= L.City;
		SELF.State	:= L.State;
		SELF.Zip	:= L.Zip5;
		SELF.phone_number	:= L.Phone;
		SELF.SSN:= 	L.SSN;
		SELF.rawlinkid	:= L.Lexid_Discovered;
		SELF.IP_Address	:= STD.Str.FindReplace(L.ConsumerIPAddress,'"','');
		SELF.RIN_Source := 9; //https://confluence.rsi.lexisnexis.com/display/GTG/Data+Source+Identification
		SELF.start_date := L.TransactionDate;
		SELF.end_date := L.EndDate;
		SELF := L;
		SELF := [];
	END;

	RETURN(Project(Sprayed_RDP,MapIDDT(Left)));
	
	
end;


