import business_header, business_header_ss, DID_Add, ut, MDR;

export fAppend_ADLS(DATASET(CNLD_Practitioner.layouts.keybuild) pKeyBuildFile) := FUNCTION

		layout	:=	CNLD_Practitioner.layouts.keybuild;

		Did_Matchset := ['A','P','D','S' ];   	// 	'A'=Address,'D'=DOB,'S'=ssn,'P'=phone,'Q'=non-fuzzy address match,
																						//	'4'=ssn4 matching,'G'=age matching,'Z'=zip code matching
			
		DID_Add.MAC_Match_Flex(
														pKeyBuildFile			// Input Dataset
														,Did_Matchset   	// Did_Matchset  what fields to match on
														,SSN							// ssn
														,dob							// dob
														,fname						// fname
														,mname						// mname
														,lname						// lname
														,name_suffix			// name_suffix
														,prim_range				// prim_range
														,prim_name				// prim_name
														,sec_range				// sec_range
														,zip							// zip5
														,st								// state
														,address_phone		// phone
														,did							// Did
														,layout						// output layout
														,false						// Does output record have the score
														,did_score				// did score field
														,75								// score threshold
														,dDidOut					// output dataset       
													 ); 
												
		AllDIDs	:=	dedup(sort(distribute(dDidOut,hash(gennum)),record,local),record,local);
												
		return AllDIDs;
end;