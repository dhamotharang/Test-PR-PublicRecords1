IMPORT Address, BIPV2, Business_Header, Business_Risk_BIP, DueDiligence, Risk_Indicators, STD, ut;

EXPORT Common := MODULE

	// Grabs just the linking ID's and Unique Seq Number - this is needed to use the BIP kFetch2
	EXPORT GetLinkIDs(DATASET(DueDiligence.Layouts.Busn_Internal) BusnData) := FUNCTION
		
		linkIDsOnly := PROJECT(BusnData, TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
																								SELF.UniqueID		:= LEFT.seq;
																								SELF.PowID			:= LEFT.Busn_info.BIP_IDs.PowID.LinkID;
																								SELF.PowScore		:= LEFT.Busn_info.BIP_IDs.PowID.Score;
																								SELF.PowWeight	:= LEFT.Busn_info.BIP_IDs.PowID.Weight;
																								
																								SELF.ProxID			:= LEFT.Busn_info.BIP_IDs.ProxID.LinkID;
																								SELF.ProxScore	:= LEFT.Busn_info.BIP_IDs.ProxID.Score;
																								SELF.ProxWeight	:= LEFT.Busn_info.BIP_IDs.ProxID.Weight;
																								
																								SELF.SeleID			:= LEFT.Busn_info.BIP_IDs.SeleID.LinkID;
																								SELF.SeleScore	:= LEFT.Busn_info.BIP_IDs.SeleID.Score;
																								SELF.SeleWeight	:= LEFT.Busn_info.BIP_IDs.SeleID.Weight;
																								
																								SELF.OrgID			:= LEFT.Busn_info.BIP_IDs.OrgID.LinkID;
																								SELF.OrgScore		:= LEFT.Busn_info.BIP_IDs.OrgID.Score;
																								SELF.OrgWeight	:= LEFT.Busn_info.BIP_IDs.OrgID.Weight;
																								
																								SELF.UltID			:= LEFT.Busn_info.BIP_IDs.UltID.LinkID;
																								SELF.UltScore		:= LEFT.Busn_info.BIP_IDs.UltID.Score;
																								SELF.UltWeight	:= LEFT.Busn_info.BIP_IDs.UltID.Weight;
																								
																								SELF := []; )); // Don't populate DotID or EmpID
		
		RETURN linkIDsOnly;
	END;
	
	// Grabs just the linking ID's without Unique Seq Number - this is needed to use the BIP kFetch
	EXPORT GetLinkIDsForKFetch(DATASET(DueDiligence.Layouts.Busn_Internal) BusnData) := FUNCTION
		
		linkIDsOnlyForKFetch := PROJECT(GetLinkIDs(BusnData), TRANSFORM(BIPV2.IDlayouts.l_xlink_ids, SELF := LEFT;));
		
		RETURN linkIDsOnlyForKFetch;
	END;
	
	
	EXPORT ValidateRequest(DATASET(DueDiligence.Layouts.Input) input, UNSIGNED1 glbPurpose, UNSIGNED1 dppaPurpose):= FUNCTION

		validatedRequests := PROJECT(input, TRANSFORM(DueDiligence.Layouts.Input,
																									//Validate the request
																									BOOLEAN IndFNamePopulated		  := LEFT.individual.name.firstName <> DueDiligence.Constants.EMPTY OR LEFT.individual.name.fullName <> DueDiligence.Constants.EMPTY;
																									BOOLEAN IndLNamePopulated	  	:= LEFT.individual.name.lastName <> DueDiligence.Constants.EMPTY OR LEFT.individual.name.fullName <> DueDiligence.Constants.EMPTY;
																									BOOLEAN IndAddrPopulated		  := LEFT.Individual.address.streetaddress1 <> DueDiligence.Constants.EMPTY OR (LEFT.Individual.address.prim_range <> DueDiligence.Constants.EMPTY AND LEFT.Individual.address.prim_name <> DueDiligence.Constants.EMPTY);
																									BOOLEAN IndCityStatePopulated := LEFT.individual.address.city <> DueDiligence.Constants.EMPTY AND LEFT.individual.address.state <> DueDiligence.Constants.EMPTY;
																									BOOLEAN IndZipPopulated		    := LEFT.individual.address.zip5 <> DueDiligence.Constants.EMPTY;
																									BOOLEAN IndSSNPopulated		    := LEFT.individual.ssn <> DueDiligence.Constants.EMPTY;

																									BOOLEAN BusNamePopulated		  := LEFT.business.companyName <> DueDiligence.Constants.EMPTY OR LEFT.business.altCompanyName <> DueDiligence.Constants.EMPTY;
																									BOOLEAN BusAddrPopulated		  := LEFT.business.address.streetaddress1 <> DueDiligence.Constants.EMPTY OR (LEFT.business.address.prim_range <> DueDiligence.Constants.EMPTY AND LEFT.Business.address.prim_name <> DueDiligence.Constants.EMPTY);
																									BOOLEAN BusCityStatePopulated := LEFT.business.address.city <> DueDiligence.Constants.EMPTY AND LEFT.business.address.state <> DueDiligence.Constants.EMPTY;
																									BOOLEAN BusZipPopulated		    := LEFT.business.address.zip5 <> DueDiligence.Constants.EMPTY;
																									BOOLEAN BusTaxIDPopulated		  := LEFT.business.fein <> DueDiligence.Constants.EMPTY;
																									
																									BOOLEAN LexIDPopulated		  	:= LEFT.individual.lexID <> DueDiligence.Constants.EMPTY;
																									BOOLEAN SeleIDPopulated	  	  := LEFT.business.lexID <> DueDiligence.Constants.EMPTY;
																									BOOLEAN ValidGLB		  				:= Risk_Indicators.iid_constants.glb_ok((UNSIGNED)glbPurpose, FALSE );
																									BOOLEAN ValidDPPA	  					:= Risk_Indicators.iid_constants.dppa_ok((UNSIGNED)dppaPurpose, FALSE);
																									
																									BOOLEAN ValidIndividual := (IndFNamePopulated AND IndLNamePopulated AND
																																									(IndSSNPopulated OR 
																																									(IndAddrPopulated AND (IndCityStatePopulated OR IndZipPopulated)))) 
																																							OR LexIDPopulated;
																									
																									BOOLEAN ValidBusiness := (BusNamePopulated AND
																																								(BusTaxIDPopulated OR
																																								(BusAddrPopulated AND (BusCityStatePopulated OR BusZipPopulated)))) 
																																						OR SeleIDPopulated;
																																						
																									BOOLEAN ValidIndVersion := LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS;
																									BOOLEAN ValidBusVersion := LEFT.requestedVersion IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS;
																									
																									STRING OhNoMessage := MAP(ValidIndVersion = FALSE AND ValidBusVersion = FALSE => DueDiligence.Constants.VALIDATION_INVALID_VERSION,
																																						ValidIndVersion AND ValidIndividual = FALSE => DueDiligence.Constants.VALIDATION_INVALID_INDIVIDUAL,
																																						ValidBusVersion AND ValidBusiness = FALSE => DueDiligence.Constants.VALIDATION_INVALID_BUSINESS,
																																						ValidGLB = FALSE => DueDiligence.Constants.VALIDATION_INVALID_GLB,
																																						ValidDPPA = FALSE => DueDiligence.Constants.VALIDATION_INVALID_DPPA,
																																						DueDiligence.Constants.EMPTY);

																									
																									SELF.validRequest := IF(OhNoMessage = DueDiligence.Constants.EMPTY, TRUE, FALSE);
																									SELF.errorMessage := OhNoMessage;
																									SELF := LEFT;));

		RETURN validatedRequests;
	END;

	//copied/modified from 	Business_Risk_BIP.Common.AppendSeq2
	//datasetToJoinTo must be of DueDiligence.Layouts.Busn_Internal structure
	//(or at a minimum have the same structure for link ids, seq, and history date)
	EXPORT AppendSeq(rawData, datasetToJoinTo, rawIncludesUniqueID) := FUNCTIONMACRO
		
		//create the where clause based on if rawData has uniqueID or not
		LOCAL whereClause := 'LEFT.UltID = RIGHT.Busn_info.BIP_IDS.UltID.LinkID AND ' +
										'LEFT.OrgID = RIGHT.Busn_info.BIP_IDS.OrgID.LinkID AND ' +
										'LEFT.SeleID = RIGHT.Busn_info.BIP_IDS.SeleID.LinkID' + 
										IF(rawIncludesUniqueID, ' AND LEFT.uniqueID = RIGHT.seq', DueDiligence.Constants.EMPTY);
				
		//if rawData has uniqueID field, assuming unquieness - otherwise remove duplicate rows
		//should only have duplicate rows if a given business was added to the file twice
		LOCAL uniqueRawRows := IF(rawIncludesUniqueID = FALSE, DEDUP(rawData, ALL), rawData);
		
		LOCAL joinResult := JOIN(uniqueRawRows, datasetToJoinTo, 
												#EXPAND(whereClause), 
												TRANSFORM({RECORDOF(LEFT), UNSIGNED4 seq, UNSIGNED4 historyDate},
																	SELF.seq := RIGHT.seq;
																	SELF.historyDate := RIGHT.historyDate;
																	SELF := LEFT), 
												FEW); 
												
		RETURN joinResult;										
	ENDMACRO;

	
	EXPORT fn_filterOnArchiveDate(INTEGER fieldDate, INTEGER archiveDate) := FUNCTION
		
		isEarlierThanArchiveDate := fieldDate < archiveDate AND fieldDate > 0;

		RETURN isEarlierThanArchiveDate;
	END;
	
	
	EXPORT fn_filterOnCurrentMode(INTEGER fieldDate) := FUNCTION
		
		isCurrentMode := fieldDate > 0 AND (INTEGER)((STRING)fieldDate) <= (INTEGER)((STRING8)STD.Date.Today());
		
		RETURN isCurrentMode;
	END;
	
		//copied/modified from 	Business_Risk_BIP.Common.FilterRecords - used for only 1 date to filter on
	EXPORT FilterRecordsSingleDate(dataSetToFilter, dateFirstSeenField) := FUNCTIONMACRO
	
		//filter out invalid dates
		tempDataset1 := DueDiligence.Common.CleanDateFields(dataSetToFilter, dateFirstSeenField);
		
		//filter by dateFirstSeenField if populated, if not then use the secondaryDateFirstSeenField
		filtered := tempDataset1((HistoryDate = DueDiligence.Constants.date8Nines AND DueDiligence.Common.fn_filterOnCurrentMode((INTEGER)dateFirstSeenField))
															OR DueDiligence.Common.fn_filterOnArchiveDate((INTEGER)dateFirstSeenField, historyDate));
		
		RETURN filtered;
		
	ENDMACRO;	
	
	//copied/modified from 	Business_Risk_BIP.Common.FilterRecords - used with 2 dates to filter
	EXPORT FilterRecords(dataSetToFilter, dateFirstSeenField, secondaryDateFirstSeenField) := FUNCTIONMACRO

		//filter out invalid dates
		tempDataset1 := DueDiligence.Common.CleanDateFields(dataSetToFilter, dateFirstSeenField);
		tempDataset2 := DueDiligence.Common.CleanDateFields(tempDataset1, secondaryDateFirstSeenField);
		
		//filter by dateFirstSeenField if populated, if not then use the secondaryDateFirstSeenField
		filtered := tempDataset2(IF((INTEGER)dateFirstSeenField > 0, 
																	((HistoryDate = DueDiligence.Constants.date8Nines AND DueDiligence.Common.fn_filterOnCurrentMode((INTEGER)dateFirstSeenField))
																	OR DueDiligence.Common.fn_filterOnArchiveDate((INTEGER)dateFirstSeenField, historyDate)),  //TRUE STATEMENT
																	((HistoryDate = DueDiligence.Constants.date8Nines AND DueDiligence.Common.fn_filterOnCurrentMode((INTEGER)secondaryDateFirstSeenField))
																	OR DueDiligence.Common.fn_filterOnArchiveDate((INTEGER)secondaryDateFirstSeenField, historyDate))));//FALSE STATEMENT
		
		RETURN filtered;
		
	ENDMACRO;	



	SHARED fn_getDateVal(UNSIGNED date) := FUNCTION
		stringDate := (STRING)(date * 10000);
		tempDate := (UNSIGNED8)stringDate[1..8];
		dateVal := IF(date > 0, tempDate, date);
		
		RETURN dateVal;
	END;
	
	SHARED find_month(UNSIGNED dateVal) := FUNCTION
		RETURN (dateVal div 100) % 100;
	END;

	SHARED IsValidMonth(UNSIGNED date) := FUNCTION
		dateVal := fn_getDateVal(date);
		
		month := find_month(dateVal);
		
		validMonth := IF(month > 0 AND month < 13, TRUE, FALSE);
		
		RETURN validMonth;
	END;
	
	
	EXPORT IsValidDate(UNSIGNED date, BOOLEAN yearOnly = FALSE) := FUNCTION
		dateVal := fn_getDateVal(date);
		
		yearIn := dateVal div 10000;
		currentYear := STD.Date.Year(STD.Date.Today());
		
		month := find_month(dateVal);
		
		day := dateVal % 100;
		daysInMonths := [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; // using this requires checking for leap year
		
		leap_adjust := IF (month = 2 and STD.Date.IsLeapYear(yearIn), 1, 0);
		validDay := day > 0 AND (day <= daysInMonths[month] + leap_adjust);
			
		validDate := IF(yearOnly,	(yearIn >= 1800) and (yearIn <= currentYear), 
															(yearIn >= 1800) and (yearIn <= currentYear) and IsValidMonth(date) and validDay);
		
		RETURN validDate;
	END;


	//copied/modified from 	Business_Risk_BIP.Common.checkInvalidDate
	EXPORT checkInvalidDate(STRING date, STRING invalidDateReplacement = '0') := FUNCTION
		// Invalid Date Rules:
		// -- Blank Dates will be set to whatever is passed in for InvalidDateReplacement (Often '0' or '999999' depending on how this date is being used, '0' is default).
		// -- Dates with invalid Years, or a Year prior to 1800 (So 1799 and earlier) will be set to whatever is passed in for InvalidDateReplacement.
		// -- Dates with valid, non-futuristic Years but no valid Month or valid Day will be set to YYYY0101 (January 1st of that year).
		// -- Dates with valid, non-futuristic Years and valid Months but no valid Day will be set to YYYYMM01 (The 1st of that month/year).
		// -- Futuristic dates will be capped at the history date in Archive mode. Only Dates Last Seen should be impacted as Date First Seen futuristic dates are filtered out by the FilterRecords function above.
		blankDate := (INTEGER)date <= 0;
		paddedDate := CASE(LENGTH(TRIM(date, LEFT, RIGHT)), // If the Date isn't the full length - pad it with the 1st month/1st of the month
											4 => Date[1..4] + '0101', // Passed in YYYY, missing MMDD
											6 => Date[1..6] + '01', 	// Passed in YYYYMM, missing DD (Listed first since most dates being checked are YYYYMM format, this help short circuit the logic for minor speed increase)
											8 => Date[1..8],					// Passed in full YYYYMMDD
													 Date); 							// Something weird was passed in, keep it - but it will likely fail the valid date checks below unless it's YYYYMMDD+garbage, then the valid YYYYMMDD will be kept
		validFullDate := IsValidDate((UNSIGNED)paddedDate); // Parse out the date to determine if it is valid - accounts for leap years
		
		validYearMonth := IsValidDate((UNSIGNED)paddedDate, TRUE) AND IsValidMonth((UNSIGNED)paddedDate); // Check to see if YYYYMM is a valid date (>= 180001)
		validYear := IsValidDate((UNSIGNED)paddedDate, TRUE); // Check to see if YYYY is a valid year (>= 1800)
		
		cleanedDate := MAP(blankDate			=> invalidDateReplacement,
											 validFullDate	=> paddedDate[1..8],
											 validYearMonth	=> paddedDate[1..6] + '01',
											 validYear			=> paddedDate[1..4] + '0101',
																				 invalidDateReplacement);
		
		RETURN cleanedDate;
	END;
	
	
	EXPORT CleanDateFields(datasetToCheck, dateFieldToCheck) := FUNCTIONMACRO
	
		//Make sure that the date fields can hold an 8 character field returned from checkInvalidDate
		newLayout := RECORD
			RECORDOF(datasetToCheck) -dateFieldToCheck;
		END;
			
		updatedDS := PROJECT(datasetToCheck, TRANSFORM({RECORDOF(newLayout), UNSIGNED4 dateFieldToCheck}, 
																										SELF.dateFieldToCheck := (UNSIGNED4)LEFT.dateFieldToCheck;
																										SELF := LEFT;));

		updatedField := PROJECT(updatedDS,
														TRANSFORM({RECORDOF(LEFT)},
																			SELF.dateFieldToCheck := (TYPEOF(updatedDS.dateFieldToCheck))DueDiligence.Common.checkInvalidDate((STRING)LEFT.dateFieldToCheck);
																			SELF := LEFT));

		RETURN updatedField;
	ENDMACRO;
	
	// ------                                                       ----
	// ------  Use this to get a valid date based on the history    ----
	// ------   date.  If the history date is all 9's use the       ----
	// ------   ELSE use the history date passed into the function  ----
  EXPORT GetMyDate(unsigned4 history_date)                 := FUNCTION
	   /* today_date will be in YYYYMMDD format */  
	   unsigned4 todays_date               := STD.Date.Today();
	   unsigned4 returnDateToUse := IF(history_date=99999999,
	                      todays_date,
												history_date);
	
	   RETURN returnDateToUse; 
	
	END;       //END OF THIS FUNCTION
	
	
	EXPORT GetCleanData(DATASET(DueDiligence.Layouts.Input) input) := FUNCTION
	
		DueDiligence.Layouts.CleanedData cleanIt(DueDiligence.Layouts.Input le) := TRANSFORM
		
			//Clean Address
			addressToClean := IF(le.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, le.individual.address, le.business.address);
			

			addr := Risk_Indicators.MOD_AddressClean.street_address(addressToClean.streetAddress1 + ' ' + addressToClean.streetAddress2, addressToClean.prim_range, 
																																				addressToClean.predir, addressToClean.prim_name, addressToClean.addr_suffix, 
																																				addressToClean.postdir, addressToClean.unit_desig, addressToClean.sec_range);
																																				
			cleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(addr, addressToClean.city, addressToClean.state, addressToClean.zip5);											
		
			cleanedAddress := Address.CleanFields(cleanAddr);
			
			street1 := Risk_Indicators.MOD_AddressClean.street_address(DueDiligence.Constants.EMPTY, cleanedAddress.Prim_Range, cleanedAddress.Predir, cleanedAddress.Prim_Name, 
																												cleanedAddress.Addr_Suffix, cleanedAddress.Postdir, cleanedAddress.Unit_Desig, cleanedAddress.Sec_Range);
			
			addressClean := DATASET([TRANSFORM(DueDiligence.Layouts.Address,
																					SELF.streetAddress1 := street1;
																					SELF.streetAddress2 := TRIM(STD.Str.ToUpperCase(addressToClean.StreetAddress2));
																					SELF.prim_range := cleanedAddress.prim_range;
																					SELF.predir := cleanedAddress.predir;
																					SELF.prim_name := cleanedAddress.prim_name;
																					SELF.addr_suffix := cleanedAddress.addr_suffix;
																					SELF.postdir := cleanedAddress.postdir;
																					SELF.unit_desig := cleanedAddress.unit_desig;
																					SELF.sec_range := cleanedAddress.sec_range;
																					SELF.city := cleanedAddress.v_city_name;
																					SELF.state := cleanedAddress.st;
																					SELF.zip5 := cleanedAddress.zip;
																					SELF.zip4 := cleanedAddress.zip4;
																					SELF.cart := cleanedAddress.cart;
																					SELF.cr_sort_sz := cleanedAddress.cr_sort_sz;
																					SELF.lot := cleanedAddress.lot;
																					SELF.lot_order := cleanedAddress.lot_order;
																					SELF.dbpc := cleanedAddress.dbpc;
																					SElF.chk_digit := cleanedAddress.chk_digit;
																					SELF.rec_type := cleanedAddress.rec_type;
																					/* Due Diligence logic is expecting only the last 3 digits of the full 5 digit FIPS Code        */   
																					/*               When it needs the full 5 digits of the FIPS Code it will generate the 5 digits */
																					/*               by converting the 2 character state code into the 2 digit numerice code and    */
																					/*               concatenate the 2 digit state code with 3 digit county code to generate the    */
																					/*               full 5 digits again.   This is consistent with other Risk Products             */  
																					SELF.county := cleanedAddress.county[DueDiligence.Constants.FIRST_POS..DueDiligence.Constants.LAST_POS];
																					SELF.geo_lat := cleanedAddress.geo_lat;
																					SELF.geo_long := cleanedAddress.geo_long;
																					SELF.msa := cleanedAddress.msa;
																					SELF.geo_blk := cleanedAddress.geo_blk;
																					SELF.geo_match := cleanedAddress.geo_match;
																					SELF.err_stat := cleanedAddress.err_stat;
																					SELF := [];)])[1];
			
			addrProvided := addressToClean.streetAddress1 <> DueDiligence.Constants.EMPTY OR addressToClean.streetAddress2 <> DueDiligence.Constants.EMPTY OR addressToClean.prim_range <> DueDiligence.Constants.EMPTY OR addressToClean.predir <> DueDiligence.Constants.EMPTY OR 
											addressToClean.prim_name <> DueDiligence.Constants.EMPTY OR addressToClean.addr_suffix <> DueDiligence.Constants.EMPTY OR addressToClean.postdir <> DueDiligence.Constants.EMPTY OR addressToClean.unit_desig <> DueDiligence.Constants.EMPTY OR 
											addressToClean.sec_range <> DueDiligence.Constants.EMPTY OR addressToClean.city <> DueDiligence.Constants.EMPTY OR addressToClean.state <> DueDiligence.Constants.EMPTY OR addressToClean.zip5 <> DueDiligence.Constants.EMPTY;	
											
			fullAddrProvided := (addressClean.streetAddress1 <> DueDiligence.Constants.EMPTY OR addressClean.prim_name <> DueDiligence.Constants.EMPTY) AND addressClean.city <> DueDiligence.Constants.EMPTY AND addressClean.state <> DueDiligence.Constants.EMPTY AND addressClean.zip5 <> DueDiligence.Constants.EMPTY;
			
			//Clean Company Name
			busName := le.business.companyName;
			altBusName := le.business.altCompanyName;
			

			companyName := IF(busName = DueDiligence.Constants.EMPTY, ut.CleanCompany(altBusName), ut.CleanCompany(busName)); // If the customer didn't pass in a company but passed in an alt company name use the alt as the company name
			altCompanyName := IF(busName = DueDiligence.Constants.EMPTY, DueDiligence.Constants.EMPTY, ut.CleanCompany(altBusName)); // Blank out the cleaned AltCompanyName if CompanyName wasn't populated, as we copied Alt into the Main CompanyName field on the previous line
			
			//Clean Phone Number
			phoneNumber := IF(le.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, le.individual.phone, le.business.phone);
			phoneToClean := STD.Str.Filter(phoneNumber, DueDiligence.Constants.NUMERIC_VALUES);
			validPhone := IF(Business_Risk_BIP.Common.validPhone(phoneToClean), phoneToClean, DueDiligence.Constants.EMPTY); //If we do not have a valid phone, blank it out
			
			//Remove any non-numeric fiends from taxID and lexID fields
			taxID := IF(le.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, le.individual.ssn, le.business.fein);
			taxIDToClean := STD.Str.Filter(taxID, DueDiligence.Constants.NUMERIC_VALUES);
			validTaxID := IF(le.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, IF(Business_Header.IsValidSsn((UNSIGNED)taxIDToClean), taxIDToClean, DueDiligence.Constants.EMPTY), 
																																																	 IF(Business_Header.ValidFEIN((UNSIGNED)taxIDToClean), taxIDToClean, DueDiligence.Constants.EMPTY ));
			
			lexID := IF(le.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, le.individual.lexID, le.business.lexID);
			validLexID := STD.Str.Filter(lexID, DueDiligence.Constants.NUMERIC_VALUES);
			
			//Valid history date passed - if invalid should return 99999999 for current mode
			validDate := checkInvalidDate((STRING)le.historyDateYYYYMMDD, (STRING)DueDiligence.Constants.date8Nines);
			
			//Populate appropriate cleaned data	
			busClean := IF(le.requestedVersion IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS, 
												DATASET([TRANSFORM(DueDiligence.Layouts.Busn_Input,
																						SELF.lexID := validLexID;
																						SELF.companyName := companyName;
																						SELF.altCompanyName := altCompanyName;
																						SELF.address := addressClean;
																						SELF.phone := validPhone;
																						SELF.fein := validTaxID;
																						SELF := le.business;
																						SELF := [];)]),
												DATASET([], DueDiligence.Layouts.Busn_Input));
		
			indClean := IF(le.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS,
												DATASET([TRANSFORM(DueDiligence.Layouts.Indv_Input,
																						SELF.lexID := validLexID;
																						SELF.name := DATASET([TRANSFORM(DueDiligence.Layouts.Name,
																																						unparsedName := STD.Str.ToUpperCase(le.individual.name.fullName);
																																						fName := STD.Str.ToUpperCase(le.individual.name.firstName);
																																						mName := STD.Str.ToUpperCase(le.individual.name.middleName);
																																						lName := STD.Str.ToUpperCase(le.individual.name.lastName);
																																						sName := STD.Str.ToUpperCase(le.individual.name.suffix);
																																						
																																						
																																						cleanedName := MAP(STD.Str.ToUpperCase(le.individual.nameInputOrder) = 'FML' => Address.CleanPersonFML73(unparsedName),
																																															 STD.Str.ToUpperCase(le.individual.nameInputOrder) = 'LFM' => Address.CleanPersonLFM73(unparsedName),
																																															 Address.CleanPerson73(unparsedName));	
			
																																						cleanedFirst := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[6..25]), DueDiligence.Constants.EMPTY);
																																						cleanedMiddle := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[26..45]), DueDiligence.Constants.EMPTY);
																																						cleanedLast := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[46..65]), DueDiligence.Constants.EMPTY);
																																						cleanedSuffix := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[66..70]), DueDiligence.Constants.EMPTY);
																														
																																						SELF.fullName := unparsedName;
																																						SELF.firstName := IF(fName = DueDiligence.Constants.EMPTY, cleanedFirst, fName);
																																						SELF.middleName := IF(mName = DueDiligence.Constants.EMPTY, cleanedMiddle, mName);
																																						SELF.lastName := IF(lName = DueDiligence.Constants.EMPTY, cleanedLast, lName);
																																						SELF.suffix := IF(sName = DueDiligence.Constants.EMPTY, cleanedSuffix, sName);																															
																																						SELF := [];)])[1];
																						SELF.address := addressClean;
																						SELF.phone := validPhone;
																						SELF.ssn := validTaxID;
																						SELF := le.individual;
																						SELF := [];)]),
												DATASET([], DueDiligence.Layouts.Indv_Input));

			inputClean := DATASET([TRANSFORM(DueDiligence.Layouts.Input,
																				SELF.business := busClean[1];
																				SELF.individual := indClean[1];
																				SELF.historyDateYYYYMMDD := (UNSIGNED)validDate;
																				SELF.addressProvided := addrProvided;
																				SELF.fullAddressProvided := fullAddrProvided;
																				SELF := le;
																				SELF := [];)])[1];
			
			
			SELF.cleanedInput := inputClean;
			SELF.inputEcho := le;
			SELF := [];
		END;
		
		RETURN PROJECT(input, cleanIt(LEFT));
	END;
	
	EXPORT DaysApartWithZeroEmptyDate(STRING date, STRING date2) := FUNCTION
		
		popDate2 := MAP(date2 = DueDiligence.Constants.EMPTY => (STRING8)STD.Date.Today(),
										(INTEGER)date2 = DueDiligence.Constants.date8Nines => (STRING8)STD.Date.Today(),
										date2);
		
		RETURN IF((UNSIGNED)date > 0, ut.DaysApart(date, popDate2), 0); //return 0 days apart if date doesn't exist 
	END;
	
	EXPORT rollSicNaicBySeqAndBIP(InputDataset) := FUNCTIONMACRO
		sortedTempOutput := SORT(InputDataset, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), SICCode, NAICCode);
		rollTempOutput := ROLLUP(sortedTempOutput,
															LEFT.seq = RIGHT.seq AND
															LEFT.ultID = RIGHT.ultID AND
															LEFT.orgID = RIGHT.orgID AND
															LEFT.seleID = RIGHT.seleID AND
															LEFT.SICCode = RIGHT.SICCode AND
															LEFT.NAICCode = RIGHT.NAICCode,
															TRANSFORM({RECORDOF(sortedTempOutput)},
																				SELF.FirstSeenDate := IF(LEFT.FirstSeenDate = 0, MAX(LEFT.FirstSeenDate, RIGHT.FirstSeenDate), MIN(LEFT.FirstSeenDate, RIGHT.FirstSeenDate));
																				SELF.LastSeenDate := MAX(LEFT.LastSeenDate, RIGHT.LastSeenDate);
																				SELF.RecordCount := LEFT.RecordCount + RIGHT.RecordCount;
																				SELF.IsPrimary := LEFT.IsPrimary OR RIGHT.IsPrimary;
																				SELF := LEFT;));

		projectSources := PROJECT(rollTempOutput, TRANSFORM(DueDiligence.LayoutsInternal.SicNaicLayout,
																												SELF.sources := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.LayoutSICNAIC,
																																																SELF.DateFirstSeen := LEFT.FirstSeenDate;
																																																SELF.DateLastSeen := LEFT.LastSeenDate;
																																																
																																																sic := TRIM(LEFT.SICCode, ALL);
																																																lengthOfSic := LENGTH(sic);
																																																
																																																SELF.SICIndustry := MAP(sic = DueDiligence.Constants.EMPTY => sic,
																																																												sic IN DueDiligence.Constants.CIB_SIC_RETAIL => DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL,
																																																												sic IN DueDiligence.Constants.CIB_SIC_NON_RETAIL => DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL,
																																																												sic IN DueDiligence.Constants.MSB_SIC => DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS,
																																																												sic IN DueDiligence.Constants.NBFI_SIC => DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS,
																																																												sic IN DueDiligence.Constants.CASGAM_SIC => DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING,
																																																												sic IN DueDiligence.Constants.LEGTRAV_SIC => DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL,
																																																												sic IN DueDiligence.Constants.AUTO_SIC => DueDiligence.Constants.INDUSTRY_AUTOMOTIVE,
																																																												DueDiligence.Constants.INDUSTRY_OTHER);
																																																																																																
																																																SELF.SICRiskLevel := MAP(sic = DueDiligence.Constants.EMPTY => sic,
																																																													lengthOfSic = 2 AND sic IN DueDiligence.Constants.SIC_LENGTH_2_RISK_HIGH => DueDiligence.Constants.RISK_LEVEL_HIGH,
																																																													lengthOfSic = 4 AND (sic IN DueDiligence.Constants.SIC_LENGTH_4_RISK_HIGH OR 
																																																																								sic[1..2] IN DueDiligence.Constants.SIC_FIRST_2_STAR_RISK_HIGH) => DueDiligence.Constants.RISK_LEVEL_HIGH,
																																																													lengthOfSic = 6 AND (sic IN DueDiligence.Constants.SIC_LENGTH_6_RISK_HIGH OR 
																																																																								sic[1..2] IN DueDiligence.Constants.SIC_FIRST_2_STAR_RISK_HIGH OR
																																																																								sic[1..4] IN DueDiligence.Constants.SIC_FIRST_4_STAR_RISK_HIGH) => DueDiligence.Constants.RISK_LEVEL_HIGH,
																																																													lengthOfSic = 8 AND (sic IN DueDiligence.Constants.SIC_LENGTH_8_RISK_HIGH OR
																																																																								sic[1..2] IN DueDiligence.Constants.SIC_FIRST_2_STAR_RISK_HIGH OR
																																																																								sic[1..4] IN DueDiligence.Constants.SIC_FIRST_4_STAR_RISK_HIGH OR
																																																																								sic[1..6] IN DueDiligence.Constants.SIC_FIRST_6_STAR_RISK_HIGH) => DueDiligence.Constants.RISK_LEVEL_HIGH,
																																																													DueDiligence.Constants.RISK_LEVEL_LOW);
																																																												
																																																naic := TRIM(LEFT.NAICCode, ALL);
																																																naic2 := naic[1..2];
																																																
																																																SELF.NAICIndustry := MAP(naic = DueDiligence.Constants.EMPTY => naic,
																																																												naic IN DueDiligence.Constants.CIB_NAICS_RETAIL => DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL,
																																																												naic IN DueDiligence.Constants.CIB_NAICS_NON_RETAIL => DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL,
																																																												naic IN DueDiligence.Constants.MSB_NAICS => DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS,
																																																												naic IN DueDiligence.Constants.NBFI_NAICS => DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS,
																																																												naic IN DueDiligence.Constants.CASGAM_NAISC => DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING,
																																																												naic IN DueDiligence.Constants.LEGTRAV_NAISC => DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL,
																																																												naic IN DueDiligence.Constants.AUTO_NAISC => DueDiligence.Constants.INDUSTRY_AUTOMOTIVE,
																																																												DueDiligence.Constants.INDUSTRY_OTHER);
																																																												
																																																SELF.NAICRiskLevel := MAP(naic = DueDiligence.Constants.EMPTY => naic,
																																																													naic2 IN DueDiligence.Constants.NAICS_RISK_HIGH OR
																																																													naic IN DueDiligence.Constants.NAICS_RISK_HIGH_EXCEP => DueDiligence.Constants.RISK_LEVEL_HIGH,
																																																													naic2 IN DueDiligence.Constants.NAICS_RISK_MED => DueDiligence.Constants.RISK_LEVEL_MEDIUM,
																																																													naic2 IN DueDiligence.Constants.NAICS_RISK_LOW => DueDiligence.Constants.RISK_LEVEL_LOW,
																																																													DueDiligence.Constants.RISK_LEVEL_UNKNOWN);
																																																SELF := LEFT;
																																																SELF :=[];));
																												SELF := LEFT;
																												SELF := [];));
																												
		sortSources := SORT(projectSources, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
		finalRoll := ROLLUP(sortSources,
												LEFT.seq = RIGHT.seq AND
												LEFT.ultID = RIGHT.ultID AND
												LEFT.orgID = RIGHT.orgID AND
												LEFT.seleID = RIGHT.seleID,
												TRANSFORM(DueDiligence.LayoutsInternal.SicNaicLayout,
																	SELF.sources := LEFT.sources + RIGHT.sources;
																	SELF := LEFT;));

	
		RETURN finalRoll;

	ENDMACRO;
	
	
	EXPORT getSicNaicCodes(InDataset, SicNaicsField, IsSicField, PrimaryField, DateFirstSeenName, DateLastSeenName, SourceOfData) := FUNCTIONMACRO
		
		temp := TABLE(InDataset,{seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()),
														 STRING3 Source := SourceOfData,
														 UNSIGNED4 FirstSeenDate := MIN(GROUP, DateFirstSeenName),
														 UNSIGNED4 LastSeenDate := MAX(GROUP, DateLastSeenName),
														 UNSIGNED4 RecordCount := COUNT(GROUP),
														 STRING10 NAICCode := IF(IsSicField, DueDiligence.Constants.EMPTY, (STRING)SicNaicsField),
														 STRING10 SICCode := IF(IsSicField, (STRING)SicNaicsField, DueDiligence.Constants.EMPTY),
														 BOOLEAN IsPrimary := PrimaryField },
									seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), (STRING)SicNaicsField);
													 
		filterSic := temp(SICCode <> DueDiligence.Constants.EMPTY);
		filterNaic := temp(NAICCode <> DueDiligence.Constants.EMPTY);
		
		results := IF(IsSicField, filterSic, filterNaic);

		RETURN results;

	ENDMACRO;
	
	
	EXPORT GetCleanBIPShell(DATASET(DueDiligence.Layouts.CleanedData) cleanInput) := FUNCTION

		cleanedInput := PROJECT(cleanInput, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																									SELF.Seq := LEFT.inputecho.seq;
																									SELF.Clean_Input.Seq := LEFT.inputecho.seq;
																									SELF.Clean_Input.AcctNo := LEFT.inputecho.business.accountNumber;
																									
																									//get the cleaned business data
																									cleanData := LEFT.cleanedInput.business;
																									//get the cleaned business address data
																									cleanAddress := cleanData.address;
																									
																									SELF.Clean_Input.CompanyName := cleanData.companyName;
																									SELF.Clean_Input.AltCompanyName := cleanData.altCompanyName;
																									SELF.Clean_Input.FEIN := cleanData.fein;
																									SELF.Clean_Input.Phone10 := cleanData.phone;
																									
																									SELF.Clean_Input.StreetAddress1 := cleanAddress.streetAddress1;
																									SELF.Clean_Input.StreetAddress2 := cleanAddress.streetAddress2;
																									SELF.Clean_Input.Prim_Range := cleanAddress.prim_range;
																									SELF.Clean_Input.Predir := cleanAddress.predir;
																									SELF.Clean_Input.Prim_Name := cleanAddress.prim_name;
																									SELF.Clean_Input.Addr_Suffix := cleanAddress.addr_suffix;
																									SELF.Clean_Input.Postdir := cleanAddress.postdir;
																									SELF.Clean_Input.Unit_Desig := cleanAddress.unit_desig;
																									SELF.Clean_Input.Sec_Range := cleanAddress.sec_range;
																									SELF.Clean_Input.City := cleanAddress.city;  // use v_city_name 90..114 to match all other scoring products
																									SELF.Clean_Input.State := cleanAddress.state;
																									SELF.Clean_Input.Zip := cleanAddress.zip5 + cleanAddress.zip4;
																									SELF.Clean_Input.Zip5 := cleanAddress.zip5;
																									SELF.Clean_Input.Zip4 := cleanAddress.zip4;
																									SELF.Clean_Input.Lat := cleanAddress.geo_lat;
																									SELF.Clean_Input.Long := cleanAddress.geo_long;
																									SELF.Clean_Input.Addr_Type := cleanAddress.rec_type;
																									SELF.Clean_Input.Addr_Status := cleanAddress.err_stat;
																									SELF.Clean_Input.County := cleanAddress.county;
																									SELF.Clean_Input.Geo_Block := cleanAddress.geo_blk;
																									
																									//set BIP IDs if we have them
																									SELF.Clean_Input.PowID := cleanData.BIP_IDs.PowID.LinkID;
																									SELF.Clean_Input.ProxID := cleanData.BIP_IDs.ProxID.LinkID;
																									SELF.Clean_Input.SeleID := cleanData.BIP_IDs.SeleID.LinkID;
																									SELF.Clean_Input.OrgID := cleanData.BIP_IDs.OrgID.LinkID;
																									SELF.Clean_Input.UltID := cleanData.BIP_IDs.UltID.LinkID;
																								
																									SELF.Clean_Input.HistoryDate := LEFT.cleanedInput.historyDateYYYYMMDD;
																									SELF.Clean_Input := cleanData; // Fill out the remaining fields with what was passed in
																									
																									SELF := [];)); // None of the remaining attributes have been populated yet));
		
		RETURN cleanedInput;
	END;
	
	EXPORT GetBusInternalBIPShell(DATASET(DueDiligence.Layouts.Busn_Internal) businessInput) := FUNCTION

		busInternal := PROJECT(businessInput, TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																										SELF.Seq := LEFT.seq;
																										SELF.Clean_Input.Seq := LEFT.seq;
																										SELF.Clean_Input.AcctNo := LEFT.busn_info.accountNumber;
																										
																										//get the business data
																										busInfo := LEFT.busn_info;
																										//get the business address data
																										busAddress := busInfo.address;
																										
																										SELF.Clean_Input.CompanyName := busInfo.companyName;
																										SELF.Clean_Input.AltCompanyName := busInfo.altCompanyName;
																										SELF.Clean_Input.FEIN := busInfo.fein;
																										SELF.Clean_Input.Phone10 := busInfo.phone;
																										
																										SELF.Clean_Input.StreetAddress1 := busAddress.streetAddress1;
																										SELF.Clean_Input.StreetAddress2 := busAddress.streetAddress2;
																										SELF.Clean_Input.Prim_Range := busAddress.prim_range;
																										SELF.Clean_Input.Predir := busAddress.predir;
																										SELF.Clean_Input.Prim_Name := busAddress.prim_name;
																										SELF.Clean_Input.Addr_Suffix := busAddress.addr_suffix;
																										SELF.Clean_Input.Postdir := busAddress.postdir;
																										SELF.Clean_Input.Unit_Desig := busAddress.unit_desig;
																										SELF.Clean_Input.Sec_Range := busAddress.sec_range;
																										SELF.Clean_Input.City := busAddress.city;  // use v_city_name 90..114 to match all other scoring products
																										SELF.Clean_Input.State := busAddress.state;
																										SELF.Clean_Input.Zip := busAddress.zip5 + busAddress.zip4;
																										SELF.Clean_Input.Zip5 := busAddress.zip5;
																										SELF.Clean_Input.Zip4 := busAddress.zip4;
																										SELF.Clean_Input.Lat := busAddress.geo_lat;
																										SELF.Clean_Input.Long := busAddress.geo_long;
																										SELF.Clean_Input.Addr_Type := busAddress.rec_type;
																										SELF.Clean_Input.Addr_Status := busAddress.err_stat;
																										SELF.Clean_Input.County := busAddress.county;
																										SELF.Clean_Input.Geo_Block := busAddress.geo_blk;
																										
																										//set BIP IDs if we have them
																										SELF.Clean_Input.PowID := busInfo.BIP_IDs.PowID.LinkID;
																										SELF.Clean_Input.ProxID := busInfo.BIP_IDs.ProxID.LinkID;
																										SELF.Clean_Input.SeleID := busInfo.BIP_IDs.SeleID.LinkID;
																										SELF.Clean_Input.OrgID := busInfo.BIP_IDs.OrgID.LinkID;
																										SELF.Clean_Input.UltID := busInfo.BIP_IDs.UltID.LinkID;
																									
																										SELF.Clean_Input.HistoryDate := LEFT.historydate;
																										SELF.Clean_Input := busInfo; // Fill out the remaining fields with what was passed in
																										
																										SELF := [];)); // None of the remaining attributes have been populated yet));
		
		RETURN busInternal;
	END;
	
	EXPORT getAddressScore(STRING prim_range1, STRING prim_name1, STRING sec_range1, STRING prim_range2, STRING prim_name2, STRING sec_range2) := FUNCTION
		score := Risk_Indicators.AddrScore.AddressScore(prim_range1, prim_name1, sec_range1, prim_range2, prim_name2, sec_range2);
	
		RETURN score;
	END;
	
	EXPORT getExecs(DATASET(DueDiligence.Layouts.Busn_Internal) inquiredBus) := FUNCTION

		party := NORMALIZE(inquiredBus, LEFT.execs, TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty,
																													SELF.party := RIGHT;
																													SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																													SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																													SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																													SELF := LEFT;
																													SELF := [];));
	
		RETURN party;
	END;
	
	EXPORT getLinkedBusinesses(DATASET(DueDiligence.Layouts.Busn_Internal) inquiredBus) := FUNCTION

		lnkedBus := NORMALIZE(inquiredBus, LEFT.linkedBusinesses, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																													SELF.seq := LEFT.seq;
																													SELF.historydate := LEFT.historydate;
																													SELF.busn_info := RIGHT;
																													SELF.relatedDegree := DueDiligence.Constants.LINKED_BUSINESS_DEGREE;
																													SELF := [];));
	
		RETURN lnkedBus;
	END; 

