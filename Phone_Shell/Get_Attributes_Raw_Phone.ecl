/* ************************************************************************
 * This function gathers the Raw_Phone_Characteristics.										*
 * -Switch_Type adapted from Progressive_Phone.Mac_Get_Switchtype         *
 ************************************************************************ */

IMPORT AutokeyB2, Business_Header_SS, CellPhone, Phone_Shell, Risk_Indicators, RiskWise, UT, data_services, doxie, Suppress;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Get_Attributes_Raw_Phone (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
	/* ************************************************************************
	 *  Get Switch Type and Time Zone Match																		*
	 ************************************************************************ */
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getSwitchType(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Risk_Indicators.Key_Telcordia_TDS ri) := TRANSFORM
		toll_free_set := ['800', '811', '822', '833', '844', '855', '866', '877', '888', '899'];
		switchFlag := MAP(le.Gathered_Phone[1..3] IN toll_free_set OR 
											REGEXFIND('I', ri.SSC) 																=> '8', // Toll Free
											ri.COCType IN ['EOC', 'PMC', 'RCC', 'SP1', 'SP2'] AND
											(REGEXFIND('C', ri.SSC) OR 
											REGEXFIND('R', ri.SSC) OR 
											REGEXFIND('S', ri.SSC))																=> 'C', // Cell
											REGEXFIND('B', ri.SSC)																=> 'G', // Pager
											REGEXFIND('N', ri.SSC)																=> 'P', // POTS
											REGEXFIND('V', ri.SSC)																=> 'V', // VOIP
											REGEXFIND('T', ri.SSC)																=> 'T', // Time
											REGEXFIND('W', ri.SSC)																=> 'W', // Weather
											REGEXFIND('8', ri.SSC)																=> 'I', // Puerto-Rico/Virgin Islands
																																							 'U'); // Unknown
											
		telcordiaTimeZone := ut.timeZone_Convert((UNSIGNED1)ri.timezone, ri.state);
		inputTimeZone := ut.StateToTimezone(le.Clean_Input.State);
		CleanInputTimeZone := ut.timeZone_Convert((UNSIGNED1)inputTimeZone, le.Clean_Input.State);
		// If we can't determine the timezone, a '' or '0' are returned.  So only if we could determine the timezone and they match do we return a 1.
		SELF.Raw_Phone_Characteristics.Phone_Timezone_Match := IF(TRIM(telcordiaTimeZone) NOT IN ['', '0'] AND 
																															TRIM(telcordiaTimeZone) = TRIM(CleanInputTimeZone), 1, 0);
		
		// Return the 3-byte timezone code
		SELF.Raw_Phone_Characteristics.Phone_Timezone := telcordiaTimeZone; 
		SELF.Raw_Phone_Characteristics.Address_Zipcode_Timezone := CleanInputTimeZone;
		
		SELF.Raw_Phone_Characteristics.Phone_Switch_Type := IF(TRIM(le.Gathered_Phone) <> '', switchFlag, '');
		
		SELF := le;
	END;
	SwitchTypeTZTemp := JOIN(Input, Risk_Indicators.Key_Telcordia_TDS, (UNSIGNED)LEFT.Gathered_Phone > 10000000 AND
																																			KEYED(LEFT.Gathered_Phone[1..3] = RIGHT.npa AND LEFT.Gathered_Phone[4..6] = RIGHT.nxx) AND LEFT.Gathered_Phone[7] = RIGHT.tb,
																													getSwitchType(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus cleanSwitchType(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, CellPhone.Key_Neustar_Phone ri) := TRANSFORM
		SELF.Raw_Phone_Characteristics.Phone_Switch_Type := IF(ri.cellphone <> '', 'C', le.Raw_Phone_Characteristics.Phone_Switch_Type);
		SELF := le;
	END;
	SwitchTypeTZ := JOIN(SwitchTypeTZTemp, CellPhone.Key_Neustar_Phone, KEYED(LEFT.Gathered_Phone = RIGHT.cellphone), cleanSwitchType(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));

	/* ************************************************************************
	 *  Get Phone Zip Match																										*
	 ************************************************************************ */
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getPhoneZip(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Risk_Indicators.Key_Telcordia_tpm_slim ri) := TRANSFORM
		SELF.Raw_Phone_Characteristics.Phone_Zip_Match := IF(le.Clean_Input.Zip5 IN SET(ri.zipcodes, zip), 1, 0);
		SELF := le;
	END;
	ZipMatchTemp := JOIN(Input, Risk_Indicators.Key_Telcordia_tpm_slim, KEYED(LEFT.Gathered_Phone[1..3] = RIGHT.npa AND 
																						LEFT.Gathered_Phone[4..6] = RIGHT.nxx AND LEFT.Gathered_Phone[7] = RIGHT.tb),
																	getPhoneZip(LEFT, RIGHT), KEEP(500), ATMOST(RiskWise.max_atmost));
	// It's possible that more than one record results from the above join, keep the one that might match on zip
	ZipMatch := DEDUP(SORT(ZipMatchTemp, Clean_Input.Seq, Gathered_Phone, -Raw_Phone_Characteristics.Phone_Zip_Match), Clean_Input.Seq, Gathered_Phone);

	/* ************************************************************************
	 *  Get Phone Disconnect and Sic_Code																			*
	 ************************************************************************ */
	{Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, unsigned4 global_sid} getDisconnectHRisk(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Risk_Indicators.key_phone_table_v2 ri) := TRANSFORM
		SELF.global_sid := ri.global_sid;
		SELF.Raw_Phone_Characteristics.Phone_Disconnected := IF(ri.potdisconnect, TRUE, FALSE);
		SELF.Raw_Phone_Characteristics.Phone_High_Risk := IF(TRIM(ri.sic_code) <> '', 1, 0);
		SELF := le;
	END;
	phoneDisconnectHRiskTemp_unsuppressed := JOIN(Input, Risk_Indicators.key_phone_table_v2, KEYED(LEFT.Gathered_Phone = RIGHT.phone10), 
																					getDisconnectHRisk(LEFT, RIGHT), KEEP(500), ATMOST(RiskWise.max_atmost));
	phoneDisconnectHRiskTemp := Suppress.Suppress_ReturnOldLayout(phoneDisconnectHRiskTemp_unsuppressed, mod_access, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus);
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus rollDisconnectHRisk(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus ri) := TRANSFORM
		// In case there are multiple results, if one of them says the phone isn't disconnected then the phone isn't disconnected.  Only if all records are disconnected is the phone disconnected
		SELF.Raw_Phone_Characteristics.Phone_Disconnected := le.Raw_Phone_Characteristics.Phone_Disconnected AND ri.Raw_Phone_Characteristics.Phone_Disconnected;
		// In case there are multiple results, if any records indicate this is a transient or institutional address, keep the high risk flag
		SELF.Raw_Phone_Characteristics.Phone_High_Risk := IF(le.Raw_Phone_Characteristics.Phone_High_Risk = 1 OR ri.Raw_Phone_Characteristics.Phone_High_Risk = 1, 1, 0);
		
		SELF := le;
	END;
	phoneDisconnectHRisk := ROLLUP(SORT(phoneDisconnectHRiskTemp, Clean_Input.Seq, Gathered_Phone), 
																				LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone,
																	rollDisconnectHRisk(LEFT, RIGHT));

	/* ************************************************************************
	 *  Get Phone Debt Settlement Information																	*
	 ************************************************************************ */
	debtSettlementKey := AutokeyB2.Key_Phone(data_services.foreign_prod + 'thor_data400::key::Debt_Settlement::qa::autokey::');

	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getDebtSettlement(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, debtSettlementKey ri) := TRANSFORM
		// We have a hit on the debt settlement key
		SELF.Raw_Phone_Characteristics.Phone_Debt_Settlement := TRUE;
		SELF := le;
	END;
	
	debtSettlement := JOIN(Input, debtSettlementKey, KEYED(LEFT.Gathered_Phone[1..3] = RIGHT.p3 AND LEFT.Gathered_Phone[4..10] = RIGHT.p7),
																				getDebtSettlement(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost));

	/* ************************************************************************
	 *  Get Phone Business Count Information																	*
	 ************************************************************************ */
	layoutBusinessCount := RECORD
		Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus;
		STRING120 Company_Name := '';
		UNSIGNED6 bdid := 0;
	END;
	
	layoutBusinessCount getBusinesses(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Business_Header_SS.Key_BH_Phone ri) := TRANSFORM
		SELF.Company_Name := ri.company_name;
		SELF.bdid := ri.bdid;
		// We for sure have a hit of 1 business, the following rollup will count if we have others
		SELF.Raw_Phone_Characteristics.Phone_Business_Count := 1;
		
		SELF := le;
	END;
	getBusiness := JOIN(Input, Business_Header_SS.Key_BH_Phone, KEYED(LEFT.Gathered_Phone = (STRING)RIGHT.phone), getBusinesses(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
	
	// Try to reduce duplicate company listings - for example multiple offices
	dedupName := DEDUP(SORT(getBusiness, Clean_Input.Seq, Gathered_Phone, Company_Name), Clean_Input.Seq, Gathered_Phone, Company_Name);
	dedupBDID := SORT(DEDUP(SORT(dedupName, Clean_Input.Seq, Gathered_Phone, bdid), Clean_Input.Seq, Gathered_Phone, bdid), Clean_Input.Seq, Gathered_Phone, Company_Name);
	
	// Now count the number of businesses
	layoutBusinessCount rollBusiness(layoutBusinessCount le, layoutBusinessCount ri) := TRANSFORM
		// Only count the business if the company_name is less than 80% similar (This removes duplicates such as 'HIGH SCHOOL' versus 'SENIOR HIGH SCHOOL')
		companyScore := 100 - MAX(ut.StringSimilar100(le.company_name, ri.company_name), ut.StringSimilar100(ri.company_name, le.company_name));
		SELF.Raw_Phone_Characteristics.Phone_Business_Count := IF(companyScore < 80, le.Raw_Phone_Characteristics.Phone_Business_Count + ri.Raw_Phone_Characteristics.Phone_Business_Count,
																																								 le.Raw_Phone_Characteristics.Phone_Business_Count);
		
		SELF.Company_Name := ri.Company_Name;
		
		SELF := le;
	END;
	businessCount := ROLLUP(dedupBDID, LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone, rollBusiness(LEFT, RIGHT));

	cleanBusinessCount := PROJECT(businessCount, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, SELF := LEFT));

	/* ************************************************************************
	 *  Combine all Raw_Phone_Characteristics for RETURN                      *
	 ************************************************************************ */
	withSwitchTypeTZ := JOIN(Input, SwitchTypeTZ, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
																																																									SELF.Raw_Phone_Characteristics.Phone_Timezone_Match := RIGHT.Raw_Phone_Characteristics.Phone_Timezone_Match;
																																																									SELF.Raw_Phone_Characteristics.Phone_Timezone := RIGHT.Raw_Phone_Characteristics.Phone_Timezone;
																																																									SELF.Raw_Phone_Characteristics.Address_Zipcode_Timezone := RIGHT.Raw_Phone_Characteristics.Address_Zipcode_Timezone;
																																																									SELF.Raw_Phone_Characteristics.Phone_Switch_Type := RIGHT.Raw_Phone_Characteristics.Phone_Switch_Type;
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
																																																									
	withZipMatch := JOIN(withSwitchTypeTZ, ZipMatch, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
																																																									SELF.Raw_Phone_Characteristics.Phone_Zip_Match := RIGHT.Raw_Phone_Characteristics.Phone_Zip_Match;
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
	
	withDisconnectHRisk := JOIN(withZipMatch, phoneDisconnectHRisk, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
																																																									SELF.Raw_Phone_Characteristics.Phone_Disconnected := RIGHT.Raw_Phone_Characteristics.Phone_Disconnected;
																																																									SELF.Raw_Phone_Characteristics.Phone_High_Risk := RIGHT.Raw_Phone_Characteristics.Phone_High_Risk;
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
																																																									
	withDebtSettlement := JOIN(withDisconnectHRisk, debtSettlement, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
																																																									SELF.Raw_Phone_Characteristics.Phone_Debt_Settlement := RIGHT.Raw_Phone_Characteristics.Phone_Debt_Settlement;
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));

	withBusinessCount := JOIN(withDebtSettlement, cleanBusinessCount, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence, TRANSFORM(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus,
																																																									SELF.Raw_Phone_Characteristics.Phone_Business_Count := RIGHT.Raw_Phone_Characteristics.Phone_Business_Count;
																																																									SELF := LEFT), LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost));
																																																									
	// OUTPUT(CHOOSEN(SwitchType, 100), NAMED('SwitchType'));
	// OUTPUT(CHOOSEN(ZipMatchTemp, 100), NAMED('ZipMatchTemp'));
	// OUTPUT(CHOOSEN(ZipMatch, 100), NAMED('ZipMatch'));
	// OUTPUT(CHOOSEN(phoneDisconnectHRiskTemp, 100), NAMED('phoneDisconnectHRiskTemp'));
	// OUTPUT(CHOOSEN(phoneDisconnectHRisk, 100), NAMED('phoneDisconnectHRisk'));
	// OUTPUT(CHOOSEN(withSwitchType, 100), NAMED('withSwitchType'));
	// OUTPUT(CHOOSEN(withZipMatch, 100), NAMED('withZipMatch'));
	// OUTPUT(CHOOSEN(withDisconnectHRisk, 100), NAMED('withDisconnectHRisk'));
	// OUTPUT(CHOOSEN(getBusiness, 100), NAMED('getBusiness'));
	// OUTPUT(CHOOSEN(dedupName, 100), NAMED('dedupName'));
	// OUTPUT(CHOOSEN(dedupBDID, 100), NAMED('dedupBDID'));
	// OUTPUT(CHOOSEN(businessCount, 100), NAMED('businessCount'));
	// OUTPUT(CHOOSEN(cleanBusinessCount, 100), NAMED('cleanBusinessCount'));
	
	RETURN(withBusinessCount);
END;