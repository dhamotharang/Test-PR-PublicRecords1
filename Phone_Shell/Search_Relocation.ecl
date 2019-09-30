/* ************************************************************************
 * This function searches possible relocation by:													*
 * - LexID (DID):: Source: REL																						*
 ************************************************************************ */

IMPORT Phone_Shell, Relocations, Risk_Indicators, RiskWise, UT, STD;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_Relocation (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, INTEGER RelocationsMaxDaysBefore, INTEGER RelocationsMaxDaysAfter, INTEGER RelocationsTargetRadius, UNSIGNED1 PhoneRestrictionMask,
          UNSIGNED2 PhoneShellVersion = 10) := FUNCTION
          
 IncludeLexIDCounts := if(PhoneShellVersion >= 21,true,false);   // LexID counts/'all' attributes added in PhoneShell version 2.1      
          
	layoutSequenceFinalRecord := RECORD
		Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus;
		DATASET(Relocations.layout_wdtg.final) Relocation;
	END;
	
	layoutSequenceFinalRecord getRelocationsRaw(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le) := TRANSFORM
		SELF.Relocation := CHOOSEN(Relocations.wdtg.get_gong_by_did(le.DID,
																																'',
																																RelocationsTargetRadius,
																																RelocationsMaxDaysBefore,
																																RelocationsMaxDaysAfter), 100);
																																
		SELF := le;
	END;
	
	relocationsRaw := PROJECT(Input, getRelocationsRaw(LEFT));
	
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus normalizeRelocations(layoutSequenceFinalRecord le, Relocations.layout_wdtg.final ri) := TRANSFORM
		
		SElf.Gathered_Phone := TRIM(ri.phone10);
		
		matchcode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone, 
																											ri.name_first,						ri.name_last, 					'', 														ri.Prim_Range,						ri.Prim_Name,							ri.Suffix,										ri.p_city_name,			ri.st,								ri.z5,								'',													'',									ri.DID,	ri.phone10);
		
		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.name_last), 'REL', '');
																				
		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate((STRING)ri.dt_first_seen);
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((STRING)ri.dt_last_seen);
		
		SELF.Sources.Source_Owner_Name_First 	:= ri.name_first;
		SELF.Sources.Source_Owner_Name_Middle := ri.name_middle;
		SELF.Sources.Source_Owner_Name_Last 	:= ri.name_last;
  SELF.Sources.Source_Owner_DID := (STRING)ri.DID;
  
  SELF.Sources.Source_List_All_Last_Seen := if(IncludeLexIDCounts, Phone_Shell.Common.parseDate((STRING)ri.dt_last_seen), '');
  SELF.Sources.Source_Owner_All_DIDs := if(IncludeLexIDCounts, (string)ri.DID, '');

		didMatch := STD.Str.Find(matchcode, 'L', 1) > 0;
		nameMatch := STD.Str.Find(matchcode, 'N', 1) > 0;
		addrMatch := STD.Str.Find(matchcode, 'A', 1) > 0;
		ssnMatch := STD.Str.Find(matchcode, 'S', 1) > 0;
		
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
	
	byDID := NORMALIZE(relocationsRaw, LEFT.Relocation, normalizeRelocations(LEFT, RIGHT));
	
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus get_Alls(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus ri) := TRANSFORM
   self.Sources.Source_List_All_Last_Seen := if(le.Sources.Source_Owner_DID = ri.Sources.Source_Owner_DID, 
                                                   le.Sources.Source_List_All_Last_Seen, 
                                                   le.Sources.Source_List_All_Last_Seen + ',' + ri.Sources.Source_List_All_Last_Seen);
   self.Sources.Source_Owner_All_DIDs := if(le.Sources.Source_Owner_DID = ri.Sources.Source_Owner_DID,
                                               le.Sources.Source_Owner_All_DIDs,
                                               le.Sources.Source_Owner_All_DIDs + ',' + ri.Sources.Source_Owner_All_DIDs);
   self := le;
 end;
 
 sortedRelocations := SORT((byDID ((INTEGER)Gathered_Phone<> 0 AND TRIM(Sources.Source_List) <> '')), Clean_Input.seq, Gathered_Phone, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code)));
  
	final := if(IncludeLexIDCounts,
              ROLLUP(sortedRelocations,
                left.Clean_Input.seq = right.Clean_Input.seq and 
                left.Gathered_Phone = right.Gathered_Phone and 
                left.Sources.Source_List = right.Sources.Source_List,
                get_Alls(left,right)),
              DEDUP(sortedRelocations, Clean_Input.seq, Gathered_Phone, Sources.Source_List)
             );
	
	RETURN(final);
END;