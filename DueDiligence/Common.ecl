﻿IMPORT Address, BIPV2, Business_Header, Business_Risk_BIP, codes, DueDiligence, Easi, Census_Data, iesp, Risk_Indicators, STD, ut;


EXPORT Common := MODULE

	EXPORT createNVPair(STRING name, STRING val) := FUNCTION
			
			iesp.share.t_NameValuePair createPair(STRING n, STRING v) := TRANSFORM
				SELF.Name := n;
				SELF.Value := v;
			END;
			
			RETURN ROW(createPair(name, val));			
	END;

	EXPORT getNameFromList(UNSIGNED fieldNumber, CONST STRING fieldList, UNSIGNED numberOfFields) := FUNCTION
		//determine the location of the commas in the list
		previousCommaLocation := IF(fieldNumber = 1, DueDiligence.Constants.NUMERIC_ZERO, STD.Str.Find(fieldList, ',', fieldNumber-1));
		commaLocation := IF(numberOfFields = fieldNumber, DueDiligence.Constants.NUMERIC_ZERO, STD.Str.Find(fieldList, ',', fieldNumber));
		
		//to get field name add 1 to start at character after comma, and subtract 1 to remove the comma	
		name := IF(numberOfFields = fieldNumber, fieldList[previousCommaLocation+1..], fieldList[previousCommaLocation+1..commaLocation-1]);
		
		RETURN name;	
	END;	
	
	EXPORT getFieldProject(UNSIGNED number, CONST STRING list, UNSIGNED listSize) := FUNCTION
		fieldName := getNameFromList(number, list, listSize);
		RETURN 'SELF.' + fieldName + ' := (UNSIGNED4)DueDiligence.Common.checkInvalidDate((STRING)LEFT.' + fieldName + ');';
	END;

	EXPORT getFinalList(CONST STRING list) := FUNCTION
		trimFields := TRIM(list, ALL);
		RETURN trimFields[..LENGTH(trimFields)-1];
	END;
	
	EXPORT updateNestedLayout(ds, aliasName) := FUNCTIONMACRO
		#if(aliasName = DueDiligence.Constants.EMPTY)
			updatedData := ds;
		#else

			grabFields(CONST STRING field) := FUNCTION
				periodLocation := STD.Str.Find(field, '.', 1);
				
				name := IF(periodLocation > DueDiligence.Constants.NUMERIC_ZERO AND field[..periodLocation-1] = aliasName, 
											field[periodLocation+1..] + ',', 
											DueDiligence.Constants.EMPTY);
				
				RETURN name;
			END;

			removeAliasField1 := grabFields(dateField1);
			removeAliasField2 := removeAliasField1 + grabFields(dateField2);
			removeAliasField3 := removeAliasField2 + grabFields(dateField3);
			removeAliasField4 := removeAliasField3 + grabFields(dateField4);
			removeAliasField5 := removeAliasField4 + grabFields(dateField5);
			removeAliasField6 := removeAliasField5 + grabFields(dateField6);
			removeAliasField7 := removeAliasField6 + grabFields(dateField7);
			removeAliasField8 := removeAliasField7 + grabFields(dateField8);
			removeAliasField9 := removeAliasField8 + grabFields(dateField9);
			removeAliasField10 := removeAliasField9 + grabFields(dateField10);

			aliasFieldList := DueDiligence.Common.getFinalList(removeAliasField10);
			numberOfAliasFields := STD.Str.CountWords(aliasFieldList, ',');
			
			toRemoveAliasFields := STD.Str.FindReplace(aliasFieldList, ',', ' -');
			readdAliasFields := STD.Str.FindReplace(aliasFieldList, ',', ', UNSIGNED4 ');
			
			appendAliasName := aliasName + '.' + STD.Str.FindReplace(aliasFieldList, ',', ', ' + aliasName + '.');

			removeAliasFieldLayout := RECORD
				RECORDOF(ds.#EXPAND(aliasName)) -#EXPAND(toRemoveAliasFields);
			END;

			newUpdatedAliasLayout := RECORD
				RECORDOF(removeAliasFieldLayout);
				UNSIGNED4 #EXPAND(readdAliasFields);
			END;
			
			removeAliasFromTopLevelLayout := RECORD
				RECORDOF(ds) -#EXPAND(aliasName);
			END;

			updatedData := PROJECT(ds, TRANSFORM({RECORDOF(removeAliasFromTopLevelLayout), RECORDOF(newUpdatedAliasLayout) #EXPAND(aliasName)}, 
																						
																																									#EXPAND(IF(numberOfAliasFields >= 1, DueDiligence.Common.getFieldProject(1, appendAliasName, numberOfAliasFields), DueDiligence.Constants.EMPTY))
																																									#EXPAND(IF(numberOfAliasFields >= 2, DueDiligence.Common.getFieldProject(2, appendAliasName, numberOfAliasFields), DueDiligence.Constants.EMPTY))
																																									#EXPAND(IF(numberOfAliasFields >= 3, DueDiligence.Common.getFieldProject(3, appendAliasName, numberOfAliasFields), DueDiligence.Constants.EMPTY))
																																									#EXPAND(IF(numberOfAliasFields >= 4, DueDiligence.Common.getFieldProject(4, appendAliasName, numberOfAliasFields), DueDiligence.Constants.EMPTY))
																																									#EXPAND(IF(numberOfAliasFields >= 5, DueDiligence.Common.getFieldProject(5, appendAliasName, numberOfAliasFields), DueDiligence.Constants.EMPTY))
																																									#EXPAND(IF(numberOfAliasFields >= 6, DueDiligence.Common.getFieldProject(6, appendAliasName, numberOfAliasFields), DueDiligence.Constants.EMPTY))
																																									#EXPAND(IF(numberOfAliasFields >= 7, DueDiligence.Common.getFieldProject(7, appendAliasName, numberOfAliasFields), DueDiligence.Constants.EMPTY))
																																									#EXPAND(IF(numberOfAliasFields >= 8, DueDiligence.Common.getFieldProject(8, appendAliasName, numberOfAliasFields), DueDiligence.Constants.EMPTY))
																																									#EXPAND(IF(numberOfAliasFields >= 9, DueDiligence.Common.getFieldProject(9, appendAliasName, numberOfAliasFields), DueDiligence.Constants.EMPTY))
																																									#EXPAND(IF(numberOfAliasFields >= 10, DueDiligence.Common.getFieldProject(10, appendAliasName, numberOfAliasFields), DueDiligence.Constants.EMPTY))
																																									
																																									SELF := LEFT;));	
																			
		#end


		RETURN updatedData;										
	ENDMACRO;


	//Currently this method will only take up to 10 date fields passed in
	//Dates MUST be in a comma delimited list
	//Has not been tested/coded for dates on child datasets
	//If date field does not exist on datasetToCheck, or misspelled, will error because cannot remove non-existing field
	EXPORT CleanDatasetDateFields(datasetToCheck, dateFields) := FUNCTIONMACRO
			
		getNames(CONST STRING previousNames, CONST STRING dateFieldName, BOOLEAN returnAlias) := FUNCTION
				periodLocation := STD.Str.Find(dateFieldName, '.', 1);
				alias := dateFieldName[..periodLocation-1] + ',';
				
				name := MAP(dateFieldName = DueDiligence.Constants.EMPTY => DueDiligence.Constants.EMPTY,
																periodLocation = DueDiligence.Constants.NUMERIC_ZERO => IF(returnAlias, DueDiligence.Constants.EMPTY, dateFieldName + ','),
																returnAlias AND STD.Str.Find(previousNames, alias, 1) = DueDiligence.Constants.NUMERIC_ZERO => alias,
																DueDiligence.Constants.EMPTY);

				RETURN previousNames + name;
		END;
		
		//clear all potential spaces - field names should not contain spaces
		trimFields := TRIM(dateFields, ALL);

		numberOfDateFields := STD.Str.CountWords(trimFields, ',');

		//grab all fields from the list passed in
		dateField1 := DueDiligence.Common.getNameFromList(1, trimFields, numberOfDateFields); 
		dateField2 := DueDiligence.Common.getNameFromList(2, trimFields, numberOfDateFields);
		dateField3 := DueDiligence.Common.getNameFromList(3, trimFields, numberOfDateFields);
		dateField4 := DueDiligence.Common.getNameFromList(4, trimFields, numberOfDateFields);
		dateField5 := DueDiligence.Common.getNameFromList(5, trimFields, numberOfDateFields);
		dateField6 := DueDiligence.Common.getNameFromList(6, trimFields, numberOfDateFields);
		dateField7 := DueDiligence.Common.getNameFromList(7, trimFields, numberOfDateFields);
		dateField8 := DueDiligence.Common.getNameFromList(8, trimFields, numberOfDateFields);
		dateField9 := DueDiligence.Common.getNameFromList(9, trimFields, numberOfDateFields);
		dateField10 := DueDiligence.Common.getNameFromList(10, trimFields, numberOfDateFields);

		//Only returns top level field names to be removed (those without any periods)
		topLevelField1 := getNames(DueDiligence.Constants.EMPTY, dateField1, FALSE);
		topLevelField2 := getNames(topLevelField1, dateField2, FALSE);
		topLevelField3 := getNames(topLevelField2, dateField3, FALSE);
		topLevelField4 := getNames(topLevelField3, dateField4, FALSE);
		topLevelField5 := getNames(topLevelField4, dateField5, FALSE);
		topLevelField6 := getNames(topLevelField5, dateField6, FALSE);
		topLevelField7 := getNames(topLevelField6, dateField7, FALSE);
		topLevelField8 := getNames(topLevelField7, dateField8, FALSE);
		topLevelField9 := getNames(topLevelField8, dateField9, FALSE);
		topLevelField10 := getNames(topLevelField9, dateField10, FALSE);
													
		topLevelFieldList := DueDiligence.Common.getFinalList(topLevelField10);
		numberOfTopLevelFields := STD.Str.CountWords(topLevelFieldList, ',');
		
		removeTopLevelFields := STD.Str.FindReplace(topLevelFieldList, ',', ' -');											
		readdTopLevelFields := STD.Str.FindReplace(topLevelFieldList, ',', ', UNSIGNED4 ');		
		
		//only returns unique nested structure alias names
		aliasName1 := getNames(DueDiligence.Constants.EMPTY, dateField1, TRUE);
		aliasName2 := getNames(aliasName1, dateField2, TRUE);
		aliasName3 := getNames(aliasName2, dateField3, TRUE);
		aliasName4 := getNames(aliasName3, dateField4, TRUE);
		aliasName5 := getNames(aliasName4, dateField5, TRUE);
		aliasName6 := getNames(aliasName5, dateField6, TRUE);
		aliasName7 := getNames(aliasName6, dateField7, TRUE);
		aliasName8 := getNames(aliasName7, dateField8, TRUE);
		aliasName9 := getNames(aliasName8, dateField9, TRUE);
		aliasName10 := getNames(aliasName9, dateField10, TRUE);
			
		aliasNameList := DueDiligence.Common.getFinalList(aliasName10);
		numberOfAlias := STD.Str.CountWords(aliasNameList, ',');

		//update layouts of any nested structures
		aliasLayout1 := DueDiligence.Common.updateNestedLayout(datasetToCheck, DueDiligence.Common.getNameFromList(1, aliasNameList, numberOfAlias));
		aliasLayout2 := DueDiligence.Common.updateNestedLayout(aliasLayout1, DueDiligence.Common.getNameFromList(2, aliasNameList, numberOfAlias));
		aliasLayout3 := DueDiligence.Common.updateNestedLayout(aliasLayout2, DueDiligence.Common.getNameFromList(3, aliasNameList, numberOfAlias));
		aliasLayout4 := DueDiligence.Common.updateNestedLayout(aliasLayout3, DueDiligence.Common.getNameFromList(4, aliasNameList, numberOfAlias));
		aliasLayout5 := DueDiligence.Common.updateNestedLayout(aliasLayout4, DueDiligence.Common.getNameFromList(5, aliasNameList, numberOfAlias));
		aliasLayout6 := DueDiligence.Common.updateNestedLayout(aliasLayout5, DueDiligence.Common.getNameFromList(6, aliasNameList, numberOfAlias));
		aliasLayout7 := DueDiligence.Common.updateNestedLayout(aliasLayout6, DueDiligence.Common.getNameFromList(7, aliasNameList, numberOfAlias));
		aliasLayout8 := DueDiligence.Common.updateNestedLayout(aliasLayout7, DueDiligence.Common.getNameFromList(8, aliasNameList, numberOfAlias));
		aliasLayout9 := DueDiligence.Common.updateNestedLayout(aliasLayout8, DueDiligence.Common.getNameFromList(9, aliasNameList, numberOfAlias));
		aliasLayout10 := DueDiligence.Common.updateNestedLayout(aliasLayout9, DueDiligence.Common.getNameFromList(10, aliasNameList, numberOfAlias));

		
		// Make sure that the date fields can hold an 8 character field returned from checkInvalidDate
		newLayout := RECORD
			 RECORDOF(aliasLayout10) #EXPAND(IF(topLevelFieldList = DueDiligence.Constants.EMPTY, 
																						DueDiligence.Constants.EMPTY, 
																						'-#EXPAND(removeTopLevelFields)'));
		END;
		
		finalTopLevelLayout := RECORD
			RECORDOF(newLayout) #EXPAND(IF(topLevelFieldList = DueDiligence.Constants.EMPTY, 
																				DueDiligence.Constants.EMPTY, 
																				'; UNSIGNED4 #EXPAND(readdTopLevelFields)'));
		END;
		
		updatedDS := PROJECT(aliasLayout10, TRANSFORM(finalTopLevelLayout, 

																																																#EXPAND(IF(numberOfTopLevelFields >= 1, DueDiligence.Common.getFieldProject(1, topLevelFieldList, numberOfTopLevelFields), DueDiligence.Constants.EMPTY))
																																																#EXPAND(IF(numberOfTopLevelFields >= 2, DueDiligence.Common.getFieldProject(2, topLevelFieldList, numberOfTopLevelFields), DueDiligence.Constants.EMPTY))
																																																#EXPAND(IF(numberOfTopLevelFields >= 3, DueDiligence.Common.getFieldProject(3, topLevelFieldList, numberOfTopLevelFields), DueDiligence.Constants.EMPTY))
																																																#EXPAND(IF(numberOfTopLevelFields >= 4, DueDiligence.Common.getFieldProject(4, topLevelFieldList, numberOfTopLevelFields), DueDiligence.Constants.EMPTY))
																																																#EXPAND(IF(numberOfTopLevelFields >= 5, DueDiligence.Common.getFieldProject(5, topLevelFieldList, numberOfTopLevelFields), DueDiligence.Constants.EMPTY))
																																																#EXPAND(IF(numberOfTopLevelFields >= 6, DueDiligence.Common.getFieldProject(6, topLevelFieldList, numberOfTopLevelFields), DueDiligence.Constants.EMPTY))
																																																#EXPAND(IF(numberOfTopLevelFields >= 7, DueDiligence.Common.getFieldProject(7, topLevelFieldList, numberOfTopLevelFields), DueDiligence.Constants.EMPTY))
																																																#EXPAND(IF(numberOfTopLevelFields >= 8, DueDiligence.Common.getFieldProject(8, topLevelFieldList, numberOfTopLevelFields), DueDiligence.Constants.EMPTY))
																																																#EXPAND(IF(numberOfTopLevelFields >= 9, DueDiligence.Common.getFieldProject(9, topLevelFieldList, numberOfTopLevelFields), DueDiligence.Constants.EMPTY))
																																																#EXPAND(IF(numberOfTopLevelFields >= 10, DueDiligence.Common.getFieldProject(10, topLevelFieldList, numberOfTopLevelFields), DueDiligence.Constants.EMPTY))

																																																SELF := LEFT;));

		RETURN updatedDS;
	ENDMACRO;
		
	
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
		
		//filter by dateFirstSeenField if populated, if not then use the secondaryDateFirstSeenField
		filtered := dataSetToFilter((HistoryDate = DueDiligence.Constants.date8Nines AND DueDiligence.Common.fn_filterOnCurrentMode((INTEGER)dateFirstSeenField))
															OR DueDiligence.Common.fn_filterOnArchiveDate((INTEGER)dateFirstSeenField, historyDate));
		
		RETURN filtered;
		
	ENDMACRO;	
	
	//copied/modified from 	Business_Risk_BIP.Common.FilterRecords - used with 2 dates to filter
	EXPORT FilterRecords(dataSetToFilter, dateFirstSeenField, secondaryDateFirstSeenField) := FUNCTIONMACRO

		//filter by dateFirstSeenField if populated, if not then use the secondaryDateFirstSeenField
		filtered := dataSetToFilter(IF((INTEGER)dateFirstSeenField > 0, 
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
	
	// ------                                                       ----
	// ------  Use this to get a valid date based on the history    ----
	// ------   date.  If the history date is all 9's use the       ----
	// ------   ELSE use the history date passed into the function  ----
  EXPORT GetMyDate(unsigned4 history_date)                 := FUNCTION
	   /* today_date will be in YYYYMMDD format */  
	   unsigned4 todays_date               := STD.Date.Today();
	   unsigned4 returnDateToUse := IF(history_date = DueDiligence.Constants.date8Nines,
																																				todays_date,
																																				history_date);
	
	   RETURN returnDateToUse; 
	
	END;
	
	
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

	EXPORT getAddressScore(STRING prim_range1, STRING prim_name1, STRING sec_range1, STRING prim_range2, STRING prim_name2, STRING sec_range2) := FUNCTION
		score := Risk_Indicators.AddrScore.AddressScore(prim_range1, prim_name1, sec_range1, prim_range2, prim_name2, sec_range2);
	
		RETURN score;
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
								]                                                                     => DueDiligence.Constants.LIEN,
																																												 DueDiligence.Constants.LIEN); // default
						
		RETURN judgment_type_category;
	END;

  EXPORT getFilingStatusCategory( STRING filing_status) := FUNCTION

		filing_status_category :=    
			MAP(
							filing_status IN DueDiligence.Constants.filing_status_satisfied => DueDiligence.Constants.SATISFIED,
							filing_status IN DueDiligence.Constants.filing_status_dismissed => DueDiligence.Constants.DISMISS,
							filing_status  = DueDiligence.Constants.UNLAPSED_UPPER          => DueDiligence.Constants.UNLAPSED_LOWER,
							filing_status  = DueDiligence.Constants.LAPSED_UPPER            => DueDiligence.Constants.LAPSED_LOWER,
							filing_status NOT IN
								[
										DueDiligence.Constants.filing_status_satisfied 
									+ DueDiligence.Constants.filing_status_dismissed 
									+ [  DueDiligence.Constants.UNLAPSED_UPPER, 
											 DueDiligence.Constants.LAPSED_UPPER ]
								]                                                             => DueDiligence.Constants.OTHER_LOWER,
																																								 DueDiligence.Constants.EMPTY);   // default
		RETURN filing_status_category; 
  END;

	
	
  EXPORT LookAtOther(STRING5 courtOffenseLevel, STRING75 charge, string40 courtDispDesc1, string40 courtDispDesc2, string35 arr_off_lev_mapped, 	string35 court_off_lev_mapped) := FUNCTION
		
		//***Does the field "courtOffenseLevel" map to any of the listed FELONY or MISDEMEANOR codes***// 
		boolean MapsToFelony         := STD.Str.ToUpperCase(TRIM(courtOffenseLevel, LEFT, RIGHT)) IN DueDiligence.Constants.setFELONY; 
		boolean MapsToMisdemeanor    := STD.Str.ToUpperCase(TRIM(courtOffenseLevel, LEFT, RIGHT)) IN DueDiligence.Constants.setMISDEMEANOR;
		
		//***Can we find the keyword 'FELONY' in the field "charge" ***// 
		STRING  TextStringConcatenated   := charge + courtDispDesc1 + courtDispDesc2 + arr_off_lev_mapped + court_off_lev_mapped;   
		boolean foundTheWordFelony       := (boolean)STD.Str.Find(STD.Str.ToUpperCase(TextStringConcatenated), DueDiligence.Constants.KEYWORD_FELONY, 1);
		boolean foundTheWordReduced      := (boolean)STD.Str.Find(STD.Str.ToUpperCase(TextStringConcatenated), DueDiligence.Constants.KEYWORD_REDUCED, 1);
		
		ReturnValue      := MAP(
		                        MapsToFelony => DueDiligence.Constants.FELONY,
														MapsToMisdemeanor => DueDiligence.Constants.MISDEMEANOR,    
														foundTheWordFelony AND ~foundTheWordReduced  => DueDiligence.Constants.FELONY,             
		                        DueDiligence.Constants.UNKNOWN);
		
		RETURN ReturnValue;
	END;	
	

  // ------                                                                                -----
  // ------   THIS FUNCTION IS EXPECTING THE 3 DIGIT FIPS CODE TO BE POPULATED             -----
	// ------   IT NEEDS BOTH THE 3 DIGIT FIPS AND THE 5 DIGIT FIPS CODE                     -----
	// ------   The FIPS county code is a five-digit Federal Information Processing          -----
	// ------   Standards (FIPS) code (FIPS 6-4) which uniquely identifies counties and      -----
	// ------   county equivalents in the United States,                                     -----

	EXPORT getGeographicRisk(DATASET(DueDiligence.layoutsInternal.GeographicLayout) AddressList) := FUNCTION
											      
  // ------                                                                                     ------
	// ------ Pick up the EasiTotCrime this state and county and geo blk                          ------  
	// ------ from the Census Keys.  The address cleaner picked up the county put into the        ------
	// ------ Busn_info.address of the Busn_Internal layout.                                      ------
	// ------   This FUNCTION is expecting the 3 digits county to build the geolink               ------
	// ------   Build the 5 digit FIPS code using the state code + county                         ------
	// ------   Use the 5 digit FIPS code to determine if the county area matches the lists       ------
	// ------   created in the duediligence.constants                                             ------
	// ------   SPRINT9                                                                           ------
	// ------ Note:  The Easi - if we cannot find any Census data for this geographic location    ------
	// ------        per our requirements the "not found" condition will produce the same result  ------
	// ------        a low to average crime index                                                 ------
	
 withGeographicRisk := join(AddressList, Easi.Key_Easi_Census,
		keyed(right.geolink = left.state + left.county + left.geo_blk),
		transform(DueDiligence.layoutsInternal.GeographicLayout, 
		        /*  Set all of the County/State area risk indicators   */
		        self.EasiTotCrime             := right.totcrime;
            /*  So we should have something populated in the buildgeolink even when we don't find a match on the census file */  
						self.buildgeolink             := left.state + left.county + left.geo_blk;
						integer tempCrimeValue        := (integer)right.totcrime;   
					  self.CountyHasHighCrimeIndex  := tempCrimeValue >= DueDiligence.Constants.HighCrimeValue;
						STRING5 tempFIPS               := codes.st2FipsCode(StringLib.StringToUpperCase(left.state)) + left.county;
            SELF.FipsCode                  := tempFIPS;  
			      SELF.HIFCA                     := IF(tempFIPS IN DueDiligence.Constants.setHIFCA,1,0);
			      SELF.HIDTA                     := IF(tempFIPS IN DueDiligence.Constants.setHIDTA,1,0);
				    SELF.CountyBordersForgeinJur   := IF(tempFIPS IN DueDiligence.Constants.CountyForeignJurisdic,1,0);   
				    SELF.CountyBorderOceanForgJur  := IF(tempFIPS IN DueDiligence.Constants.CountyBordersOceanForgJur,1,0);
				     /*  Set all of the City/State area risk indicators   */  
				    SELF.CityState                 := TRIM(left.city, LEFT, RIGHT) + ','+ left.state; 
				    tempCityState                  := TRIM(left.city, LEFT, RIGHT) + ','+ left.state;
				    self.CityBorderStation         := tempCityState in DueDiligence.Constants.CityBorderStation;
				    self.CityFerryCrossing         := tempCityState in DueDiligence.Constants.CityFerryCrossing; 
				    self.CityRailStation           := tempCityState in DueDiligence.Constants.CityRailStation; 
						self.CountyName                := 'X';   
					   /* populate the remaining business internal record with data from the left  */ 
						self                          := left;), left outer,
		ATMOST
		    (keyed(right.geolink = left.state + left.county + left.geo_blk), 
				 DueDiligence.Constants.MAX_ATMOST), KEEP(1));
  
  // ------                                                                                                              ------
  // ------ Use the Census Macro to fill in the county_name - pass the result set as input,                              ------
  // ------ the field name that contains the state,                                                                      ------ 
  // ------ the field name that contains the 3 digit fips(county) and the field name of the county name.                 ------
  // ------ the name of the output result set                                                                            ------
  // ------                                                                                                              ------
	Census_Data.MAC_Fips2County_Keyed(withGeographicRisk, state, Fipscode, countyName, WithGeoRiskCounty);
  
  
  
		RETURN WithGeoRiskCounty;
	END;   //*** END OF FUNCTION
  
	
	EXPORT getRelatedPartyOffenses(DATASET(DueDiligence.LayoutsInternal.RelatedParty) relatedParty) := FUNCTION
		
		execOffenses := NORMALIZE(relatedParty, LEFT.party.partyOffenses, TRANSFORM(DueDiligence.LayoutsInternal.CriminalOffenses,
																																								SELF.ultID := LEFT.UltID;
																																								SELF.orgID := LEFT.OrgID;
																																								SELF.seleID := LEFT.SeleID;
																																								SELF.offense := RIGHT;
																																								SELF := LEFT;
																																								SELF := [];));	
																													
		RETURN execOffenses;
	END;   //*** END OF FUNCTION
  
  // ------                                                                                              ------ 
  // ------ Convert the 1 character offense score to a description to be used for the report             ------
  // ------                                                                                              ------
  EXPORT getOffenseScoreDescription(STRING1 offensescore) := FUNCTION

		returnOffenseScoreDescription :=    
				 MAP(
							offenseScore = DueDiligence.Constants.FELONY                          	=> DueDiligence.Constants.TEXT_FELONY,      
							offenseScore = DueDiligence.Constants.MISDEMEANOR                       => DueDiligence.Constants.TEXT_MISDEMEANOR,
							offenseScore = DueDiligence.Constants.INFRACTION                        => DueDiligence.Constants.TEXT_INFRACTION,
							offenseScore = DueDiligence.Constants.TRAFFIC                           => DueDiligence.Constants.TEXT_TRAFFIC,
							offenseScore = DueDiligence.Constants.UNKNOWN                           => DueDiligence.Constants.TEXT_UNKNOWN,																		
                                                                                         DueDiligence.Constants.TEXT_UNKNOWN); // default
						
		RETURN returnOffenseScoreDescription;
	END;    //*** END OF FUNCTION
	
  // ------                                                                                              ------ 
  // ------ Convert the 1 character offender level to a description to be used for the report            ------
  // ------                                                                                              ------
  EXPORT getOffenseLevelDescription(STRING1 criminalOffenderLevel) := FUNCTION

		returnOffenseLevelDescription :=    
				 MAP(
							criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED     => DueDiligence.Constants.TEXT_NONTRAFFIC_CONVICTED,      
							criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED => DueDiligence.Constants.TEXT_NONTRAFFIC_NOT_CONVICTED,
							criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_CONVICTED        => DueDiligence.Constants.TEXT_TRAFFIC_CONVICTED,
							criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_NOT_CONVICTED    => DueDiligence.Constants.TEXT_TRAFFIC_NOT_CONVICTED,
                                                                                         DueDiligence.Constants.TEXT_UNKNOWN); // default
						
		RETURN returnOffenseLevelDescription;
	END;    //*** END OF FUNCTION 
  
  
  EXPORT RollFlags(fieldName) := FUNCTIONMACRO
    rollMe := IF(LEFT.fieldName[1] = DueDiligence.Constants.T_INDICATOR OR 
                 RIGHT.fieldName[1] = DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR) +
              IF(LEFT.fieldName[2] = DueDiligence.Constants.T_INDICATOR OR 
                 RIGHT.fieldName[2] = DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR) +
              IF(LEFT.fieldName[3] = DueDiligence.Constants.T_INDICATOR OR 
                 RIGHT.fieldName[3] = DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR) +
              IF(LEFT.fieldName[4] = DueDiligence.Constants.T_INDICATOR OR 
                 RIGHT.fieldName[4] = DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR) +
              IF(LEFT.fieldName[5] = DueDiligence.Constants.T_INDICATOR OR 
                 RIGHT.fieldName[5] = DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR) +
              IF(LEFT.fieldName[6] = DueDiligence.Constants.T_INDICATOR OR 
                 RIGHT.fieldName[6] = DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR) +
              IF(LEFT.fieldName[7] = DueDiligence.Constants.T_INDICATOR OR 
                 RIGHT.fieldName[7] = DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR) +
              IF(LEFT.fieldName[8] = DueDiligence.Constants.T_INDICATOR OR 
                 RIGHT.fieldName[8] = DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR) +
              IF(LEFT.fieldName[9] = DueDiligence.Constants.T_INDICATOR OR 
                 RIGHT.fieldName[9] = DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR) +
              IF(LEFT.fieldName[10] = DueDiligence.Constants.T_INDICATOR OR 
                 RIGHT.fieldName[10] = DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);

     RETURN rollMe;
  ENDMACRO;
  
END;