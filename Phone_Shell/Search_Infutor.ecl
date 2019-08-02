/*2013-11-21T00:08:47Z (Lorraine Hill)

*/
/* ************************************************************************
 * This function searches Infutor by:																			*
 * - LexID (DID):: Source: INF																						*
 ************************************************************************ */

IMPORT Infutor, Phone_Shell, RiskWise, doxie, Suppress;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_Infutor (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, UNSIGNED1 PhoneRestrictionMask, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

Layout_Infutor_CCPA := RECORD
unsigned4 global_sid;
Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus;
END;	
  
  Layout_Infutor_CCPA getInfutor(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Infutor.key_infutor_best_did ri) := TRANSFORM
		
		SElf.Gathered_Phone := TRIM(ri.phone);
		
		matchcode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																											ri.fname, 								ri.lname, 								'', 													ri.Prim_Range,						 ri.Prim_Name,						 ri.Suffix,						 				ri.city_name,				ri.St,								ri.Zip,						 		(STRING)ri.dob,							(STRING)ri.ssn,			ri.DID, ri.phone);
		
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.lname), 'INF', '');
																																																	 
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate((STRING)ri.addr_dt_first_seen);
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((STRING)ri.addr_dt_last_seen);
		
		SELF.Sources.Source_Owner_Name_First	:= ri.fname;
		SELF.Sources.Source_Owner_Name_Middle := ri.mname;
		SELF.Sources.Source_Owner_Name_Last		:= ri.lname;
		SELF.Sources.Source_Owner_DID := (STRING)ri.DID;
		
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
		self.global_sid := ri.global_sid;
		SELF := le;
	END;
	
	byDID := JOIN(Input, Infutor.key_infutor_best_did, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.DID) AND (INTEGER)RIGHT.phone <> 0,
																												getInfutor(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost)) (TRIM(Sources.Source_List) <> '');

	final := DEDUP(SORT(byDID, Clean_Input.seq, Gathered_Phone, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code))), Clean_Input.seq, Gathered_Phone, Sources.Source_List);
	
   Infutor_Suppressed := Suppress.MAC_SuppressSource(final, mod_access);
   Infutor_Formatted := PROJECT(Infutor_Suppressed, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
                                                  SELF := LEFT));
	RETURN(Infutor_Formatted);
END;