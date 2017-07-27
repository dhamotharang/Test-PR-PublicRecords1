/*2013-11-21T00:14:53Z (Lorraine Hill)

*/
/* ************************************************************************
 * This function searches for co-resident that isn't parent or spouse by:	*
 * - LexID (DID):: Source: RM																							*
 ************************************************************************ */

IMPORT Phone_Shell, Risk_Indicators, RiskWise, UT;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_CoResident (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, DATASET(Phone_Shell.Layouts.Layout_Parent_Spouse_Relative_RawData) phones, UNSIGNED1 PhoneRestrictionMask) := FUNCTION
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getSpousePhones(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phone_Shell.Layouts.Layout_Parent_Spouse_Relative_RawData ri) := TRANSFORM
		
		SElf.Gathered_Phone := ri.subj_phone10;
		
		matchcode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																											ri.Subj_First,						ri.Subj_Last, 						'', 													ri.Prim_Range,						 ri.Prim_Name,						 ri.Addr_Suffix,						 ri.P_City_Name,			ri.St,								ri.Zip5,						 ri.DateOfBirth,						 ri.SSN,						 ri.DID, ri.subj_phone10);
		
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.Subj_Last), 'RM', '');
		
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate((STRING)ri.subj_date_first);
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((STRING)ri.subj_date_last);
		
		SELF.Sources.Source_Owner_Name_First 	:= ri.subj_first;
		SELF.Sources.Source_Owner_Name_Middle := ri.subj_middle;
		SELF.Sources.Source_Owner_Name_Last 	:= ri.subj_last;
		SELF.Sources.Source_Owner_Name_Suffix := ri.subj_suffix;
		SELF.Sources.Source_Owner_DID := (STRING)ri.DID;
		
		// A co resident is just a person who can lead to subject contact.
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject;
		
		addrMatch := StringLib.StringFind(matchcode, 'A', 1) > 0;
		ssnMatch := StringLib.StringFind(matchcode, 'S', 1) > 0;
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(TRIM(ri.subj_phone_relationship) <> ''	=> TRIM(ri.subj_phone_relationship),
																															ssnMatch																=> 'Associate By SSN',
																															addrMatch																=> 'Associate By Address',
																																																				 'Associate'
																															);

		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchcode;
		
		SELF := le;
	END;
	coResidentPhones := JOIN(input, phones, (STRING)LEFT.Clean_Input.Seq = RIGHT.AcctNo, getSpousePhones(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost)) (TRIM(Sources.Source_List) <> '');

	final := DEDUP(SORT(coResidentPhones, Clean_Input.seq, Gathered_Phone, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))), Clean_Input.seq, Gathered_Phone, Sources.Source_List);
	
	RETURN(final);
END;