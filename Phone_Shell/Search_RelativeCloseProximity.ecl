
/* ************************************************************************
 * This function searches the relatives in closest proximity by:					*
 * - LexID (DID):: Source: CR																							*
 ************************************************************************ */

IMPORT Phone_Shell, Risk_Indicators, RiskWise, UT, Header;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_RelativeCloseProximity (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, DATASET(Phone_Shell.Layouts.Layout_Parent_Spouse_Relative_RawData) phones, UNSIGNED1 PhoneRestrictionMask) := FUNCTION
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getSpousePhones(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phone_Shell.Layouts.Layout_Parent_Spouse_Relative_RawData ri) := TRANSFORM
		
		SELF.Gathered_Phone := ri.subj_phone10;
		
		matchCode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																											ri.Subj_First,						ri.Subj_Last, 						'', 													ri.Prim_Range,						 ri.Prim_Name,						 ri.Addr_Suffix,						 ri.P_City_Name,			ri.St,								ri.Zip5,						 ri.DateOfBirth,						 ri.SSN,						 ri.DID, ri.subj_phone10);
		
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.Subj_Last), 'CR', '');
		
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate((STRING)ri.subj_date_first);
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((STRING)ri.subj_date_last);
		
		SELF.Sources.Source_Owner_Name_First := ri.subj_first; 
		SELF.Sources.Source_Owner_Name_Middle := ri.subj_middle;
		SELF.Sources.Source_Owner_Name_Last := ri.subj_last;
		SELF.Sources.Source_Owner_Name_Suffix := ri.subj_suffix;
		SELF.Sources.Source_Owner_DID := (STRING)ri.DID;
		
		addrMatch := StringLib.StringFind(matchcode, 'A', 1) > 0;
		
		// A closest relative is just a person who can lead to subject contact, unless they live in the same house then it is the household.
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MAP(addrMatch 																									=> Phone_Shell.Constants.Phone_Subject_Level.Household,
																															ri.titleNo IN Header.relative_titles.set_FirstDegreeRelative	=> Phone_Shell.Constants.Phone_Subject_Level.FirstDegreeRelative,
																																																														 Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject);
																																																					
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(addrMatch																	=> 'Subject at Household',
																															TRIM(ri.subj_phone_relationship) <> ''		=> TRIM(ri.subj_phone_relationship),
																																																					 Header.relative_titles.fn_get_str_title(Header.relative_titles.num_relative)
																															);

		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchCode;

		SELF := le;
	END;
	closestRelativePhones := JOIN(input, phones, (STRING)LEFT.Clean_Input.Seq = RIGHT.AcctNo, getSpousePhones(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost)) (TRIM(Sources.Source_List) <> '');

	final := DEDUP(SORT(closestRelativePhones, Clean_Input.seq, Gathered_Phone, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))), Clean_Input.seq, Gathered_Phone, Sources.Source_List);
	
	RETURN(final);
END;