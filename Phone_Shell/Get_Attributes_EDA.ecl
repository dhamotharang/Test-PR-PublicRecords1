/* ************************************************************************
 *        This function gathers the EDA_Characteristics attributes.	      *
 ************************************************************************ */

IMPORT Gong, Phone_Shell, RiskWise, UT, STD;

todays_date := (string) STD.Date.Today();

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Get_Attributes_EDA (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input,
                                                                                  UNSIGNED2 PhoneShellVersion = 10 // default to PhoneShell V1.0, use 20 (for version 2.0) and so on for other versions
                                                                                 ) := FUNCTION
	layoutEDA := RECORD
		Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus;
		STRING8 dt_first_seen := '';
		STRING8 dt_last_seen := '';
		STRING10 Prim_Range := '';
		STRING28 Prim_Name := '';
		STRING4 Suffix := '';
		STRING25 City := '';
		STRING2 State := '';
		STRING5 Zip := '';
  UNSIGNED8 EDA_Total_Days_Connected_Indiv := 0;
  UNSIGNED4 EDA_Total_Times_Connected_Indiv := 0;
  UNSIGNED4 EDA_Avg_Days_Connected_Indiv_V2 := 0;
	END;
	
	/* ************************************************************************
	 *  Get Current EDA Records																								*
	 ************************************************************************ */
	layoutEDA getEDAAttributes(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Gong.key_history_phone ri) := TRANSFORM
		SELF.dt_first_seen := ri.dt_first_seen;
		SELF.dt_last_seen := ri.dt_last_seen;
		SELF.Prim_Range := ri.prim_range;
		SELF.Prim_Name := ri.prim_name;
		SELF.Suffix := ri.suffix;
		SELF.City := ri.p_city_name;
		SELF.State := ri.st;
		SELF.Zip := ri.z5;
		
		// These are populated in Phone_Shell.Search_EDA
		SELF.EDA_Characteristics.EDA_num_phones_indiv := le.EDA_Characteristics.EDA_num_phones_indiv;
		SELF.EDA_Characteristics.EDA_num_phones_connected_indiv := le.EDA_Characteristics.EDA_num_phones_connected_indiv;
		SELF.EDA_Characteristics.EDA_num_phones_discon_indiv := le.EDA_Characteristics.EDA_num_phones_discon_indiv;
		SELF.EDA_Characteristics.EDA_days_indiv_first_seen_with_phone := le.EDA_Characteristics.EDA_days_indiv_first_seen_with_phone;
		SELF.EDA_Characteristics.EDA_is_discon_15_days := le.EDA_Characteristics.EDA_is_discon_15_days;
		SELF.EDA_Characteristics.EDA_is_discon_30_days := le.EDA_Characteristics.EDA_is_discon_30_days;
		SELF.EDA_Characteristics.EDA_is_discon_60_days := le.EDA_Characteristics.EDA_is_discon_60_days;
		SELF.EDA_Characteristics.EDA_is_discon_90_days := le.EDA_Characteristics.EDA_is_discon_90_days;
		SELF.EDA_Characteristics.EDA_is_discon_180_days := le.EDA_Characteristics.EDA_is_discon_180_days;
		SELF.EDA_Characteristics.EDA_is_discon_360_days := le.EDA_Characteristics.EDA_is_discon_360_days;
		
		SELF.EDA_Characteristics.EDA_Omit_Locality := TRIM(ri.omit_locality);
		SELF.EDA_Characteristics.EDA_DID := ri.DID;
		SELF.EDA_Characteristics.EDA_HHID := ri.HHID;
		SELF.EDA_Characteristics.EDA_BDID := ri.BDID;
		SELF.EDA_Characteristics.EDA_Num_Phones_Connected_Addr := IF(TRIM(ri.current_record_flag) IN ['Y', 'y'], 1, 0);
		SELF.EDA_Characteristics.EDA_Num_Phones_Connected_HHID := IF(TRIM(ri.current_record_flag) IN ['Y', 'y'], 1, 0);
		SELF.EDA_Characteristics.EDA_Listing_Name := TRIM(ri.listed_name);
		SELF.EDA_Characteristics.EDA_DID_Count := IF(ri.DID <> 0 OR ri.BDID <> 0, 1, 0); // This needs to be calculated in a rollup below, only count if the record has a DID/BDID associated
		SELF.EDA_Characteristics.EDA_Dt_First_Seen := Phone_Shell.Common.parseDate(TRIM(ri.dt_first_seen), TRUE);
		SELF.EDA_Characteristics.EDA_Dt_Last_Seen := Phone_Shell.Common.parseDate(TRIM(ri.dt_last_seen), TRUE);
		SELF.EDA_Characteristics.EDA_Current_Record_Flag := IF(TRIM(ri.current_record_flag) IN ['Y', 'y'], TRUE, FALSE);
		SELF.EDA_Characteristics.EDA_Deletion_Date := Phone_Shell.Common.parseDate(TRIM(ri.deletion_date), TRUE);
		SELF.EDA_Characteristics.EDA_Disc_Cnt6 := ri.disc_cnt6;
		SELF.EDA_Characteristics.EDA_Disc_Cnt12 := ri.disc_cnt12;
		SELF.EDA_Characteristics.EDA_Disc_Cnt18 := ri.disc_cnt18;
		resCode := StringLib.StringToUpperCase(TRIM(ri.listing_type_res)[1]);
		zip4 := TRIM(ri.z4);
		street := TRIM(ri.prim_name);
		zip := TRIM(ri.z5);
		SELF.EDA_Characteristics.EDA_Pfrd_Address_Ind := MAP(
																													resCode = 'R' AND zip4 <> '' 	=> '1A',
																													zip4 <> '' 										=> '1B',
																													resCode = 'R'									=> '1C',
																													street <> '' AND zip <> '' 		=> '1D',
																													zip <> '' 										=> '1E',
																																													 'XX');
																																														 
		days := ut.DaysApart(todays_date, ri.dt_first_seen);
		adlMatch := le.Clean_Input.did = ri.did AND le.Clean_Input.did <> 0;
		SELF.EDA_Characteristics.EDA_Days_In_Service := days;
		SELF.EDA_Characteristics.EDA_Num_Phone_Owners_Cur := 1; // Take the results of this join and count how many DIDs
		SELF.EDA_Characteristics.EDA_Days_Indiv_First_Seen := IF(adlMatch, days, 0); // Take the MAX of this in the rollup below
		SELF.EDA_Characteristics.EDA_Days_Phone_First_Seen := days; // Take the MAX in the rollup below
		add1IsBest := le.clam.address_verification.input_address_information.isbestmatch;
		add2IsBest := le.clam.address_verification.address_history_1.isbestmatch;
		add3IsBest := le.clam.address_verification.address_history_2.isbestmatch;
		bestPrimRange := MAP(add1IsBest => le.clam.address_verification.input_address_information.prim_range,
												 add2IsBest => le.clam.address_verification.address_history_1.prim_range,
																			 le.clam.address_verification.addresS_history_2.prim_range);
		bestPrimName := MAP(add1IsBest => le.clam.address_verification.input_address_information.prim_name,
										 	  add2IsBest => le.clam.address_verification.address_history_1.prim_name,
																		  le.clam.address_verification.addresS_history_2.prim_name);
		bestSuffix := MAP(add1IsBest => le.clam.address_verification.input_address_information.addr_suffix,
										  add2IsBest => le.clam.address_verification.address_history_1.addr_suffix,
																		le.clam.address_verification.addresS_history_2.addr_suffix);
		bestCity := MAP(add1IsBest => le.clam.address_verification.input_address_information.city_name,
									  add2IsBest => le.clam.address_verification.address_history_1.city_name,
							 									  le.clam.address_verification.addresS_history_2.city_name);
		bestState := MAP(add1IsBest => le.clam.address_verification.input_address_information.st,
										 add2IsBest => le.clam.address_verification.address_history_1.st,
																	 le.clam.address_verification.addresS_history_2.st);
		bestZip := MAP(add1IsBest => le.clam.address_verification.input_address_information.zip5,
									 add2IsBest => le.clam.address_verification.address_history_1.zip5,
																 le.clam.address_verification.addresS_history_2.zip5);
		SELF.EDA_Characteristics.EDA_Address_Match_Best := IF(TRIM(ri.prim_range) = TRIM(bestPrimRange) AND TRIM(ri.prim_name) = TRIM(bestPrimName) AND
																											 TRIM(ri.suffix) = TRIM(bestSuffix) AND TRIM(ri.p_city_name) = TRIM(bestCity) AND TRIM(ri.st) = TRIM(bestState) AND
																											 TRIM(ri.z5) = TRIM(bestZip[1..5]), TRUE, FALSE);
  // For PhoneShell V2+ change order of dates passed in to avoid negative values being returned into an unsigned-type variable
		monthsLast := if(PhoneShellVersion >= 20, Std.Date.MonthsBetween((integer)ri.dt_last_seen,(integer)todays_date),
                                            Std.Date.MonthsBetween((INTEGER)todays_date, (INTEGER)ri.dt_last_seen));
		SELF.EDA_Characteristics.EDA_Months_Addr_Last_Seen := IF(TRIM(ri.prim_range) = TRIM(le.Clean_Input.Prim_Range) AND TRIM(ri.prim_name) = TRIM(le.Clean_Input.Prim_Name) AND
																											 TRIM(ri.suffix) = TRIM(le.Clean_Input.Addr_Suffix) AND TRIM(ri.p_city_name) = TRIM(le.Clean_Input.City) AND TRIM(ri.st) = TRIM(le.Clean_Input.State) AND
																											 TRIM(ri.z5) = TRIM(le.Clean_Input.Zip5), monthsLast, 0); // Take the MIN in the rollup below
		
		SELF := le;
	END;
	
	edaAttributes := JOIN(Input, Gong.key_history_phone, TRIM(LEFT.Gathered_Phone) NOT IN ['', '0'] AND KEYED(LEFT.Gathered_Phone[1..3] = RIGHT.p3 AND LEFT.Gathered_Phone[4..10] = RIGHT.p7) AND RIGHT.current_flag = TRUE,
																				getEDAAttributes(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
																				
	uniqueDIDCurr := DEDUP(SORT(edaAttributes, Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, EDA_Characteristics.EDA_DID, EDA_Characteristics.EDA_BDID), Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, EDA_Characteristics.EDA_DID, EDA_Characteristics.EDA_BDID);
	
	layoutEDA rollUniqueDIDCurr(layoutEDA le, layoutEDA ri) := TRANSFORM
		SELF.EDA_Characteristics.EDA_DID_Count := le.EDA_Characteristics.EDA_DID_Count + 1;
		SELF.EDA_Characteristics.EDA_Num_Phone_Owners_Cur  := le.EDA_Characteristics.EDA_Num_Phone_Owners_Cur + 1;
		
		SELF := le;
	END;
	
	uniqueDIDCountedCurr := ROLLUP(uniqueDIDCurr, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																													rollUniqueDIDCurr(LEFT, RIGHT));
																													
	uniqueAddrCurr := DEDUP(SORT(edaAttributes, Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, Zip, State, City, Prim_Range, Prim_Name, Suffix), Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, Zip, State, City, Prim_Range, Prim_Name, Suffix);
	
	layoutEDA rollUniqueAddrCurr(layoutEDA le, layoutEDA ri) := TRANSFORM
		SELF.EDA_Characteristics.EDA_Num_Phones_Connected_Addr  := le.EDA_Characteristics.EDA_Num_Phones_Connected_Addr + ri.EDA_Characteristics.EDA_Num_Phones_Connected_Addr;
		SELF.EDA_Characteristics.EDA_Num_Phones_Discon_Addr  := le.EDA_Characteristics.EDA_Num_Phones_Discon_Addr + ri.EDA_Characteristics.EDA_Num_Phones_Discon_Addr;
		
		SELF := le;
	END;
	
	uniqueAddrCountedCurr := ROLLUP(uniqueAddrCurr, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																													rollUniqueAddrCurr(LEFT, RIGHT));
	/* ************************************************************************
	 *  Get Historical EDA Records																						*
	 ************************************************************************ */
	layoutEDA getEDAAttributesHist(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Gong.key_history_phone ri) := TRANSFORM
		SELF.dt_first_seen := ri.dt_first_seen;
		SELF.dt_last_seen := ri.dt_last_seen;
		SELF.Prim_Range := ri.prim_range;
		SELF.Prim_Name := ri.prim_name;
		SELF.Suffix := ri.suffix;
		SELF.City := ri.p_city_name;
		SELF.State := ri.st;
		SELF.Zip := ri.z5;
		
		days := ut.DaysApart(todays_date, ri.dt_first_seen);
		adlMatch := le.Clean_Input.did = ri.did AND le.Clean_Input.did <> 0;
		
		SELF.EDA_Characteristics.EDA_Deletion_Date := Phone_Shell.Common.parseDate(TRIM(ri.deletion_date), TRUE);SELF.EDA_Characteristics.EDA_Listing_Name := TRIM(ri.listed_name);
		SELF.EDA_Characteristics.EDA_Dt_First_Seen := Phone_Shell.Common.parseDate(TRIM(ri.dt_first_seen), TRUE);
		SELF.EDA_Characteristics.EDA_Dt_Last_Seen := Phone_Shell.Common.parseDate(TRIM(ri.dt_last_seen), TRUE);
		
		SELF.EDA_Characteristics.EDA_Omit_Locality := TRIM(ri.omit_locality);
		SELF.EDA_Characteristics.EDA_DID := ri.DID;
		SELF.EDA_Characteristics.EDA_HHID := ri.HHID;
		SELF.EDA_Characteristics.EDA_BDID := ri.BDID;
		SELF.EDA_Characteristics.EDA_Num_Phone_Owners_Hist := 1; // Take the results of this join and count how many DIDs
		SELF.EDA_Characteristics.EDA_num_phones_indiv := IF(adlMatch, 1, 0);
		SELF.EDA_Characteristics.EDA_num_phones_discon_indiv := IF(adlMatch, 1, 0);
		daysConnected := ut.DaysApart(ri.dt_first_seen, ri.dt_last_seen);
		SELF.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv := IF(adlMatch, daysConnected, 0);
		SELF.EDA_Characteristics.EDA_Min_Days_Connected_Indiv := IF(adlMatch, daysConnected, 0);
		SELF.EDA_Characteristics.EDA_Max_Days_Connected_Indiv := IF(adlMatch, daysConnected, 0);

  SELF.EDA_Total_Days_Connected_Indiv := if(adlMatch, daysConnected, 0);
  SELF.EDA_Total_Times_Connected_Indiv := if(adlMatch, 1, 0);
    
		SELF.EDA_Characteristics.EDA_days_indiv_first_seen_with_phone := IF(adlMatch, days, 0);
		SELF.EDA_Characteristics.EDA_Days_Indiv_First_Seen := IF(adlMatch, days, 0); // Take the MAX of this in the rollup below
		SELF.EDA_Characteristics.EDA_Num_Phones_Discon_Addr := 1;
		SELF.EDA_Characteristics.EDA_Num_Phones_Discon_HHID := 1;
		SELF.EDA_Characteristics.EDA_Is_Current_In_Hist := FALSE; // Join the current to the historical, if we have a hit this is TRUE
		SELF.EDA_Characteristics.EDA_is_discon_15_days := IF(adlmatch AND daysConnected >= 0 AND daysConnected <= 15, TRUE, FALSE);
		SELF.EDA_Characteristics.EDA_is_discon_30_days := IF(adlmatch AND daysConnected >= 0 AND daysConnected <= 30, TRUE, FALSE);
		SELF.EDA_Characteristics.EDA_is_discon_60_days := IF(adlmatch AND daysConnected >= 0 AND daysConnected <= 60, TRUE, FALSE);
		SELF.EDA_Characteristics.EDA_is_discon_90_days := IF(adlmatch AND daysConnected >= 0 AND daysConnected <= 90, TRUE, FALSE);
		SELF.EDA_Characteristics.EDA_is_discon_180_days := IF(adlmatch AND daysConnected >= 0 AND daysConnected <= 180, TRUE, FALSE);
		SELF.EDA_Characteristics.EDA_is_discon_360_days := IF(adlmatch AND daysConnected >= 0 AND daysConnected <= 360, TRUE, FALSE);
		SELF.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days := IF(daysConnected >= 0 AND daysConnected <= 15, TRUE, FALSE);
		SELF.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days := IF(daysConnected >= 0 AND daysConnected <= 30, TRUE, FALSE);
		SELF.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days := IF(daysConnected >= 0 AND daysConnected <= 60, TRUE, FALSE);
		SELF.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days := IF(daysConnected >= 0 AND daysConnected <= 90, TRUE, FALSE);
		SELF.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days := IF(daysConnected >= 0 AND daysConnected <= 180, TRUE, FALSE);
		SELF.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days := IF(daysConnected >= 0 AND daysConnected <= 360, TRUE, FALSE);
		SELF.EDA_Characteristics.EDA_Days_Phone_First_Seen := days; // Take the MAX in the rollup below
		// For PhoneShell V2+ change order of dates passed in to avoid negative values being returned into an unsigned-type variable
		monthsLast := if(PhoneShellVersion >= 20, Std.Date.MonthsBetween((integer)ri.dt_last_seen,(integer)todays_date),
                                            Std.Date.MonthsBetween((INTEGER)todays_date, (INTEGER)ri.dt_last_seen));
		SELF.EDA_Characteristics.EDA_Months_Addr_Last_Seen := IF(TRIM(ri.prim_range) = TRIM(le.Clean_Input.Prim_Range) AND TRIM(ri.prim_name) = TRIM(le.Clean_Input.Prim_Name) AND
																											 TRIM(ri.suffix) = TRIM(le.Clean_Input.Addr_Suffix) AND TRIM(ri.p_city_name) = TRIM(le.Clean_Input.City) AND TRIM(ri.st) = TRIM(le.Clean_Input.State) AND
																											 TRIM(ri.z5) = TRIM(le.Clean_Input.Zip5), monthsLast, 0); // Take the MIN in the rollup below
		
		// This is populated in the Input and used above in the current TRANSFORM, we don't want to duplicate these in the historical
		SELF.EDA_Characteristics.EDA_num_phones_connected_indiv := 0;
		
		SELF := le;
	END;
	
	edaAttributesHist := JOIN(Input, Gong.key_history_phone, TRIM(LEFT.Gathered_Phone) NOT IN ['', '0'] AND KEYED(LEFT.Gathered_Phone[4..10] = RIGHT.p7 AND LEFT.Gathered_Phone[1..3] = RIGHT.p3) AND RIGHT.current_flag = FALSE,
																				getEDAAttributesHist(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
																				
	uniqueDIDHist := DEDUP(SORT(edaAttributesHist, Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, EDA_Characteristics.EDA_DID, EDA_Characteristics.EDA_BDID), Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, EDA_Characteristics.EDA_DID, EDA_Characteristics.EDA_BDID);
	
	layoutEDA rollUniqueDIDHist(layoutEDA le, layoutEDA ri) := TRANSFORM
		SELF.EDA_Characteristics.EDA_Num_Phone_Owners_Hist  := le.EDA_Characteristics.EDA_Num_Phone_Owners_Hist + 1;
		
		SELF := le;
	END;
	
	uniqueDIDCountedHist := ROLLUP(uniqueDIDHist, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																													rollUniqueDIDHist(LEFT, RIGHT));
																													
	uniqueHHIDHist := DEDUP(SORT(edaAttributesHist, Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, EDA_Characteristics.EDA_HHID), Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, EDA_Characteristics.EDA_HHID);
	
	layoutEDA rollUniqueHHIDHist(layoutEDA le, layoutEDA ri) := TRANSFORM
		SELF.EDA_Characteristics.EDA_Num_Phones_Connected_HHID  := le.EDA_Characteristics.EDA_Num_Phones_Connected_HHID + ri.EDA_Characteristics.EDA_Num_Phones_Connected_HHID;
		SELF.EDA_Characteristics.EDA_Num_Phones_Discon_HHID  := le.EDA_Characteristics.EDA_Num_Phones_Discon_HHID + ri.EDA_Characteristics.EDA_Num_Phones_Discon_HHID;
		
		SELF := le;
	END;
	
	uniqueHHIDCountedHist := ROLLUP(uniqueHHIDHist, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																													rollUniqueHHIDHist(LEFT, RIGHT));
																													
	uniqueAddrHist := DEDUP(SORT(edaAttributesHist, Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, Zip, State, City, Prim_Range, Prim_Name, Suffix), Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, Zip, State, City, Prim_Range, Prim_Name, Suffix);
	
	layoutEDA rollUniqueAddrHist(layoutEDA le, layoutEDA ri) := TRANSFORM
		SELF.EDA_Characteristics.EDA_Num_Phones_Connected_Addr  := le.EDA_Characteristics.EDA_Num_Phones_Connected_Addr + ri.EDA_Characteristics.EDA_Num_Phones_Connected_Addr;
		SELF.EDA_Characteristics.EDA_Num_Phones_Discon_Addr  := le.EDA_Characteristics.EDA_Num_Phones_Discon_Addr + ri.EDA_Characteristics.EDA_Num_Phones_Discon_Addr;
		
		SELF := le;
	END;
	
	uniqueAddrCountedHist := ROLLUP(uniqueAddrHist, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																													rollUniqueAddrHist(LEFT, RIGHT));
																													
	currInHistTemp := JOIN(edaAttributes, edaAttributesHist, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																												TRANSFORM(layoutEDA, SELF.EDA_Characteristics.EDA_Is_Current_In_Hist := TRUE; 
																																						 SELF.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days := RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days;
																																						 SELF.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days := RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days;
																																						 SELF.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days := RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days;
																																						 SELF.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days := RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days;
																																						 SELF.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days := RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days;
																																						 SELF.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days := RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days;
																																							SELF := LEFT), KEEP(RiskWise.max_atmost), ATMOST(RiskWise.max_atmost));
																																							
	currInHist := ROLLUP(currInHistTemp, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																												TRANSFORM(layoutEDA, SELF.EDA_Characteristics.EDA_Is_Current_In_Hist := LEFT.EDA_Characteristics.EDA_Is_Current_In_Hist OR RIGHT.EDA_Characteristics.EDA_Is_Current_In_Hist; 
																																						 SELF.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days := LEFT.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days OR RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days;
																																						 SELF.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days := LEFT.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days OR RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days;
																																						 SELF.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days := LEFT.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days OR RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days;
																																						 SELF.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days := LEFT.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days OR RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days;
																																						 SELF.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days := LEFT.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days OR RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days;
																																						 SELF.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days := LEFT.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days OR RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days;
																																						 SELF := LEFT));
	
	// There are usually multiple EDA Attribute results, sort by most recently seen - and then populate any missing attributes
	sortedEDAAttributes := SORT((edaAttributes + edaAttributesHist), Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, -dt_last_seen, -dt_first_seen);
	
	// We want to count the total number of service interruptions for each phone
	layoutInterrupts := RECORD
		UNSIGNED8 Unique_Record_Sequence := 0;
		UNSIGNED8 Seq := 0;
		STRING10 Gathered_Phone := '';
		STRING10 DateFirstSeen := '';
		STRING10 DateLastSeen := '';
		STRING10 DeletedDate := '';
		UNSIGNED4 NumberInterrupts := 0;
		UNSIGNED4 AverageDaysInterrupt := 0;
		UNSIGNED4 MinDaysInterrupt := 0;
		UNSIGNED4 MaxDaysInterrupt := 0;
  UNSIGNED8 TotalDaysInterrupt := 0;
  UNSIGNED4 AverageDaysInterrupt_V2 := 0;
	END;
	interrupts := PROJECT(sortedEDAAttributes, TRANSFORM(layoutInterrupts,
																											SELF.Unique_Record_Sequence := LEFT.Unique_Record_Sequence;
																											SELF.Seq := LEFT.Clean_Input.Seq;
																											SELF.Gathered_Phone := LEFT.Gathered_Phone;
																											SELF.DeletedDate := LEFT.EDA_Characteristics.EDA_Deletion_Date;
																											SELF.DateFirstSeen := LEFT.dt_first_seen;
																											SELF.DateLastSeen := LEFT.dt_last_seen;
																											SELF.NumberInterrupts := LEFT.EDA_Characteristics.EDA_Num_Interrupts_Cur;
																											SELF.AverageDaysInterrupt := 999999999; // Set to 999999999 so we can distiguish initial values from true zeros
																											SELF.MinDaysInterrupt := 999999999;
																											SELF.MaxDaysInterrupt := 999999999;
                           SELF.TotalDaysInterrupt := 999999999;
                           SELF.AverageDaysInterrupt_V2 := 999999999));
																											
	uniqueDateInterrupts := DEDUP(SORT(interrupts, Unique_Record_Sequence, Seq, Gathered_Phone, -DateLastSeen, DateFirstSeen, -DeletedDate), Unique_Record_Sequence, Seq, Gathered_Phone, DateLastSeen) ((INTEGER)DateLastSeen <> 0 AND (INTEGER)DateFirstSeen <> 0);
	
	layoutInterrupts rollInterrupts(layoutInterrupts le, layoutInterrupts ri) := TRANSFORM
		SELF.NumberInterrupts := le.NumberInterrupts + 1; // If we have a deletion date we have a new interruption
		
		days := UT.DaysApart(le.DateFirstSeen, ri.DateLastSeen);
		SELF.AverageDaysInterrupt := IF(le.AverageDaysInterrupt = 999999999, days, ABS(AVE(le.AverageDaysInterrupt, days)));
		SELF.MinDaysInterrupt := IF(le.MinDaysInterrupt = 999999999, days, ABS(MIN(le.MinDaysInterrupt, days)));
		SELF.MaxDaysInterrupt := IF(le.MaxDaysInterrupt = 999999999, days, ABS(MAX(le.MaxDaysInterrupt, days)));
  SELF.TotalDaysInterrupt := if(le.TotalDaysInterrupt = 999999999, days, le.TotalDaysInterrupt + days);
		
		// Keep the dates from the next record so we can do the comparison again
		SELF.DeletedDate := ri.DeletedDate;
		SELF.DateFirstSeen := ri.DateFirstSeen;
		SELF.DateLastSeen := ri.DateLastSeen;
		
		SELF := le;
	END;
	countedInterrupts := ROLLUP(uniqueDateInterrupts, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Seq = RIGHT.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone, rollInterrupts(LEFT, RIGHT));
	
	layoutInterrupts cleanInterrupts(layoutInterrupts le) := TRANSFORM
		SELF.AverageDaysInterrupt := IF(le.AverageDaysInterrupt = 999999999, 0, le.AverageDaysInterrupt);
		SELF.MinDaysInterrupt := IF(le.MinDaysInterrupt = 999999999, 0, le.MinDaysInterrupt);
		SELF.MaxDaysInterrupt := IF(le.MaxDaysInterrupt = 999999999, 0, le.MaxDaysInterrupt);
  SELF.TotalDaysInterrupt := if(le.TotalDaysInterrupt = 999999999, 0, le.TotalDaysInterrupt);
  SELF.AverageDaysInterrupt_V2 := if(le.TotalDaysInterrupt = 999999999 or le.NumberInterrupts = 0, 0, truncate(le.TotalDaysInterrupt / le.NumberInterrupts));

		SELF := le;
	END;
	cleanedInterrupts := PROJECT(countedInterrupts, cleanInterrupts(LEFT));
	
	layoutEDA rollEDAAttributes(layoutEDA le, layoutEDA ri) := TRANSFORM
		SELF.EDA_Characteristics.EDA_Omit_Locality := MAP(TRIM(le.EDA_Characteristics.EDA_Omit_Locality) = 'Y' => 'Y',
																											TRIM(ri.EDA_Characteristics.EDA_Omit_Locality) = 'Y' => 'Y',
																											TRIM(ri.EDA_Characteristics.EDA_Omit_Locality) <> '' => ri.EDA_Characteristics.EDA_Omit_Locality,
																																																							le.EDA_Characteristics.EDA_Omit_Locality);
		SELF.EDA_Characteristics.EDA_DID := IF(le.EDA_Characteristics.EDA_DID <> 0, le.EDA_Characteristics.EDA_DID, ri.EDA_Characteristics.EDA_DID);
		SELF.EDA_Characteristics.EDA_HHID := IF(le.EDA_Characteristics.EDA_HHID <> 0, le.EDA_Characteristics.EDA_HHID, ri.EDA_Characteristics.EDA_HHID);
		SELF.EDA_Characteristics.EDA_BDID := IF(le.EDA_Characteristics.EDA_BDID <> 0, le.EDA_Characteristics.EDA_BDID, ri.EDA_Characteristics.EDA_BDID);
		SELF.EDA_Characteristics.EDA_Listing_Name := IF(TRIM(le.EDA_Characteristics.EDA_Listing_Name) <> '', le.EDA_Characteristics.EDA_Listing_Name, ri.EDA_Characteristics.EDA_Listing_Name);
		SELF.EDA_Characteristics.EDA_DID_Count := IF(le.EDA_Characteristics.EDA_DID_Count <> 0, le.EDA_Characteristics.EDA_DID_Count, ri.EDA_Characteristics.EDA_DID_Count);
		SELF.EDA_Characteristics.EDA_Dt_First_Seen := IF(TRIM(le.EDA_Characteristics.EDA_Dt_First_Seen) <> '', le.EDA_Characteristics.EDA_Dt_First_Seen, ri.EDA_Characteristics.EDA_Dt_First_Seen);
		SELF.EDA_Characteristics.EDA_Dt_Last_Seen := IF(TRIM(le.EDA_Characteristics.EDA_Dt_Last_Seen) <> '', le.EDA_Characteristics.EDA_Dt_Last_Seen, ri.EDA_Characteristics.EDA_Dt_Last_Seen);
		SELF.EDA_Characteristics.EDA_Current_Record_Flag := le.EDA_Characteristics.EDA_Current_Record_Flag OR ri.EDA_Characteristics.EDA_Current_Record_Flag;
		SELF.EDA_Characteristics.EDA_Deletion_Date := IF(TRIM(le.EDA_Characteristics.EDA_Deletion_Date) <> '', le.EDA_Characteristics.EDA_Deletion_Date, ri.EDA_Characteristics.EDA_Deletion_Date);
		SELF.EDA_Characteristics.EDA_Disc_Cnt6 := IF(le.EDA_Characteristics.EDA_Disc_Cnt6 <> 0, le.EDA_Characteristics.EDA_Disc_Cnt6, ri.EDA_Characteristics.EDA_Disc_Cnt6);
		SELF.EDA_Characteristics.EDA_Disc_Cnt12 := IF(le.EDA_Characteristics.EDA_Disc_Cnt12 <> 0, le.EDA_Characteristics.EDA_Disc_Cnt12, ri.EDA_Characteristics.EDA_Disc_Cnt12);
		SELF.EDA_Characteristics.EDA_Disc_Cnt18 := IF(le.EDA_Characteristics.EDA_Disc_Cnt18 <> 0, le.EDA_Characteristics.EDA_Disc_Cnt18, ri.EDA_Characteristics.EDA_Disc_Cnt18);
		SELF.EDA_Characteristics.EDA_Pfrd_Address_Ind := IF(TRIM(le.EDA_Characteristics.EDA_Pfrd_Address_Ind) <> '', le.EDA_Characteristics.EDA_Pfrd_Address_Ind, ri.EDA_Characteristics.EDA_Pfrd_Address_Ind);
		SELF.EDA_Characteristics.EDA_Days_In_Service := MAX(le.EDA_Characteristics.EDA_Days_In_Service, ri.EDA_Characteristics.EDA_Days_In_Service);
		SELF.EDA_Characteristics.EDA_Num_Phone_Owners_Hist := le.EDA_Characteristics.EDA_Num_Phone_Owners_Hist + ri.EDA_Characteristics.EDA_Num_Phone_Owners_Hist;
		SELF.EDA_Characteristics.EDA_Num_Phone_Owners_Cur := le.EDA_Characteristics.EDA_Num_Phone_Owners_Cur + ri.EDA_Characteristics.EDA_Num_Phone_Owners_Cur;
		SELF.EDA_Characteristics.EDA_Num_Phones_Indiv := le.EDA_Characteristics.EDA_Num_Phones_Indiv + ri.EDA_Characteristics.EDA_Num_Phones_Indiv;
		SELF.EDA_Characteristics.EDA_Num_Phones_Connected_Indiv := le.EDA_Characteristics.EDA_Num_Phones_Connected_Indiv + ri.EDA_Characteristics.EDA_Num_Phones_Connected_Indiv;
		SELF.EDA_Characteristics.EDA_Num_Phones_Discon_Indiv := le.EDA_Characteristics.EDA_Num_Phones_Discon_Indiv + ri.EDA_Characteristics.EDA_Num_Phones_Discon_Indiv;

  totaldays := le.EDA_Total_Days_Connected_Indiv + ri.EDA_Total_Days_Connected_Indiv;
  totaltimes := le.EDA_Total_Times_Connected_Indiv + ri.EDA_Total_Times_Connected_Indiv;
  avgdays := if(totaltimes = 0, 0, truncate(totaldays / totaltimes));
  SELF.EDA_Total_Days_Connected_Indiv := totaldays;
  SELF.EDA_Total_Times_Connected_Indiv := totaltimes;
  SELF.EDA_Avg_Days_Connected_Indiv_V2 := avgdays;
  
  // phone shell v2+ use the different average calculation
  SELF.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv := if(PhoneShellVersion >= 20, avgdays,
                                                              MAP(le.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv <> 0 AND ri.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv <> 0 => AVE(le.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv, ri.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv),
																																                                  le.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv <> 0																										                              					 => le.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv,
																																																																																													                                                                                              ri.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv)
                                                             );
                                                                                                                                                                                          
		SELF.EDA_Characteristics.EDA_Min_Days_Connected_Indiv := MAP(le.EDA_Characteristics.EDA_Min_Days_Connected_Indiv <> 0 AND ri.EDA_Characteristics.EDA_Min_Days_Connected_Indiv <> 0 => MIN(le.EDA_Characteristics.EDA_Min_Days_Connected_Indiv, ri.EDA_Characteristics.EDA_Min_Days_Connected_Indiv),
																																 le.EDA_Characteristics.EDA_Min_Days_Connected_Indiv <> 0																															 => le.EDA_Characteristics.EDA_Min_Days_Connected_Indiv,
																																																																																													ri.EDA_Characteristics.EDA_Min_Days_Connected_Indiv);
		SELF.EDA_Characteristics.EDA_Max_Days_Connected_Indiv := MAX(le.EDA_Characteristics.EDA_Max_Days_Connected_Indiv, ri.EDA_Characteristics.EDA_Max_Days_Connected_Indiv);
		SELF.EDA_Characteristics.EDA_Days_Indiv_First_Seen := MAX(le.EDA_Characteristics.EDA_Days_Indiv_First_Seen, ri.EDA_Characteristics.EDA_Days_Indiv_First_Seen);
		SELF.EDA_Characteristics.EDA_Days_Indiv_First_Seen_With_Phone := MAX(le.EDA_Characteristics.EDA_Days_Indiv_First_Seen_With_Phone, ri.EDA_Characteristics.EDA_Days_Indiv_First_Seen_With_Phone);
		SELF.EDA_Characteristics.EDA_Days_Phone_First_Seen := MAX(le.EDA_Characteristics.EDA_Days_Phone_First_Seen, ri.EDA_Characteristics.EDA_Days_Phone_First_Seen);
		SELF.EDA_Characteristics.EDA_Address_Match_Best := le.EDA_Characteristics.EDA_Address_Match_Best OR ri.EDA_Characteristics.EDA_Address_Match_Best;
		SELF.EDA_Characteristics.EDA_Months_Addr_Last_Seen := MAP(le.EDA_Characteristics.EDA_Months_Addr_Last_Seen <> 0 AND ri.EDA_Characteristics.EDA_Months_Addr_Last_Seen <> 0 => MIN(le.EDA_Characteristics.EDA_Months_Addr_Last_Seen, ri.EDA_Characteristics.EDA_Months_Addr_Last_Seen),
																															le.EDA_Characteristics.EDA_Months_Addr_Last_Seen <> 0 																													=> le.EDA_Characteristics.EDA_Months_Addr_Last_Seen,
																																																																																									ri.EDA_Characteristics.EDA_Months_Addr_Last_Seen);
		SELF.EDA_Characteristics.EDA_Num_Phones_Connected_Addr := le.EDA_Characteristics.EDA_Num_Phones_Connected_Addr + ri.EDA_Characteristics.EDA_Num_Phones_Connected_Addr;
		SELF.EDA_Characteristics.EDA_Num_Phones_Discon_Addr := le.EDA_Characteristics.EDA_Num_Phones_Discon_Addr + ri.EDA_Characteristics.EDA_Num_Phones_Discon_Addr;
		SELF.EDA_Characteristics.EDA_Num_Phones_Connected_HHID := le.EDA_Characteristics.EDA_Num_Phones_Connected_HHID + ri.EDA_Characteristics.EDA_Num_Phones_Connected_HHID;
		SELF.EDA_Characteristics.EDA_Num_Phones_Discon_HHID := le.EDA_Characteristics.EDA_Num_Phones_Discon_HHID + ri.EDA_Characteristics.EDA_Num_Phones_Discon_HHID;
		SELF.EDA_Characteristics.EDA_Is_Discon_15_Days := le.EDA_Characteristics.EDA_Is_Discon_15_Days OR ri.EDA_Characteristics.EDA_Is_Discon_15_Days;
		SELF.EDA_Characteristics.EDA_Is_Discon_30_Days := le.EDA_Characteristics.EDA_Is_Discon_30_Days OR ri.EDA_Characteristics.EDA_Is_Discon_30_Days;
		SELF.EDA_Characteristics.EDA_Is_Discon_60_Days := le.EDA_Characteristics.EDA_Is_Discon_60_Days OR ri.EDA_Characteristics.EDA_Is_Discon_60_Days;
		SELF.EDA_Characteristics.EDA_Is_Discon_90_Days := le.EDA_Characteristics.EDA_Is_Discon_90_Days OR ri.EDA_Characteristics.EDA_Is_Discon_90_Days;
		SELF.EDA_Characteristics.EDA_Is_Discon_180_Days := le.EDA_Characteristics.EDA_Is_Discon_180_Days OR ri.EDA_Characteristics.EDA_Is_Discon_180_Days;
		SELF.EDA_Characteristics.EDA_Is_Discon_360_Days := le.EDA_Characteristics.EDA_Is_Discon_360_Days OR ri.EDA_Characteristics.EDA_Is_Discon_360_Days;
		SELF.EDA_Characteristics.EDA_Is_Current_In_Hist := le.EDA_Characteristics.EDA_Is_Current_In_Hist OR ri.EDA_Characteristics.EDA_Is_Current_In_Hist;
		SELF.EDA_Characteristics.EDA_Num_Interrupts_Cur := le.EDA_Characteristics.EDA_Num_Interrupts_Cur + IF(TRIM(ri.EDA_Characteristics.EDA_Deletion_Date) <> '', 1, 0);
		// If we don't have dates, or the next record doesn't have a deletion date then the number of days interrupted is 0
		daysInterruptedTemp := IF((INTEGER)le.dt_first_seen = 0 OR (INTEGER)ri.dt_last_seen = 0 OR TRIM(ri.EDA_Characteristics.EDA_Deletion_Date) = '', 999999999, ABS(ut.DaysApart(le.dt_first_seen, ri.dt_last_seen)));
		daysInterrupted := IF(daysInterruptedTemp <= 0, 0, daysInterruptedTemp);
		avgInterruptedTemp := IF(daysInterrupted = 999999999, le.EDA_Characteristics.EDA_Avg_Days_Interrupt, ABS(AVE(le.EDA_Characteristics.EDA_Avg_Days_Interrupt, daysInterrupted)));
		avgInterrupted := IF(avgInterruptedTemp <= 0, 0, avgInterruptedTemp);
		SELF.EDA_Characteristics.EDA_Avg_Days_Interrupt := avgInterrupted;
		SELF.EDA_Characteristics.EDA_Min_Days_Interrupt := MIN(le.EDA_Characteristics.EDA_Min_Days_Interrupt, daysInterrupted);
		SELF.EDA_Characteristics.EDA_Max_Days_Interrupt := MAX(le.EDA_Characteristics.EDA_Max_Days_Interrupt, daysInterrupted);
		// In order to keep looking at the correct days we want to save the right records dates (Always compare one record to the next record)
		SELF.dt_first_seen := ri.dt_first_seen;
		SELF.dt_last_seen := ri.dt_last_seen;		
		
		SELF.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days := le.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days OR ri.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days;
		SELF.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days := le.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days OR ri.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days;
		SELF.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days := le.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days OR ri.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days;
		SELF.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days := le.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days OR ri.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days;
		SELF.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days := le.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days OR ri.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days;
		SELF.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days := le.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days OR ri.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days;
		
		SELF := le;
	END;
	
	rolledAttributes := ROLLUP(sortedEDAAttributes, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																								rollEDAAttributes(LEFT, RIGHT));
	
	
	/* ************************************************************************
	 *  Bring all the EDA Attributes back together														*
	 ************************************************************************ */
	mainAttributes := JOIN(Input, rolledAttributes, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																								TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF.EDA_Characteristics := RIGHT.EDA_Characteristics; SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	withUniqueDIDCurr := JOIN(mainAttributes, uniqueDIDCountedCurr, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																								TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF.EDA_Characteristics.EDA_DID_Count := IF(RIGHT.EDA_Characteristics.EDA_DID_Count = 0, LEFT.EDA_Characteristics.EDA_DID_Count, RIGHT.EDA_Characteristics.EDA_DID_Count);
																																																									SELF.EDA_Characteristics.EDA_Num_Phone_Owners_Cur := IF(RIGHT.EDA_Characteristics.EDA_Num_Phone_Owners_Cur = 0, LEFT.EDA_Characteristics.EDA_Num_Phone_Owners_Cur, RIGHT.EDA_Characteristics.EDA_Num_Phone_Owners_Cur);
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
																																																									
	withUniqueDIDHist := JOIN(withUniqueDIDCurr, uniqueDIDCountedHist, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																								TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF.EDA_Characteristics.EDA_Num_Phone_Owners_Hist := IF(RIGHT.EDA_Characteristics.EDA_Num_Phone_Owners_Hist = 0, LEFT.EDA_Characteristics.EDA_Num_Phone_Owners_Hist, RIGHT.EDA_Characteristics.EDA_Num_Phone_Owners_Hist);
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	withUniqueHHIDHist := JOIN(withUniqueDIDHist, uniqueHHIDCountedHist, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																								TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF.EDA_Characteristics.EDA_Num_Phones_Connected_HHID := IF(RIGHT.EDA_Characteristics.EDA_Num_Phones_Connected_HHID = 0, LEFT.EDA_Characteristics.EDA_Num_Phones_Connected_HHID, RIGHT.EDA_Characteristics.EDA_Num_Phones_Connected_HHID);
																																																									SELF.EDA_Characteristics.EDA_Num_Phones_Discon_HHID := IF(RIGHT.EDA_Characteristics.EDA_Num_Phones_Discon_HHID = 0, LEFT.EDA_Characteristics.EDA_Num_Phones_Discon_HHID, RIGHT.EDA_Characteristics.EDA_Num_Phones_Discon_HHID);
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
																																																									
	withUniqueAddrHist := JOIN(withUniqueHHIDHist, uniqueAddrCountedHist, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																								TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF.EDA_Characteristics.EDA_Num_Phones_Connected_Addr := RIGHT.EDA_Characteristics.EDA_Num_Phones_Connected_Addr;
																																																									SELF.EDA_Characteristics.EDA_Num_Phones_Discon_Addr := RIGHT.EDA_Characteristics.EDA_Num_Phones_Discon_Addr;
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	withUniqueAddrCurr := JOIN(withUniqueAddrHist, uniqueAddrCountedCurr, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																								TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF.EDA_Characteristics.EDA_Num_Phones_Connected_Addr := LEFT.EDA_Characteristics.EDA_Num_Phones_Connected_Addr + RIGHT.EDA_Characteristics.EDA_Num_Phones_Connected_Addr;
																																																									SELF.EDA_Characteristics.EDA_Num_Phones_Discon_Addr := LEFT.EDA_Characteristics.EDA_Num_Phones_Discon_Addr + RIGHT.EDA_Characteristics.EDA_Num_Phones_Discon_Addr;
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
												
	withcurrInHist := JOIN(withUniqueAddrCurr, currInHist, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																								TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF.EDA_Characteristics.EDA_Is_Current_In_Hist := LEFT.EDA_Characteristics.EDA_Is_Current_In_Hist OR RIGHT.EDA_Characteristics.EDA_Is_Current_In_Hist;
																																																									SELF.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days := LEFT.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days OR RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days;
																																																									SELF.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days := LEFT.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days OR RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days;
																																																									SELF.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days := LEFT.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days OR RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days;
																																																									SELF.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days := LEFT.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days OR RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days;
																																																									SELF.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days := LEFT.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days OR RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days;
																																																									SELF.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days := LEFT.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days OR RIGHT.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days;
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
																																																									
	withInterrupts := JOIN(withcurrInHist, cleanedInterrupts, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																								TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF.EDA_Characteristics.EDA_Num_Interrupts_Cur := RIGHT.NumberInterrupts;
                                                // for phone shell v2+, use the different average calculation
																																																									SELF.EDA_Characteristics.EDA_Avg_Days_Interrupt := if(phoneshellversion >= 20, right.AverageDaysInterrupt_V2, RIGHT.AverageDaysInterrupt);
																																																									SELF.EDA_Characteristics.EDA_Min_Days_Interrupt := RIGHT.MinDaysInterrupt;
																																																									SELF.EDA_Characteristics.EDA_Max_Days_Interrupt := RIGHT.MaxDaysInterrupt;
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
		
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus cleanEDA(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le) := TRANSFORM
		SELF.EDA_Characteristics.EDA_Days_In_Service := ut.DaysApart(le.EDA_Characteristics.EDA_Dt_First_Seen, le.EDA_Characteristics.EDA_Dt_Last_Seen);
		
		dateFirstSeenGreater := (INTEGER)le.EDA_Characteristics.EDA_Dt_First_Seen > (INTEGER)le.EDA_Characteristics.EDA_Dt_Last_Seen;
		// If the first seen date is older than the last seen date, set the last seen date to the first seen
		SELF.EDA_Characteristics.EDA_Dt_Last_Seen := IF(dateFirstSeenGreater, le.EDA_Characteristics.EDA_Dt_First_Seen, le.EDA_Characteristics.EDA_Dt_Last_Seen);
		
		// If the record is current, there should be no deletion date
		SELF.EDA_Characteristics.EDA_Deletion_Date := IF(le.EDA_Characteristics.EDA_Current_Record_Flag, '', le.EDA_Characteristics.EDA_Deletion_Date);
		
		// Make sure that the disconnect counts are messed up in the data, if we had a disconnect in the last 6 or 12 months, we definitely had that disconnect in the last 18 months
		Disc_Cnt12 := IF(le.EDA_Characteristics.EDA_Disc_Cnt12 < le.EDA_Characteristics.EDA_Disc_Cnt6, le.EDA_Characteristics.EDA_Disc_Cnt6, le.EDA_Characteristics.EDA_Disc_Cnt12);
		SELF.EDA_Characteristics.EDA_Disc_Cnt12 := Disc_Cnt12;
		SELF.EDA_Characteristics.EDA_Disc_Cnt18 := IF(le.EDA_Characteristics.EDA_Disc_Cnt18 < Disc_Cnt12, Disc_Cnt12, le.EDA_Characteristics.EDA_Disc_Cnt18);
		
		// If we don't have a household ID we can't have any counts based on HHID
		SELF.EDA_Characteristics.EDA_Num_Phones_Connected_HHID := IF(le.EDA_Characteristics.EDA_HHID <> 0, le.EDA_Characteristics.EDA_Num_Phones_Connected_HHID, 0);
		SELF.EDA_Characteristics.EDA_Num_Phones_Discon_HHID := IF(le.EDA_Characteristics.EDA_HHID <> 0, le.EDA_Characteristics.EDA_Num_Phones_Discon_HHID, 0);
		
		SELF.EDA_Characteristics.EDA_Min_Days_Interrupt := IF(le.EDA_Characteristics.EDA_Min_Days_Interrupt = 999999999, 0, le.EDA_Characteristics.EDA_Min_Days_Interrupt);
		
		SELF := le;
	END;
	
	cleanedEDA := PROJECT(withInterrupts, cleanEDA(LEFT));
	
	// OUTPUT(CHOOSEN(edaAttributes, 100), NAMED('edaAttributes'));
	// OUTPUT(CHOOSEN(uniqueDIDCurr, 100), NAMED('uniqueDIDCurr'));
	// OUTPUT(CHOOSEN(uniqueDIDCountedCurr, 100), NAMED('uniqueDIDCountedCurr'));
	// OUTPUT(CHOOSEN(edaAttributesHist, 100), NAMED('edaAttributesHist'));
	// OUTPUT(CHOOSEN(uniqueDIDHist, 100), NAMED('uniqueDIDHist'));
	// OUTPUT(CHOOSEN(uniqueDIDCountedHist, 100), NAMED('uniqueDIDCountedHist'));
	// OUTPUT(CHOOSEN(uniqueHHIDHist, 100), NAMED('uniqueHHIDHist'));
	// OUTPUT(CHOOSEN(uniqueHHIDCountedHist, 100), NAMED('uniqueHHIDCountedHist'));
	// OUTPUT(CHOOSEN(uniqueAddrHist, 100), NAMED('uniqueAddrHist'));
	// OUTPUT(CHOOSEN(uniqueAddrCountedHist, 100), NAMED('uniqueAddrCountedHist'));
	// OUTPUT(CHOOSEN(uniqueAddrCountedCurr, 100), NAMED('uniqueAddrCountedCurr'));
	// OUTPUT(CHOOSEN(currInHist, 100), NAMED('currInHist'));
	// OUTPUT(CHOOSEN(interrupts, 100), NAMED('interrupts'));
	// OUTPUT(CHOOSEN(uniqueDateInterrupts, 100), NAMED('uniqueDateInterrupts'));
	// OUTPUT(CHOOSEN(countedInterrupts, 100), NAMED('countedInterrupts'));
	// OUTPUT(CHOOSEN(cleanedInterrupts, 100), NAMED('cleanedInterrupts'));
	// OUTPUT(CHOOSEN(sortedEDAAttributes, 100), NAMED('sortedEDAAttributes'));
	// OUTPUT(CHOOSEN(rolledAttributes, 100), NAMED('rolledAttributes'));
	// OUTPUT(CHOOSEN(mainAttributes, 100), NAMED('mainAttributes'));
	// OUTPUT(CHOOSEN(withUniqueDIDCurr, 100), NAMED('withUniqueDIDCurr'));
	// OUTPUT(CHOOSEN(withUniqueDIDHist, 100), NAMED('withUniqueDIDHist'));
	// OUTPUT(CHOOSEN(withUniqueHHIDHist, 100), NAMED('withUniqueHHIDHist'));
	// OUTPUT(CHOOSEN(withUniqueAddrHist, 100), NAMED('withUniqueAddrHist'));
	// OUTPUT(CHOOSEN(withUniqueAddrCurr, 100), NAMED('withUniqueAddrCurr'));
	// OUTPUT(CHOOSEN(withcurrInHist, 100), NAMED('withcurrInHist'));
	// OUTPUT(CHOOSEN(withInterrupts, 100), NAMED('withInterrupts'));
	// OUTPUT(CHOOSEN(cleanedEDA, 100), NAMED('cleanedEDA'));
	
	RETURN(cleanedEDA);
END;