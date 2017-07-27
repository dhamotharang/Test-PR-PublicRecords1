IMPORT Address, BIPV2, DueDiligence, Risk_Indicators, ut, STD;

EXPORT Common := MODULE
	// Grabs just the linking ID's and Unique Seq Number - this is needed to use the BIP kFetch
	EXPORT GetLinkIDs(DATASET(DueDiligence.Layouts.Busn_Internal) BusnData) := FUNCTION
		
		BIPV2.IDlayouts.l_xlink_ids2 grabLinkIDs(DueDiligence.Layouts.Busn_Internal le) := TRANSFORM
			SELF.UniqueID		:= le.seq;
			SELF.PowID			:= le.Busn_info.BIP_IDs.PowID.LinkID;
			SELF.PowScore		:= le.Busn_info.BIP_IDs.PowID.Score;
			SELF.PowWeight	:= le.Busn_info.BIP_IDs.PowID.Weight;
			
			SELF.ProxID			:= le.Busn_info.BIP_IDs.ProxID.LinkID;
			SELF.ProxScore	:= le.Busn_info.BIP_IDs.ProxID.Score;
			SELF.ProxWeight	:= le.Busn_info.BIP_IDs.ProxID.Weight;
			
			SELF.SeleID			:= le.Busn_info.BIP_IDs.SeleID.LinkID;
			SELF.SeleScore	:= le.Busn_info.BIP_IDs.SeleID.Score;
			SELF.SeleWeight	:= le.Busn_info.BIP_IDs.SeleID.Weight;
			
			SELF.OrgID			:= le.Busn_info.BIP_IDs.OrgID.LinkID;
			SELF.OrgScore		:= le.Busn_info.BIP_IDs.OrgID.Score;
			SELF.OrgWeight	:= le.Busn_info.BIP_IDs.OrgID.Weight;
			
			SELF.UltID			:= le.Busn_info.BIP_IDs.UltID.LinkID;
			SELF.UltScore		:= le.Busn_info.BIP_IDs.UltID.Score;
			SELF.UltWeight	:= le.Busn_info.BIP_IDs.UltID.Weight;
			
			SELF := [];                                       // Don't populate DotID or EmpID
		END;
		
		linkIDsOnly := PROJECT(BusnData, grabLinkIDs(LEFT));
		
		RETURN linkIDsOnly;
	END;

	//copied/modified from 	Business_Risk_BIP.Common.AppendSeq2
	EXPORT AppendSeq(rawData, datasetToJoinTo, joinResult) := MACRO
		joinResult := JOIN(rawData, datasetToJoinTo, 
												LEFT.UniqueID = RIGHT.Seq, 
												TRANSFORM({RECORDOF(LEFT), UNSIGNED4 Seq, UNSIGNED4 HistoryDate},
																	SELF.Seq := RIGHT.Seq;
																	SELF.HistoryDate := RIGHT.HistoryDate;
																	SELF := LEFT), 
												FEW); // Can use FEW because the RIGHT side should contain < 10000 rows (100 only average in batch)
	ENDMACRO;
	
	
	EXPORT fn_filterOnArchiveDate(INTEGER fieldDate, INTEGER archiveDate) := FUNCTION
		
		isEarlierThanArchiveDate := fieldDate < archiveDate AND fieldDate > 0;

		RETURN isEarlierThanArchiveDate;
	END;
	
	
	EXPORT fn_filterOnCurrentMode(INTEGER fieldDate) := FUNCTION
		
		isCurrentMode := fieldDate > 0 AND (INTEGER)((STRING)fieldDate) <= (INTEGER)((STRING)StringLib.getDateYYYYMMDD());
		
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
		currentYear := (UNSIGNED2)(StringLib.getdateYYYYMMDD()[1..4]);
		
		month := find_month(dateVal);
		
		day := dateVal % 100;
		daysInMonths := [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; // using this requires checking for leap year
		
		leap_adjust := IF (month = 2 and Std.Date.IsLeapYear(yearIn), 1, 0);
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
		updatedField := PROJECT(datasetToCheck,
														TRANSFORM({RECORDOF(LEFT)},
																			SELF.dateFieldToCheck := (TYPEOF(datasetToCheck.dateFieldToCheck))DueDiligence.Common.checkInvalidDate((STRING)LEFT.dateFieldToCheck);
																			SELF := LEFT));

		RETURN updatedField;
	ENDMACRO;
	
	EXPORT GetCleanData(DATASET(DueDiligence.Layouts.Input) input) := FUNCTION
	
		DueDiligence.Layouts.CleanedData cleanIt(DueDiligence.Layouts.Input le) := TRANSFORM
		
			busAddress := le.business.address;
			
			//Company Address Fields
			companyAddress := Risk_Indicators.MOD_AddressClean.street_address(busAddress.streetAddress1 + ' ' + busAddress.streetAddress2, busAddress.prim_range, 
																																				busAddress.predir, busAddress.prim_name, busAddress.addr_suffix, 
																																				busAddress.postdir, busAddress.unit_desig, busAddress.sec_range);
																																				
			companyCleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(companyAddress, busAddress.city, busAddress.state, busAddress.zip5);											
		
			cleanedCompanyAddress := Address.CleanFields(companyCleanAddr);
			
			street1 := Risk_Indicators.MOD_AddressClean.street_address('', cleanedCompanyAddress.Prim_Range, cleanedCompanyAddress.Predir, cleanedCompanyAddress.Prim_Name, 
																												cleanedCompanyAddress.Addr_Suffix, cleanedCompanyAddress.Postdir, cleanedCompanyAddress.Unit_Desig, cleanedCompanyAddress.Sec_Range);
			
			addressClean := DATASET([TRANSFORM(DueDiligence.Layouts.Address,
																					SELF.streetAddress1 := street1;
																					SELF.streetAddress2 := TRIM(StringLib.StringToUppercase(busAddress.StreetAddress2));
																					SELF.prim_range := cleanedCompanyAddress.prim_range;
																					SELF.predir := cleanedCompanyAddress.predir;
																					SELF.prim_name := cleanedCompanyAddress.prim_name;
																					SELF.addr_suffix := cleanedCompanyAddress.addr_suffix;
																					SELF.postdir := cleanedCompanyAddress.postdir;
																					SELF.unit_desig := cleanedCompanyAddress.unit_desig;
																					SELF.sec_range := cleanedCompanyAddress.sec_range;
																					SELF.city := cleanedCompanyAddress.v_city_name;
																					SELF.state := cleanedCompanyAddress.st;
																					SELF.zip5 := cleanedCompanyAddress.zip;
																					SELF.zip4 := cleanedCompanyAddress.zip4;
																					SELF.cart := cleanedCompanyAddress.cart;
																					SELF.cr_sort_sz := cleanedCompanyAddress.cr_sort_sz;
																					SELF.lot := cleanedCompanyAddress.lot;
																					SELF.lot_order := cleanedCompanyAddress.lot_order;
																					SELF.dbpc := cleanedCompanyAddress.dbpc;
																					SElF.chk_digit := cleanedCompanyAddress.chk_digit;
																					SELF.rec_type := cleanedCompanyAddress.rec_type;
																					SELF.county := cleanedCompanyAddress.county;
																					SELF.geo_lat := cleanedCompanyAddress.geo_lat;
																					SELF.geo_long := cleanedCompanyAddress.geo_long;
																					SELF.msa := cleanedCompanyAddress.msa;
																					SELF.geo_blk := cleanedCompanyAddress.geo_blk;
																					SELF.geo_match := cleanedCompanyAddress.geo_match;
																					SELF.err_stat := cleanedCompanyAddress.err_stat;
																					SELF := [];)])[1];
																					
			busName := le.business.companyName;
			altBusName := le.business.altCompanyName;
			
			//Company Name Fields
			companyName := IF(busName = '', ut.CleanCompany(altBusName), ut.CleanCompany(busName)); // If the customer didn't pass in a company but passed in an alt company name use the alt as the company name
			altCompanyName := IF(busName = '', '', ut.CleanCompany(altBusName)); // Blank out the cleaned AltCompanyName if CompanyName wasn't populated, as we copied Alt into the Main CompanyName field on the previous line
			
			//remove any non-numeric fiends from taxID and lexID fields
			
			//valid history date passed - if invalid should return 99999999 for current mode
			validDate := checkInvalidDate((STRING)le.historyDateYYYYMMDD, (STRING)DueDiligence.Constants.date8Nines);
			
			
			busClean := DATASET([TRANSFORM(DueDiligence.Layouts.Busn_Input,
																			SELF.lexID := le.business.lexID;
																			SELF.companyName := companyName;
																			SELF.altCompanyName := altCompanyName;
																			SELF.address := addressClean;
																			SELF.phone := le.business.phone;
																			SELF.fein := le.business.fein;
																			SELF := [];)])[1];

			inputClean := DATASET([TRANSFORM(DueDiligence.Layouts.Input,
																				SELF.business := busClean;
																				SELF.historyDateYYYYMMDD := (UNSIGNED)validDate;
																				SELF := le;
																				SELF := [];)])[1];
			
			
			SELF.cleanedInput := inputClean;
			SELF.inputEcho := le;
			SELF := [];
		END;
		
		RETURN PROJECT(input, cleanIt(LEFT));
	END;
	
	
END;