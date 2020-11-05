IMPORT codes, DueDiligence, Easi, Census_Data, iesp, Risk_Indicators, STD, ut;


EXPORT Common := MODULE

    EXPORT firstPopulatedString(field) := FUNCTIONMACRO
      RETURN IF(TRIM(LEFT.field) = DueDiligence.Constants.EMPTY, RIGHT.field, LEFT.field);
    ENDMACRO : DEPRECATED('Use DueDiligence.v3Common.General.firstPopulatedString');
  
    EXPORT firstNonZeroNumber(field) := FUNCTIONMACRO
      //so negative numbers would also be returned (ie -1)
      RETURN IF(LEFT.field = DueDiligence.Constants.NUMERIC_ZERO, RIGHT.field, LEFT.field);
    ENDMACRO : DEPRECATED('Use DueDiligence.v3Common.General.firstNonZeroNumber');

    EXPORT createNVPair(STRING name, STRING val) := FUNCTION
      iesp.share.t_NameValuePair createPair(STRING n, STRING v) := TRANSFORM
        SELF.Name := n;
        SELF.Value := v;
      END;

      RETURN ROW(createPair(name, val));			
    END;
    
    EXPORT createNVPairIntegerValue(STRING name, INTEGER val) := FUNCTION
      
      iesp.share.t_NameValuePair createPair(STRING n, INTEGER v) := TRANSFORM
        SELF.Name := n;
        SELF.Value := (STRING)v;
      END;

      RETURN ROW(createPair(name, val));			
  END;
	
    EXPORT calcFinalFlagField(STRING1 flag9, STRING1 flag8, STRING1 flag7, STRING1 flag6, STRING1 flag5, STRING1 flag4, STRING1 flag3, STRING1 flag2, STRING1 flag1) := FUNCTION
       
       concatFlags := flag9 + flag8 + flag7 + flag6 + flag5 + flag4 + flag3 + flag2 + flag1;
                                              
       calcFlag_0 := IF(STD.Str.Find(concatFlags, DueDiligence.Constants.T_INDICATOR, 1) = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);     
       cancatFinalFlag := concatFlags + calcFlag_0; 
       
       RETURN cancatFinalFlag;
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
      IMPORT STD;
        
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


    SHARED IsValidDate(UNSIGNED date, BOOLEAN yearOnly = FALSE) := FUNCTION
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
		
    

    EXPORT getLinkedBusinesses(DATASET(DueDiligence.Layouts.Busn_Internal) inquiredBus) := FUNCTION

      lnkedBus := NORMALIZE(inquiredBus, LEFT.linkedBusinesses, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                                                          SELF.seq := LEFT.seq;
                                                                          SELF.historydate := LEFT.historydate;
                                                                          SELF.busn_info := RIGHT;
                                                                          SELF.relatedDegree := DueDiligence.Constants.LINKED_BUSINESS_DEGREE;
                                                                          SELF := [];));

      RETURN lnkedBus;
    END; 



    EXPORT LookAtOther(STRING1 offenseScore, STRING5 courtOffenseLevel, STRING75 charge, STRING40 courtDispDesc1, STRING40 courtDispDesc2, STRING35 offenseChargeLevelReported, STRING1 trafficFlag) := FUNCTION
      
      //Does the field "courtOffenseLevel" map to any of the listed FELONY, MISDEMEANOR, TRAFFIC, or INFRACCTION codes 
      BOOLEAN MapsToFelony := STD.Str.ToUpperCase(TRIM(courtOffenseLevel, LEFT, RIGHT)) IN DueDiligence.ConstantsLegal.SET_FELONY; 
      BOOLEAN MapsToMisdemeanor := STD.Str.ToUpperCase(TRIM(courtOffenseLevel, LEFT, RIGHT)) IN DueDiligence.ConstantsLegal.SET_MISDEMEANOR;
      BOOLEAN MapsToTraffic := STD.Str.ToUpperCase(TRIM(courtOffenseLevel, LEFT, RIGHT)) IN DueDiligence.ConstantsLegal.SET_TRAFFIC;
      BOOLEAN MapsToInfraction := STD.Str.ToUpperCase(TRIM(courtOffenseLevel, LEFT, RIGHT)) IN DueDiligence.ConstantsLegal.SET_INFRACTION;
      
      //check to see if we can find key words
      STRING  TextStringConcatenated := charge + courtDispDesc1 + courtDispDesc2 + offenseChargeLevelReported;  
      
      BOOLEAN foundFelonyKeyWord := IF(REGEXFIND(DueDiligence.RegularExpressions.FELONY_NOT_REDUCED, TextStringConcatenated, NOCASE), TRUE, FALSE);
      BOOLEAN foundMisdemeanorKeyWord := IF(REGEXFIND(DueDiligence.RegularExpressions.SPECIFIC_KEYWORD_MISDEMEANOR, TextStringConcatenated, NOCASE), TRUE, FALSE);
      BOOLEAN foundTrafficKeyWord := IF(REGEXFIND(DueDiligence.RegularExpressions.SPECIFIC_KEYWORD_TRAFFIC, TextStringConcatenated, NOCASE), TRUE, FALSE);
      BOOLEAN foundInfractionKeyWord := IF(REGEXFIND(DueDiligence.RegularExpressions.SPECIFIC_KEYWORD_INFRACTION, TextStringConcatenated, NOCASE), TRUE, FALSE);
      
      
      
      waterfallValue  := MAP(MapsToFelony => DueDiligence.ConstantsLegal.FELONY,
                          foundFelonyKeyWord => DueDiligence.ConstantsLegal.FELONY,
                          MapsToMisdemeanor => DueDiligence.ConstantsLegal.MISDEMEANOR,    
                          MapsToTraffic => DueDiligence.ConstantsLegal.TRAFFIC,
                          MapsToInfraction => DueDiligence.ConstantsLegal.INFRACTION,
                          trafficFlag = DueDiligence.Constants.YES => DueDiligence.ConstantsLegal.TRAFFIC,
                          foundMisdemeanorKeyWord => DueDiligence.ConstantsLegal.MISDEMEANOR,
                          foundTrafficKeyWord => DueDiligence.ConstantsLegal.TRAFFIC,
                          foundInfractionKeyWord => DueDiligence.ConstantsLegal.INFRACTION,
                          DueDiligence.Constants.UNKNOWN);
                          
      returnValue := MAP(waterfallValue = DueDiligence.ConstantsLegal.FELONY OR offenseScore = DueDiligence.ConstantsLegal.FELONY => DueDiligence.ConstantsLegal.FELONY,
                          waterfallValue = DueDiligence.ConstantsLegal.MISDEMEANOR OR offenseScore = DueDiligence.ConstantsLegal.MISDEMEANOR => DueDiligence.ConstantsLegal.MISDEMEANOR,
                          waterfallValue = DueDiligence.ConstantsLegal.TRAFFIC OR offenseScore = DueDiligence.ConstantsLegal.TRAFFIC => DueDiligence.ConstantsLegal.TRAFFIC,
                          waterfallValue = DueDiligence.ConstantsLegal.INFRACTION OR offenseScore = DueDiligence.ConstantsLegal.INFRACTION => DueDiligence.ConstantsLegal.TRAFFIC,
                          DueDiligence.Constants.UNKNOWN);

      
      RETURN returnValue;
    END;	



                              
    EXPORT getGeographicRisk(DATASET(DueDiligence.layoutsInternal.GeographicLayout) AddressList, BOOLEAN TheseAddressesNeedToBeCleaned = FALSE) := FUNCTION
      RETURN DueDiligence.CommonAddress.getAddressRisk(AddressList, TheseAddressesNeedToBeCleaned);
    END : DEPRECATED('Use DueDiligence.CommonAddress.getAddressRisk');


    EXPORT getRelatedPartyOffenses(DATASET(DueDiligence.LayoutsInternal.RelatedParty) relatedParty) := FUNCTION
      
      execOffenses := NORMALIZE(relatedParty, LEFT.party.indOffenses, TRANSFORM(DueDiligence.LayoutsInternal.CriminalOffenses,
                                                                                  SELF.ultID := LEFT.UltID;
                                                                                  SELF.orgID := LEFT.OrgID;
                                                                                  SELF.seleID := LEFT.SeleID;
                                                                                  SELF.offense := RIGHT;
                                                                                  SELF := LEFT;
                                                                                  SELF := [];));	
                                                            
      RETURN execOffenses;
    END;   //*** END OF FUNCTION




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

    //dsToLimit, should already come in sorted and grouped so counter can keep groups sequential
    EXPORT GetMaxRecords(dsToLimit, maxRecords) := FUNCTIONMACRO
      
      RECORDOF(dsToLimit) getMaxRecs(dsToLimit dtl, INTEGER maxCounter) := TRANSFORM, SKIP(maxCounter > maxRecords) 
        SELF := dtl;
      END;
      
      maxedRecords := PROJECT(dsToLimit, getMaxRecs(LEFT, COUNTER));
      
      RETURN UNGROUP(maxedRecords);
    ENDMACRO;
    
    
    EXPORT GetSourceDetailsAsDataset(STRING sources, STRING sourceCounts, STRING sourceFirstSeens, STRING sourceLastSeens) := FUNCTION

        splitSources := STD.Str.SplitWords(sources, ',');
        splitSourceCnts := STD.Str.SplitWords(sourceCounts, ',');
        splitSourceFSeen := STD.Str.SplitWords(sourceFirstSeens, ',');
        splitSourceLSeen := STD.Str.SplitWords(sourceLastSeens, ',');

        sourceDetails := DATASET(COUNT(splitSources), TRANSFORM(DueDiligence.Layouts.SourceDetailsLayout, 
                                                                SELF.source := STD.Str.CleanSpaces(splitSources[COUNTER]);
                                                                SELF.sourceCount := (UNSIGNED)STD.Str.CleanSpaces(splitSourceCnts[COUNTER]);
                                                                SELF.sourceFirstSeen := (UNSIGNED)STD.Str.CleanSpaces(splitSourceFSeen[COUNTER]);
                                                                SELF.sourceLastSeen := (UNSIGNED)STD.Str.CleanSpaces(splitSourceLSeen[COUNTER]);)); 

        RETURN sourceDetails;
    END;
    
    
    EXPORT GetStringListAsDataset(STRING listOfData) := FUNCTION

        splitInfo := STD.Str.SplitWords(listOfData, ',');

        listAsDataset := DATASET(COUNT(splitInfo), TRANSFORM({STRING info}, SELF.info := STD.Str.CleanSpaces(splitInfo[COUNTER]);)); 

        RETURN listAsDataset;
    END;




END;