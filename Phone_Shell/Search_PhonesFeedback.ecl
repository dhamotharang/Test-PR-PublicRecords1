/* ************************************************************************
 * This function searches the phones feedback consortium by:					    *
 * -DID:: Source: PF                                                      *
 * -Last Name, Address:: Source: PFLA												              *
 * -First Name, Last Name, Address:: Source: PFFLA											  *
 ************************************************************************ */

IMPORT Phone_Shell, PhonesFeedback, RiskWise, UT, STD, doxie;

todays_date := (string) STD.Date.Today();

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_PhonesFeedback (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, UNSIGNED1 PhoneRestrictionMask, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getFeedbackPhonesAddr(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, PhonesFeedback.Key_PhonesFeedback_Address ri) := TRANSFORM
		SElf.Gathered_Phone := TRIM(ri.phone_number);
		
		matchCode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																											ri.fname, 								ri.lname, 								'', 													ri.Prim_Range,						 ri.Prim_Name,						 ri.Addr_Suffix,						 ri.city,							ri.State,							ri.Zip5,						 '',												 '',							   ri.DID, ri.phone_number);
																											
		Source_List_Temp := MAP(le.Clean_Input.FirstName = ri.fname AND le.Clean_Input.LastName = ri.lname 	=> 'PFFLA',
														le.Clean_Input.LastName = ri.lname																					=> 'PFLA',
																																																						'');
		
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.lname), Source_List_Temp, '');
		
		// This data doesn't have last seen dates, so use todays date just like the "Input" phones	
		date := Phone_Shell.Common.parseDate(ut.DateTimeToYYYYMMDD(ri.date_time_added), TRUE);
		SELF.Sources.Source_List_First_Seen := IF(TRIM(date) = '', Phone_Shell.Common.parseDate(todays_date), date);
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate(todays_date);
		
		SELF.Sources.Source_Owner_Name_First := ri.fname;
		SELF.Sources.Source_Owner_Name_Middle := ri.mname;
		SELF.Sources.Source_Owner_Name_Last := ri.lname;
		SELF.Sources.Source_Owner_DID := (STRING)ri.DID;
		
		didMatch := StringLib.StringFind(matchcode, 'L', 1) > 0;
		nameMatch := StringLib.StringFind(matchcode, 'N', 1) > 0;
		addrMatch := StringLib.StringFind(matchcode, 'A', 1) > 0;
		ssnMatch := StringLib.StringFind(matchcode, 'S', 1) > 0;
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MAP(didMatch AND nameMatch 	=> Phone_Shell.Constants.Phone_Subject_Level.Subject,
																															didMatch AND addrMatch	=> Phone_Shell.Constants.Phone_Subject_Level.Household,
																																												 Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject);
																																																						 
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(didMatch AND nameMatch			=> 'Subject', 
																															didMatch AND addrMatch			=> 'Subject at Household',
																															ssnMatch										=> 'Associate By SSN',
																															addrMatch										=> 'Associate By Address',
																																														 'Associate'
																															);

		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchCode;
		
		SELF := le;
	END;
	
	byAddress := JOIN(Input, PhonesFeedback.Key_PhonesFeedback_Address, TRIM(LEFT.Clean_Input.Prim_Range) <> '' AND TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND
																											KEYED(LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range AND LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name AND LEFT.Clean_Input.Zip5 = RIGHT.Zip5 AND 
																											LEFT.Clean_Input.Predir = RIGHT.Predir AND LEFT.Clean_Input.Addr_Suffix = RIGHT.Addr_Suffix AND LEFT.Clean_Input.Sec_Range = RIGHT.Sec_Range) AND
																											(INTEGER)RIGHT.phone_number <> 0,
																											getFeedbackPhonesAddr(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost)) (TRIM(Sources.Source_List) <> '');

	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getFeedbackPhonesDID(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, PhonesFeedback.Key_PhonesFeedback_DID ri) := TRANSFORM
		SElf.Gathered_Phone := TRIM(ri.phone_number);
		
		matchCode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																											ri.fname, 								ri.lname, 								'', 													ri.Prim_Range,						 ri.Prim_Name,						 ri.Addr_Suffix,						 ri.city,							ri.State,							ri.Zip5,						 '',												 '',							   ri.DID, ri.phone_number);
		
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.lname), 'PF', '');
		
		// This data doesn't have last seen dates, so use todays date just like the "Input" phones	
		date := Phone_Shell.Common.parseDate(ut.DateTimeToYYYYMMDD(ri.date_time_added), TRUE);
		SELF.Sources.Source_List_First_Seen := IF(TRIM(date) = '', Phone_Shell.Common.parseDate(todays_date), date);
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate(todays_date);
		
		SELF.Sources.Source_Owner_Name_First := ri.fname;
		SELF.Sources.Source_Owner_Name_Middle := ri.mname;
		SELF.Sources.Source_Owner_Name_Last := ri.lname;
	  SELF.Sources.Source_Owner_DID := (STRING)ri.DID;
	
		didMatch := StringLib.StringFind(matchcode, 'L', 1) > 0;
		nameMatch := StringLib.StringFind(matchcode, 'N', 1) > 0;
		addrMatch := StringLib.StringFind(matchcode, 'A', 1) > 0;
		ssnMatch := StringLib.StringFind(matchcode, 'S', 1) > 0;
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MAP(didMatch AND nameMatch 	=> Phone_Shell.Constants.Phone_Subject_Level.Subject,
																															didMatch AND addrMatch	=> Phone_Shell.Constants.Phone_Subject_Level.Household,
																																												 Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject);
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(didMatch AND nameMatch			=> 'Subject', 
																															didMatch AND addrMatch			=> 'Subject at Household',
																															ssnMatch										=> 'Associate By SSN',
																															addrMatch										=> 'Associate By Address',
																																														 'Associate'
																															);

		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchCode;
		
		// While we are hitting this key, gather the Phone Feedback attributes which require searching by DID
		SELF.Phone_Feedback.Phone_Feedback_Date := date;
		SELF.Phone_Feedback.Phone_Feedback_Result := CASE(TRIM(ri.phone_contact_type),
																											'1' => 1,
																											'2' => 2,
																											'3' => 3,
																											'4' => 4,
																														 9);
		SELF.Phone_Feedback.Phone_Feedback_First := TRIM(ri.fname);
		SELF.Phone_Feedback.Phone_Feedback_Middle := TRIM(ri.mname);
		SELF.Phone_Feedback.Phone_Feedback_Last := TRIM(ri.lname);
		SELF.Phone_Feedback.Phone_Feedback_Last_RPC_Date := date;
		
		SELF := le;
	END;
	
	byDID := JOIN(Input, PhonesFeedback.Key_PhonesFeedback_DID, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.DID),
																											getFeedbackPhonesDID(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost)) (TRIM(Sources.Source_List) <> '');

	combined := byAddress + byDID;
	
	final := DEDUP(SORT(combined, Clean_Input.seq, Gathered_Phone, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))), Clean_Input.seq, Gathered_Phone, Sources.Source_List);
	
	RETURN(final);
END;