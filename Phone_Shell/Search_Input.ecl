/* ************************************************************************
 * This function formats and returns the input phone(s) - Home and Work   *
 * :: Source: INPUT																												*
 ************************************************************************ */

IMPORT Phone_Shell, UT, STD;

todays_date := (string) STD.Date.Today();

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_Input (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, UNSIGNED1 PhoneRestrictionMask,
          UNSIGNED2 PhoneShellVersion = 10) := FUNCTION
          
          
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getPhone (Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, UNSIGNED1 whichPhone) := TRANSFORM
		SElf.Gathered_Phone := CASE(whichPhone,
														1 => le.Raw_Input.HomePhone,
														2 => le.Raw_Input.WorkPhone,
														'');
														
		SELF.Sources.Source_List := 'INPUT';
		
		// Since these are input phones, first and last seen dates are today
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate(todays_date);
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate(todays_date);
		
		SELF.Sources.Source_Owner_Name_Prefix := le.Raw_Input.NamePrefix;
		SELF.Sources.Source_Owner_Name_First := le.Raw_Input.FirstName; 
		SELF.Sources.Source_Owner_Name_Middle := le.Raw_Input.MiddleName;
		SELF.Sources.Source_Owner_Name_Last := le.Raw_Input.LastName;
		SELF.Sources.Source_Owner_Name_Suffix := le.Raw_Input.SuffixName;
    SELF.Sources.Source_Owner_DID := IF(le.DID <> 0,(STRING)le.DID,(STRING)le.Raw_Input.DID);

		// Since it is the input information it should be attached directly to the subject
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := Phone_Shell.Constants.Phone_Subject_Level.Subject;
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := 'Subject';

		// Since this is the input, only the phone number should match since we can't verify any of the other information
		SELF.Raw_Phone_Characteristics.Phone_Match_Code := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																																														'', 												'', 										'', 														'',												'',												'',													'',										'',										'',									'',													'',									0,			IF(TRIM(le.Clean_Input.HomePhone) <> '', le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone));
		
  // on a single record like this, the 'all' attributes are the same as the regular attributes
  // only populated for PhoneShell version 2.1+
		SELF.Sources.Source_List_All_Last_Seen := if(PhoneShellVersion >= 21, Phone_Shell.Common.parseDate(todays_date), '');
  SELF.Sources.Source_Owner_All_DIDs := if(PhoneShellVersion >= 21, IF(le.DID <> 0,(STRING)le.DID,(STRING)le.Raw_Input.DID), '');		
    
		SELF := le;
	END;
	home := PROJECT(input, getPhone(LEFT, 1));
	work := PROJECT(input, getPhone(LEFT, 2));
	
	// In case the home phone and work phone were input as the same only return one
	final := DEDUP(SORT((home + work) (TRIM(Gathered_Phone) NOT IN ['', '0']), Input_Echo.seq, Gathered_Phone, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))), Input_Echo.seq, Gathered_Phone);

	RETURN(final);
END;