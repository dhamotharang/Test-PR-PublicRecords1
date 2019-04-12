/*Now (lhill)
Text In Open Window
*/
/*2013-11-21T00:11:15Z (Lorraine Hill)

*/
/* ************************************************************************
 * This function searches Utility by:																			*
 * - LexID (DID):: Source: UtilDID																				*
 ************************************************************************ */

IMPORT Phone_Shell, Risk_Indicators, RiskWise, UT, Utilfile, STD, Doxie;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_Utility (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, UNSIGNED1 GLBPurpose, UNSIGNED1 PhoneRestrictionMask, STRING30 IndustryClass) := FUNCTION
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getUtility(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Utilfile.Key_DID ri) := TRANSFORM
		
		SELF.Gathered_Phone := IF((INTEGER)ri.phone <> 0, TRIM(ri.phone), TRIM(ri.work_phone));
		
		matchcode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																											ri.fname, 								ri.lname, 								'', 													ri.Prim_Range,						 ri.Prim_Name,						 ri.Addr_Suffix,						 ri.p_city_name,			ri.St,								ri.Zip,						 	ri.dob,												ri.ssn,						ri.s_DID, IF(TRIM(ri.phone) <> '', ri.phone, ri.work_phone));
																																														
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.lname), 'UtilDID', '');
																																																	 
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate((STRING)ri.date_first_seen);
		// Utility records don't have a last seen date, use todays date like Input phones
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((STRING)STD.Date.Today());
		
		SELF.Sources.Source_Owner_Name_First := ri.orig_fname;
		SELF.Sources.Source_Owner_Name_Middle := ri.orig_mname;
		SELF.Sources.Source_Owner_Name_Last := ri.orig_lname;
		SELF.Sources.Source_Owner_Name_Suffix := ri.orig_name_suffix;
		SELF.Sources.Source_Owner_DID := (STRING)ri.s_DID;
		
		didMatch := StringLib.StringFind(matchcode, 'L', 1) > 0;
		nameMatch := StringLib.StringFind(matchcode, 'N', 1) > 0;
		addrMatch := StringLib.StringFind(matchcode, 'A', 1) > 0;
		ssnMatch := StringLib.StringFind(matchcode, 'S', 1) > 0;
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MAP(didMatch AND nameMatch	=> Phone_Shell.Constants.Phone_Subject_Level.Subject,
																															didMatch AND addrMatch	=> Phone_Shell.Constants.Phone_Subject_Level.Household,
																																												 Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject);
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(didMatch AND nameMatch			=> 'Subject', 
																															didMatch AND addrMatch			=> 'Subject at Household',
																															ssnMatch										=> 'Associate By SSN',
																															addrMatch										=> 'Associate By Address',
																																														 'Associate'
																															);

		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchcode;
		
		SELF := le;
	END;
	
	byDID := JOIN(Input, Utilfile.Key_DID, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.s_DID) AND 
																					UT.PermissionTools.GLB.OK(GLBPurpose) AND ~Doxie.Compliance.isUtilityRestricted(STD.Str.ToUpperCase(TRIM(IndustryClass))) AND
																					((INTEGER)RIGHT.phone <> 0 OR (INTEGER)RIGHT.work_phone <> 0),
																							getUtility(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost)) (TRIM(Sources.Source_List) <> '');

	final := DEDUP(SORT(byDID, Clean_Input.seq, Gathered_Phone, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))), Clean_Input.seq, Gathered_Phone, Sources.Source_List);

	RETURN(final);
END;