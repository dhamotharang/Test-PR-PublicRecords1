/* ************************************************************************
 * 			 This function gathers the Inquiries attributes.									*
 ************************************************************************ */

IMPORT Inquiry_AccLogs, Phone_Shell, RiskWise, UT, STD;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Get_Attributes_Inquiries (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input,
                                                                                        UNSIGNED2 PhoneShellVersion = 10 // PhoneShell V1.0 default
                                                                                       ) := FUNCTION
	layoutInquiries := RECORD
		Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus;
		STRING description := '';
		STRING use := '';
		STRING Industry := '';
		INTEGER inquiryMonths := 0;
		STRING productCode := '';
		STRING8 InquiryDate := '';
		UNSIGNED8 InquiryADL := 0;
		STRING120 InquiryAddress := '';
		STRING25 InquiryCity := '';
		STRING2 InquiryState := '';
		STRING5 InquiryZip := '';
		BOOLEAN good_inquiry := FALSE;
	END;
	
	/* ************************************************************************
	 *  Get the Inquiry Records																								*
	 ************************************************************************ */
	layoutInquiries getInquiries(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Inquiry_AccLogs.Key_Inquiry_Phone ri) := TRANSFORM
		good_inquiry := Inquiry_AccLogs.Shell_Constants.Valid_Phone_Shell_Inquiry(ri.search_info.function_description,
																																							ri.bus_intel.use,
																																							ri.search_info.product_code);
		SELF.description := IF(good_inquiry = FALSE, SKIP, ri.search_info.function_description);
		SELF.use := ri.bus_intel.use;
		SELF.productCode := ri.search_info.product_code;
		
		inquiryDate := Phone_Shell.Common.parseDate(TRIM(((STRING)ri.search_info.datetime)[1..8]), TRUE);
		todaysDate := Phone_Shell.Common.parseDate((string) STD.Date.Today(), TRUE);
		inquiryMonths := IF(TRIM(inquiryDate) <> '', Std.Date.MonthsBetween((INTEGER)inquiryDate, (INTEGER)todaysDate), -1);
		
		sameADL := le.Clean_Input.DID = ri.person_q.appended_adl;
			
		// If the DID discovered from input matches the inquiry DID count this inquiry
  // PhoneShell V2+ implement a fix here to ignore sameADL for non-ADL counts, and add 6-month limit to Inq_Num_06
		SELF.Inquiries.Inq_Num := if(PhoneShellVersion >= 20, '1', IF(sameADL, '1', ''));
		SELF.Inquiries.Inq_Num_06 := map(PhoneShellVersion < 20                    => IF(sameADL, '1', ''),
                                   inquiryMonths >= 0 AND inquiryMonths <= 6 => '1',
                                                                                '');
  
		SELF.Inquiries.Inq_Num_Addresses := '1';
		// Only count if the date is populated (inquiryMonths >= 0) and is within 6 months
		SELF.Inquiries.Inq_Num_Addresses_06 := IF(inquiryMonths >= 0 AND inquiryMonths <= 6, '1', '');
    
  // PhoneShell V2+ implement a fix here to include sameADL for ADL-based counts  
		SELF.Inquiries.Inq_Num_ADLs := if(PhoneShellVersion >= 20, if(sameADL, '1',''), '1');
		// Only count if the date is populated (inquiryMonths >= 0) and is within 6 months
		SELF.Inquiries.Inq_Num_ADLs_06 := IF(inquiryMonths >= 0 AND inquiryMonths <= 6,
                                        if(PhoneShellVersion >= 20, if(sameADL, '1',''), '1')
                                      , '');
    
		SELF.Inquiries.Inq_FirstSeen := (STRING)inquiryMonths;
		SELF.Inquiries.Inq_LastSeen := (STRING)inquiryMonths;
		SELF.Inquiries.Inq_ADL_FirstSeen := IF(sameADL, (STRING)inquiryMonths, '');
		SELF.Inquiries.Inq_ADL_LastSeen := IF(sameADL, (STRING)inquiryMonths, '');
			
 		industry    := TRIM(ri.bus_intel.industry);
 		submarket   := TRIM(ri.bus_intel.sub_market);
 		SELF.Inquiries.Inq_ADL_Phone_Industry_List_12 := IF(sameADL AND inquiryMonths >= 0 AND inquiryMonths <= 12,                                            
 	                                                   IF(industry IN Inquiry_AccLogs.shell_constants.unassigned_industry, submarket, industry),              
 	 				  																				 '');
		SELF.InquiryDate := inquiryDate;
		SELF.Industry := industry;
		SELF.inquiryMonths := inquiryMonths;
		SELF.InquiryADL := ri.person_q.appended_adl;
		SELF.InquiryAddress := ri.person_q.address;
		SELF.InquiryCity := ri.person_q.city;
		SELF.InquiryState := ri.person_q.state;
		SELF.InquiryZip := ri.person_q.zip[1..5];
		
		SELF.good_inquiry := good_inquiry;
		
		SELF := le;
	END;
	
	inquiryResults := JOIN(Input, Inquiry_AccLogs.Key_Inquiry_Phone, TRIM(LEFT.Gathered_Phone) <> '' AND	KEYED(LEFT.Gathered_Phone = RIGHT.phone10),
																	getInquiries(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost)) (good_inquiry = TRUE);
																	
	/* ************************************************************************
	 *  Count the various inquiry records																			*
	 ************************************************************************ */
	// Figure out how many unique ADL's we found
	uniqueDID := DEDUP(SORT(inquiryResults, Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, InquiryADL, -Inquiries.Inq_Num_ADLs_06, -Inquiries.Inq_Num_ADLs), Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, InquiryADL);
	
	// Figure out how many unique Addresses we found
	uniqueAddress := DEDUP(SORT(inquiryResults, Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, InquiryZip, InquiryState, InquiryCity, InquiryAddress, -Inquiries.Inq_Num_Addresses_06, -Inquiries.Inq_Num_Addresses), Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, InquiryZip, InquiryState, InquiryCity, InquiryAddress);
	
	// Now roll everything up for counting
	layoutInquiries rollDID(layoutInquiries le, layoutInquiries ri) := TRANSFORM
		SELF.Inquiries.Inq_Num_ADLs := (STRING)((INTEGER)le.Inquiries.Inq_Num_ADLs + (INTEGER)ri.Inquiries.Inq_Num_ADLs);
		SELF.Inquiries.Inq_Num_ADLs_06 := (STRING)((INTEGER)le.Inquiries.Inq_Num_ADLs_06 + (INTEGER)ri.Inquiries.Inq_Num_ADLs_06);
		
		SELF := le;
	END;
	countedDID := ROLLUP(uniqueDID, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																								rollDID(LEFT, RIGHT));
	
	layoutInquiries rollAddress(layoutInquiries le, layoutInquiries ri) := TRANSFORM
		SELF.Inquiries.Inq_Num_Addresses := (STRING)((INTEGER)le.Inquiries.Inq_Num_Addresses + (INTEGER)ri.Inquiries.Inq_Num_Addresses);
		SELF.Inquiries.Inq_Num_Addresses_06 := (STRING)((INTEGER)le.Inquiries.Inq_Num_Addresses_06 + (INTEGER)ri.Inquiries.Inq_Num_Addresses_06);
		
		SELF := le;
	END;
	countedAddress := ROLLUP(uniqueAddress, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																								rollAddress(LEFT, RIGHT));
																								
	layoutInquiries rollInquiries(layoutInquiries le, layoutInquiries ri) := TRANSFORM
		SELF.Inquiries.Inq_Num := (STRING)((INTEGER)le.Inquiries.Inq_Num + (INTEGER)ri.Inquiries.Inq_Num);
  // For Phone Shell V2 fix this rollup to roll up the correct field
		SELF.Inquiries.Inq_Num_06 := (STRING)(if(PhoneShellVersion >= 20,(integer)le.inquiries.inq_num_06 + (integer)ri.inquiries.inq_num_06,
                                                                   (INTEGER)le.Inquiries.Inq_Num + (INTEGER)ri.Inquiries.Inq_Num));
                                                                   
                                                                   
		SELF.Inquiries.Inq_FirstSeen := MAP((INTEGER)le.Inquiries.Inq_FirstSeen = 0 => ri.Inquiries.Inq_FirstSeen,
																				(INTEGER)ri.Inquiries.Inq_FirstSeen = 0 => le.Inquiries.Inq_FirstSeen,
																																									 (STRING)MAX((INTEGER)le.Inquiries.Inq_FirstSeen, (INTEGER)ri.Inquiries.Inq_FirstSeen));
		SELF.Inquiries.Inq_LastSeen := MAP((INTEGER)le.Inquiries.Inq_LastSeen = 0 => ri.Inquiries.Inq_LastSeen,
																			 (INTEGER)ri.Inquiries.Inq_LastSeen = 0 => le.Inquiries.Inq_LastSeen,
																																								 (STRING)MIN((INTEGER)le.Inquiries.Inq_LastSeen, (INTEGER)ri.Inquiries.Inq_LastSeen));
		SELF.Inquiries.Inq_ADL_FirstSeen := MAP((INTEGER)le.Inquiries.Inq_ADL_FirstSeen = 0 => ri.Inquiries.Inq_ADL_FirstSeen,
																						(INTEGER)ri.Inquiries.Inq_ADL_FirstSeen = 0 => le.Inquiries.Inq_ADL_FirstSeen,
																																													 (STRING)MAX((INTEGER)le.Inquiries.Inq_ADL_FirstSeen, (INTEGER)ri.Inquiries.Inq_ADL_FirstSeen));
		SELF.Inquiries.Inq_ADL_LastSeen := MAP((INTEGER)le.Inquiries.Inq_ADL_LastSeen = 0 => ri.Inquiries.Inq_ADL_LastSeen,
																					 (INTEGER)ri.Inquiries.Inq_ADL_LastSeen = 0 => le.Inquiries.Inq_ADL_LastSeen,
																																												 (STRING)MIN((INTEGER)le.Inquiries.Inq_ADL_LastSeen, (INTEGER)ri.Inquiries.Inq_ADL_LastSeen));
		// If we haven't already found this industry, add it to the list
		leftInq := TRIM(le.Inquiries.Inq_ADL_Phone_Industry_List_12);
		rightInq := TRIM(ri.Inquiries.Inq_ADL_Phone_Industry_List_12);
		SELF.Inquiries.Inq_ADL_Phone_Industry_List_12 := MAP(leftInq = '' 																	=> rightInq,
																												                           rightInq = '' 																=> leftInq,
																												          StringLib.StringFind(leftInq, rightInq, 1) > 0 => leftInq,
																																																					                                   leftInq + ',' + rightInq);
		
		SELF := le;
	END;
	sortedInquiryResults := SORT(inquiryResults, Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, LENGTH(TRIM(Inquiries.Inq_ADL_Phone_Industry_List_12)), Inquiries.Inq_ADL_Phone_Industry_List_12);
	
	countedInquiries := ROLLUP(sortedInquiryResults, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																								rollInquiries(LEFT, RIGHT));
																								
	/* ************************************************************************
	 *  Combine the inquiries back together																		*
	 ************************************************************************ */
	withDID := JOIN(Input, countedDID, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(layoutInquiries,
																																																									SELF.Inquiries.Inq_Num_ADLs := RIGHT.Inquiries.Inq_Num_ADLs;
																																																									SELF.Inquiries.Inq_Num_ADLs_06 := RIGHT.Inquiries.Inq_Num_ADLs_06;
																																																									SELF.good_inquiry := RIGHT.good_inquiry; // Used for cleaning below
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	withAddress := JOIN(withDID, countedAddress, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(layoutInquiries,
																																																									SELF.Inquiries.Inq_Num_Addresses := RIGHT.Inquiries.Inq_Num_Addresses;
																																																									SELF.Inquiries.Inq_Num_Addresses_06 := RIGHT.Inquiries.Inq_Num_Addresses_06;
																																																									SELF.good_inquiry := RIGHT.good_inquiry; // Used for cleaning below
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
																																																									
	withInquiries := JOIN(withAddress, countedInquiries, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(layoutInquiries,
																																																									SELF.Inquiries.Inq_Num := RIGHT.Inquiries.Inq_Num;
																																																									SELF.Inquiries.Inq_Num_06 := RIGHT.Inquiries.Inq_Num_06;
																																																									SELF.Inquiries.Inq_FirstSeen := RIGHT.Inquiries.Inq_FirstSeen;
																																																									SELF.Inquiries.Inq_LastSeen := RIGHT.Inquiries.Inq_LastSeen;
																																																									SELF.Inquiries.Inq_ADL_FirstSeen := RIGHT.Inquiries.Inq_ADL_FirstSeen;
																																																									SELF.Inquiries.Inq_ADL_LastSeen := RIGHT.Inquiries.Inq_ADL_LastSeen;
																																																									SELF.Inquiries.Inq_ADL_Phone_Industry_List_12 := RIGHT.Inquiries.Inq_ADL_Phone_Industry_List_12;
																																																									SELF.good_inquiry := RIGHT.good_inquiry; // Used for cleaning below
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus cleanInquiries(layoutInquiries le) := TRANSFORM
		// If we have an inquiry hit, but didn't have a count for a certain field, populate it with a 0 instead of blank
		SELF.Inquiries.Inq_Num := IF(le.good_inquiry AND TRIM(le.Inquiries.Inq_Num) = '', '0', le.Inquiries.Inq_Num);
		SELF.Inquiries.Inq_Num_06 := IF(le.good_inquiry AND TRIM(le.Inquiries.Inq_Num_06) = '', '0', le.Inquiries.Inq_Num_06);
		SELF.Inquiries.Inq_Num_ADLs := IF(le.good_inquiry AND TRIM(le.Inquiries.Inq_Num_ADLs) = '', '0', le.Inquiries.Inq_Num_ADLs);
		SELF.Inquiries.Inq_Num_ADLs_06 := IF(le.good_inquiry AND TRIM(le.Inquiries.Inq_Num_ADLs_06) = '', '0', le.Inquiries.Inq_Num_ADLs_06);
		SELF.Inquiries.Inq_Num_Addresses := IF(le.good_inquiry AND TRIM(le.Inquiries.Inq_Num_Addresses) = '', '0', le.Inquiries.Inq_Num_Addresses);
		SELF.Inquiries.Inq_Num_Addresses_06 := IF(le.good_inquiry AND TRIM(le.Inquiries.Inq_Num_Addresses_06) = '', '0', le.Inquiries.Inq_Num_Addresses_06);
		SELF.Inquiries.Inq_FirstSeen := IF(le.good_inquiry AND TRIM(le.Inquiries.Inq_FirstSeen) = '', '0', le.Inquiries.Inq_FirstSeen);
		SELF.Inquiries.Inq_LastSeen := IF(le.good_inquiry AND TRIM(le.Inquiries.Inq_LastSeen) = '', '0', le.Inquiries.Inq_LastSeen);
		SELF.Inquiries.Inq_ADL_FirstSeen := IF(le.good_inquiry AND TRIM(le.Inquiries.Inq_ADL_FirstSeen) = '', '0', le.Inquiries.Inq_ADL_FirstSeen);
		SELF.Inquiries.Inq_ADL_LastSeen := IF(le.good_inquiry AND TRIM(le.Inquiries.Inq_ADL_LastSeen) = '', '0', le.Inquiries.Inq_ADL_LastSeen);
		SELF.Inquiries.Inq_ADL_Phone_Industry_List_12 := le.Inquiries.Inq_ADL_Phone_Industry_List_12;
		
		SELF := le;
	END;
	
	cleanedInquiries := PROJECT(withInquiries, cleanInquiries(LEFT));
	
	// OUTPUT(CHOOSEN(inquiryResults, 100), NAMED('inquiryResults'));
	// OUTPUT(CHOOSEN(uniqueDID, 100), NAMED('uniqueDID'));
	// OUTPUT(CHOOSEN(uniqueAddress, 100), NAMED('uniqueAddress'));
	// OUTPUT(CHOOSEN(countedDID, 100), NAMED('countedDID'));
	// OUTPUT(CHOOSEN(countedAddress, 100), NAMED('countedAddress'));
	// OUTPUT(CHOOSEN(countedInquiries, 100), NAMED('countedInquiries'));
 // output(choosen(sortedInquiryResults, 100), named('sortedInquiryResults'));
	// OUTPUT(CHOOSEN(withDID, 100), NAMED('withDID'));
	// OUTPUT(CHOOSEN(withAddress, 100), NAMED('withAddress'));
	// OUTPUT(CHOOSEN(withInquiries, 100), NAMED('withInquiries'));
	
	RETURN(cleanedInquiries);
END;