// ******************************************************************************************************** //
// Replace/Overlay the Executives info on the Business Internal with the updatedExec information collected  //
// ******************************************************************************************************** // 
EXPORT ReplaceExecs(DATASET(DueDiligence.Layouts.Busn_Internal) inquiredBus,
                    DATASET(DueDiligence.LayoutsInternal.RelatedParty) UpdateExecs) := FUNCTION

// Define a layout just for this FUNCTION                              //  
   ExecsChildRollUPLayout    := RECORD
	    DueDiligence.LayoutsInternal.InternalBIPIDsLayout;                           //*  This is the unique ID of the parent  
	    DATASET(DueDiligence.Layouts.RelatedParty) ExecutiveInfo;
	 END;														 

// Populate the a new DATASET to be used in the ROLLUP                  //  	
   ExecutivePreSort  := PROJECT(UpdateExecs, TRANSFORM(ExecsChildRollUPLayout,
	                                    SELF.ExecutiveInfo := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.RelatedParty,
																																				   SELF := LEFT.party;));
																			SELF := LEFT;));
	               
// SORT the Executive Prep in seq, ulti etc. sequence For the ROLLUP!!!!!//
   ExecutiveSort  := SORT(ExecutivePreSort, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

// RollUp all of the Executives into a Normalized Dataset              // 
// Create a Parent Row of seq, ultid, orgid, seleid, powid and proxid  //
//                                                                     //
 ExecutiveDataset  :=   
		ROLLUP(ExecutiveSort,
				LEFT.seq          = RIGHT.seq
				     AND
				LEFT.UltID        = RIGHT.UltID
				     AND
				LEFT.OrgID        = RIGHT.OrgID
				     AND
				LEFT.SeleID       = RIGHT.SeleID,
				                       // And create children rows of executives  //
				                        TRANSFORM (ExecsChildRollUPLayout ,
																		       SELF.ExecutiveInfo    := LEFT.ExecutiveInfo + RIGHT.ExecutiveInfo; 
																					 SELF                := LEFT));
				       
 
 /* DENORMALIZE/JOIN and the BusnData(parentrecordset) with the Legal Events(childrecordset)  */   															 															
	   ReplaceBusnExecsWithNewInfo := DENORMALIZE(inquiredBus, ExecutiveDataset,
	                                              /* WHERE */ 
																							 LEFT.seq                             = RIGHT.seq
																							      AND
	                                             LEFT.Busn_info.BIP_IDS.UltID.LinkID  = RIGHT.UltID
																							      AND
																							 LEFT.Busn_info.BIP_IDS.OrgID.LinkID  = RIGHT.OrgID
																							      AND
																							 LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.SeleID,  
												                       GROUP,
																							 
																							 /* Update the Parent dataset  From the Left */  
																							 TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
																							      SELF.seq                              := LEFT.seq; 
																							      SELF.Busn_info.BIP_IDS.UltID.LinkID   := LEFT.Busn_info.BIP_IDS.UltID.LinkID; 
																							      /* Overlay the Child dataset From the Right   */  
                                                    SELF.Execs                            := RIGHT.ExecutiveInfo;                                             
																							      SELF                                  := LEFT,
                                                    SELF                                  := []));

		 
	
		RETURN ReplaceBusnExecsWithNewInfo;
	END; 
	
	
	
  EXPORT getLienTypeCategory( STRING filing_type_desc) := FUNCTION

  lien_type_category := 
					MAP(
						filing_type_desc IN Risk_Indicators.iid_constants.set_Invalid_Liens_50	=> DueDiligence.Constants.INVALID_LIEN,        //'IN'
						filing_type_desc IN Risk_Indicators.iid_constants.setSuits           	  => DueDiligence.Constants.SUITS,               //'SU'
						filing_type_desc IN Risk_Indicators.iid_constants.setSmallClaims    		=> DueDiligence.Constants.SMALL_CLAIMS,        //'SC'
						filing_type_desc IN Risk_Indicators.iid_constants.setFederalTax     		=> DueDiligence.Constants.FEDERAL_TAX,         //'FX'
						filing_type_desc IN Risk_Indicators.iid_constants.setForeclosure     	  => DueDiligence.Constants.FORECLOSURE,         //'FC'
						filing_type_desc IN Risk_Indicators.iid_constants.setLandlordTenant 		=> DueDiligence.Constants.LANDLORD_TENANT,     //'LT'
						filing_type_desc IN Risk_Indicators.iid_constants.setLisPendens     		=> DueDiligence.Constants.LISPENDENS,          //'LP',
						filing_type_desc IN Risk_Indicators.iid_constants.setMechanicsLiens 		=> DueDiligence.Constants.MECHANICS_LIEN,      //'ML',
						filing_type_desc IN Risk_Indicators.iid_constants.setCivilJudgment  		=> DueDiligence.Constants.CIVIL_JUDGMENT,      //'CJ',
						filing_type_desc IN Risk_Indicators.iid_constants.setOtherTax					  => DueDiligence.Constants.OTHER_TAX,           //'OX',
						filing_type_desc NOT IN 
							[ 
								Risk_Indicators.iid_constants.setCivilJudgment + Risk_Indicators.iid_constants.setFederalTax + 
								Risk_Indicators.iid_constants.setLandlordTenant + Risk_Indicators.iid_constants.setSmallClaims + 
								Risk_Indicators.iid_constants.setForeclosure + Risk_Indicators.iid_constants.setOtherTax
							]  																																				=> DueDiligence.Constants.DEFAULT_LIEN_CATAGORY,  //'OT',
						                                                                               DueDiligence.Constants.DEFAULT_LIEN_CATAGORY); //'OT' is default

  RETURN lien_type_category;
	END;


   EXPORT getJudgmentTypeCategory( STRING filing_type_desc) := FUNCTION

   judgment_type_category :=    
			 MAP(
						filing_type_desc IN Risk_Indicators.iid_constants.set_Invalid_Liens_50	=> DueDiligence.Constants.INVALID_JUDGMENT,     //'Invalid',
						filing_type_desc IN Risk_Indicators.iid_constants.setSuits           	  => DueDiligence.Constants.JUDGMENT,             //'Judgment',
						filing_type_desc IN Risk_Indicators.iid_constants.setSmallClaims    		=> DueDiligence.Constants.JUDGMENT,             //'Judgment',
						filing_type_desc IN Risk_Indicators.iid_constants.setFederalTax     		=> DueDiligence.Constants.LIEN,                 //'Lien',
						filing_type_desc IN Risk_Indicators.iid_constants.setForeclosure     	  => DueDiligence.Constants.LIEN,                 //'Lien', 
						filing_type_desc IN Risk_Indicators.iid_constants.setLandlordTenant 		=> DueDiligence.Constants.LIEN,                 //'Lien',
						filing_type_desc IN Risk_Indicators.iid_constants.setLisPendens     		=> DueDiligence.Constants.LIEN,                 //'Lien',
						filing_type_desc IN Risk_Indicators.iid_constants.setOtherTax       		=> DueDiligence.Constants.LIEN,                 //'Lien',
						filing_type_desc IN Risk_Indicators.iid_constants.setMechanicsLiens 		=> DueDiligence.Constants.LIEN,                 //'Lien',
						filing_type_desc IN Risk_Indicators.iid_constants.setCivilJudgment  		=> DueDiligence.Constants.JUDGMENT,             //'Judgment',
						filing_type_desc NOT IN 
							[ 
								Risk_Indicators.iid_constants.setCivilJudgment + Risk_Indicators.iid_constants.setFederalTax + 
								Risk_Indicators.iid_constants.setLandlordTenant + Risk_Indicators.iid_constants.setOtherTax + 
								Risk_Indicators.iid_constants.setSmallClaims + Risk_Indicators.iid_constants.setForeclosure
							]                                                                     => 'Lien',
						                                                                           'Lien'); // default
					
    RETURN judgment_type_category;
	END;



  EXPORT getFilingStatusCategory( STRING filing_status) := FUNCTION

   filing_status_category :=    
    MAP(
						filing_status IN DueDiligence.Constants.filing_status_satisfied => 'Satis',
						filing_status IN DueDiligence.Constants.filing_status_dismissed => 'Dismiss',
						filing_status  = 'UNLAPSED'                                     => 'Unlapsed',
						filing_status  = 'LAPSED'                                       => 'Lapsed',
						filing_status NOT IN
							[
								DueDiligence.Constants.filing_status_satisfied 
								+ DueDiligence.Constants.filing_status_dismissed 
								+ [ 'UNLAPSED','LAPSED' ]
							]                                                                  => 'Other',
						                                                                        ''); // default
    RETURN filing_status_category; 
  END;

	//NOTE: This is being used during development between developers - this is not used/available in the product at this point...
	EXPORT IndividualJoin(joinTo, didFieldName, keyName, whereClause, joinType, maxRecords = 5) := FUNCTIONMACRO

		LOCAL atmostMax := IF(maxRecords > 0, 'ATMOST(' + maxRecords + ')', DueDiligence.Constants.EMPTY);
		LOCAL addJoinType := IF(joinType = DueDiligence.Constants.EMPTY, joinType, joinType + ',');
		LOCAL didField := 'LEFT.' + didFieldName;
		
		LOCAL joinResult := JOIN(joinTo, #EXPAND(keyName), 
													#EXPAND(whereClause), 
													TRANSFORM({UNSIGNED4 seq, UNSIGNED6 inDid, UNSIGNED4 historyDate, RECORDOF(RIGHT)},
																		SELF.seq := LEFT.seq;
																		SELF.inDid := #EXPAND(didField);
																		SELF.historyDate := LEFT.historyDate;
																		SELF := RIGHT), 
													#EXPAND(addJoinType)					
													#EXPAND(atmostMax)); 
												
		RETURN joinResult;

	ENDMACRO;
		
END;