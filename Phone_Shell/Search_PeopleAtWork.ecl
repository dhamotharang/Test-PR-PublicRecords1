/* ************************************************************************
 * This function searches People At Work by:															*
 * - LexID (DID):: Source: PAW																						*
 ************************************************************************ */

IMPORT Phone_Shell, RiskWise, PAW, doxie, STD, Suppress;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_PeopleAtWork (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, UNSIGNED1 PhoneRestrictionMask, 
         UNSIGNED2 PhoneShellVersion = 10, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
	 /* ***************************************************************
		* 								Get the Contact ID by DID											*
	  *************************************************************** */
	layoutContactID := RECORD
		UNSIGNED8 ContactID := 0;
		UNSIGNED4 PAW_Confidence_Score := 0;
		Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus;
	END;
	
	layoutContactID getContactID(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, PAW.Key_DID ri) := TRANSFORM
		SELF.ContactID := ri.Contact_ID;
		SELF := le;
	END;
	withContactID := JOIN(input, PAW.Key_DID, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.DID) AND RIGHT.Contact_ID <> 0, getContactID(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));

	 /* ***************************************************************
		* 							Get the People at Work Data											*
	  *************************************************************** */
 IncludeLexIDCounts := if(PhoneShellVersion >= 21,true,false);   // LexID counts/'all' attributes added in PhoneShell version 2.1     
    
	{layoutContactID, unsigned4 global_sid} getPhones(layoutContactID le, PAW.Key_ContactID ri) := TRANSFORM
		SELF.global_sid := ri.global_sid;
		
		SELF.Gathered_Phone := TRIM(ri.Company_Phone);
		
		matchCode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																											ri.fname, 								ri.lname, 								'', 														ri.Prim_Range,						ri.Prim_Name,							ri.Addr_Suffix,							ri.City,							ri.State,							ri.Zip,							'',													ri.SSN,							ri.DID,	ri.Company_Phone);
										
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.lname), 'PAW', '');
		
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate((STRING)ri.dt_first_seen);
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((STRING)ri.dt_last_seen);
		
		SELF.Sources.Source_Owner_Name_First := ri.fname;
		SELF.Sources.Source_Owner_Name_Middle := ri.mname;
		SELF.Sources.Source_Owner_Name_Last := ri.lname;
		SELF.Sources.Source_Owner_Name_Suffix := ri.name_suffix;
		SELF.Sources.Source_Owner_DID := (STRING)ri.DID;
		
  SELF.Sources.Source_List_All_Last_Seen := if(IncludeLexIDCounts, Phone_Shell.Common.parseDate((STRING)ri.dt_last_seen),'');
  SELF.Sources.Source_Owner_All_DIDs := if(IncludeLexIDCounts, (string)ri.DID, '');    
    
		didMatch := STD.Str.Find(matchcode, 'L', 1) > 0;
		nameMatch := STD.Str.Find(matchcode, 'N', 1) > 0;
		addrMatch := STD.Str.Find(matchcode, 'A', 1) > 0;
		ssnMatch := STD.Str.Find(matchcode, 'S', 1) > 0;
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MAP(didMatch AND nameMatch => Phone_Shell.Constants.Phone_Subject_Level.Subject,
																															didMatch AND addrMatch => Phone_Shell.Constants.Phone_Subject_Level.Household,
																																												Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject);
		
		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(didMatch AND nameMatch			=> 'Subject', 
																															didMatch AND addrMatch			=> 'Subject at Household',
																															ssnMatch										=> 'Associate By SSN',
																															addrMatch										=> 'Associate By Address',
																																														 'Associate By Business'
																															);

		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchCode;
		
		SELF.PAW_Confidence_Score := (UNSIGNED)ri.score;
		
		SELF := le;
	END;
	
	withPeopleAtWork_unsuppressed := JOIN(withContactID, PAW.Key_ContactID, KEYED(LEFT.ContactID = RIGHT.Contact_ID) AND (INTEGER)RIGHT.Company_Phone <> 0, getPhones(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
	
	withPeopleAtWork := Suppress.Suppress_ReturnOldLayout(withPeopleAtWork_unsuppressed, mod_access, layoutContactID);

	layoutContactID get_Alls(layoutContactID le, layoutContactID ri) := TRANSFORM
   self.Sources.Source_List_All_Last_Seen := if(le.Sources.Source_Owner_DID = ri.Sources.Source_Owner_DID, 
                                                   le.Sources.Source_List_All_Last_Seen, 
                                                   le.Sources.Source_List_All_Last_Seen + ',' + ri.Sources.Source_List_All_Last_Seen);
   self.Sources.Source_Owner_All_DIDs := if(le.Sources.Source_Owner_DID = ri.Sources.Source_Owner_DID,
                                               le.Sources.Source_Owner_All_DIDs,
                                               le.Sources.Source_Owner_All_DIDs + ',' + ri.Sources.Source_Owner_All_DIDs);
   self := le;
 end;

 sortedPeopleAtWork := SORT(withPeopleAtWork, Clean_Input.Seq, Gathered_Phone, -PAW_Confidence_Score, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code)));

	uniquePhones := if(IncludeLexIDCounts,
                    ROLLUP(sortedPeopleAtWork,
                      left.Clean_Input.seq = right.Clean_Input.seq and 
                      left.Gathered_Phone = right.Gathered_Phone and 
                      left.Sources.Source_List = right.Sources.Source_List,
                      get_Alls(left,right)),
                    DEDUP(sortedPeopleAtWork, Clean_Input.seq, Gathered_Phone, Sources.Source_List)
                   );

	final := PROJECT(uniquePhones, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF := LEFT));

	RETURN(final);
END;