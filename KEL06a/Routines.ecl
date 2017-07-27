IMPORT KEL06a AS KEL;
IMPORT STD;
IMPORT * FROM KEL06a.Null;
EXPORT Routines := MODULE
//============================================================================================
//      Annotations
    EXPORT BuildRecord(din, fieldList, parm) := FUNCTIONMACRO
        // Build a partial record definition based on the given dataset and the given list of fields
        // parm=NOQUAL means don't put the dataset name as a qualifier to the field names
        // [when you get an error at the #EXPAND, remember that this guys carries the comma]
      #IF(fieldList)
          LoadXml('<xml/>');
          #DECLARE(newFields) #SET(newFields, '')
          #EXPORTXML(fields, RECORDOF(din))
          #FOR(fields)
            #FOR(field)
              #IF(REGEXFIND(','+%'@label'%+',', ','+fieldList+',',NOCASE))
                #IF(%'newFields'%)
                  #APPEND(newFields, ',')
                #END
                #IF(#TEXT(parm) != 'NOQUAL')
                  #APPEND(newFields, #TEXT(dIn)+'.')
                #END
                #APPEND(newFields, %'@label'%)
              #END
            #END
          #END
          //#ERROR(%'newFields'%)
          #IF(#TEXT(parm) != 'NOSEP')
            #APPEND(newFields, ',')
          #END
          RETURN %'newFields'%;
      #ELSE
          RETURN '';
      #END
    ENDMACRO;
    EXPORT BuildClear(din, groups, fieldin) := FUNCTIONMACRO
    // build assignments using the __CLEAN macro to clear un-needed flags
      LoadXml('<xml/>');
      #DECLARE(newFields) #SET(newFields, '')
        #IF(groups)
          #EXPORTXML(fields, RECORDOF(din))
          #FOR(fields)
            #FOR(field)
              #IF(REGEXFIND(','+%'@label'%+',', ','+groups+',',NOCASE))
                #IF(%'newFields'% != '')
                  #APPEND(newFields, ';');
                #END
                #APPEND(newFields, 'SELF.'+%'@label'%+':=__CLEAN(LEFT.'+%'@label'%+')')
              #END
            #END
          #END
      #END
      #IF(#TEXT(fieldin) != '\'\'')
        #IF(%'newFields'% != '')
            #APPEND(newFields, ';')
        #END
    #APPEND(newFields, 'SELF.'+#TEXT(fieldin)+':=__CLEAN(LEFT.'+#TEXT(fieldin)+')')
      #END
    //#ERROR(%'newFields'%)
    RETURN %'newFields'%;
    ENDMACRO;
    EXPORT BuildJoin(din, groups, fieldin, lastcon) := FUNCTIONMACRO
      // Build a join condition for the group
      // all members of groups, ANDed; if fieldin not blank, it ANDed; if the result not blank, add lastcon
      LoadXml('<xml/>');
      #DECLARE(newFields) #SET(newFields, '')
        #IF(groups)
          #EXPORTXML(fields, RECORDOF(din))
          #FOR(fields)
            #FOR(field)
              #IF(REGEXFIND(','+%'@label'%+',', ','+groups+',',NOCASE))
                #IF(%'newFields'% != '')
                  #APPEND(newFields, ' AND ');
                #END
                #APPEND(newFields, '__EEQP(LEFT.'+%'@label'%+',RIGHT.'+%'@label'%+')')
              #END
            #END
          #END
      #END
    #IF(#TEXT(fieldin) != '\'\'')
      #IF(%'newFields'% != '')
        #APPEND(newFields, ' AND ')
      #END
      #APPEND(newFields, '__EEQP(LEFT.' + #TEXT(fieldin) + ',RIGHT.' + #TEXT(fieldin) + ')')
    #END
    #IF(%'newFields'% != '')
      #APPEND(newFields, lastcon)
    #END
    //#ERROR(%'newFields'%)
    RETURN %'newFields'%;
    ENDMACRO;
    EXPORT BuildSort(din, groups, fieldin, oncard, up) := FUNCTIONMACRO
    // Build the 'value' part of a sort command
      LoadXml('<xml/>');
      #DECLARE(outStr) #SET(outStr, '')
        #IF(groups)
          #EXPORTXML(fields, RECORDOF(din))
          #FOR(fields)
            #FOR(field)
              #IF(REGEXFIND(','+%'@label'%+',', ','+groups+',',NOCASE))
                  #IF(%'outStr'% != '')
                      #APPEND(outStr, ', ');
                  #END
                #APPEND(outStr, %'@label'%)
              #END
            #END
          #END
      #END
    #IF(%'outStr'% != '')
      #APPEND(outStr, ', ');
    #END
    #IF(#TEXT(oncard) = 'TRUE')
      #IF(#TEXT(up) = 'FALSE')
        #APPEND(outStr, '-')
      #END
      #APPEND(outStr, '__count')
    #ELSE
      #APPEND(outStr, '__NullStatusAsSort(' + #TEXT(fieldin) + '),')
      #IF(#TEXT(up) = 'FALSE')
        #APPEND(outStr, '-')
      #END
      #APPEND(outStr, '__T(' + #TEXT(fieldin) + ')')
    #END
    //#ERROR(%'outStr'%)
    RETURN(%'outStr'%);
    ENDMACRO;
    EXPORT BuildBreak(din, groups) := FUNCTIONMACRO
    // build a test for a change in one of the keys in 'groups' - return the string 'FALSE' if no groups
      LoadXml('<xml/>');
      #DECLARE(newFields) #SET(newFields, '')
        #IF(groups)
          #EXPORTXML(fields, RECORDOF(din))
          #FOR(fields)
            #FOR(field)
              #IF(REGEXFIND(','+%'@label'%+',', ','+groups+',',NOCASE))
                #IF(%'newFields'% != '')
                  #APPEND(newFields, ' AND ');
                #END
                #APPEND(newFields, 'NOT __EEQP(LEFT.'+%'@label'%+',RIGHT.'+%'@label'%+')')
              #END
            #END
          #END
      #END
      #IF(%'newFields'% = '')
          #SET(newFields, 'FALSE')
      #END
    //#ERROR(%'newFields'%)
    RETURN %'newFields'%;
    ENDMACRO;
  EXPORT KELcardinalityTable(din, groups, fieldin, fieldout, weighted) := FUNCTIONMACRO
  // build shared cardinality table -- note that the contents of .f have been partly cleared
    LOCAL __c1 := KEL.Routines.BuildClear(din, groups, fieldin);
    LOCAL __tdin := PROJECT(din, TRANSFORM(RECORDOF(din), #EXPAND(__c1); SELF := LEFT));
    LOCAL __m1 := KEL.Routines.BuildRecord(__tdin, groups, '');
    LOCAL __ctab := TABLE(__tdin,
                          { #EXPAND(__m1) fieldin, fieldout := 
                            #IF(#TEXT(weighted) = 'FALSE')
                              COUNT(GROUP) 
                            #ELSE
                              SUM(GROUP, __RecordCount)
                            #END		
                          },
                          #EXPAND(__m1) fieldin,
                          MERGE);
    RETURN __ctab;
    ENDMACRO;
  EXPORT KELmodeTable(din, groups, fieldin, weighted) := FUNCTIONMACRO
  // insert mode annotation
    LOCAL __ntab := din (__NN(fieldin));                                        // no NULLs
    LOCAL __ctab := KEL.Routines.KELcardinalityTable(__ntab, groups, fieldin, __count, weighted);
    LOCAL __tform := {RECORDOF(__ctab) AND NOT __count};
    // non-grouped: use MAX
    LOCAL __Smode := MAX(__ctab, __count);
    LOCAL __itab1 := PROJECT(__ctab (__count = __Smode), __tform);
    // grouped: use TABLE MAX
    LOCAL __m2 := KEL.Routines.BuildRecord(din, groups, NOQUAL);
    LOCAL __itab2a := TABLE(__ctab,
                            { #EXPAND(__m2) __mode:= MAX(GROUP, __count) },
                            #EXPAND(__m2)
                            MERGE);
    LOCAL __j1 := KEL.Routines.BuildJoin(din, groups, '', ' AND ');
    LOCAL __itab2b := JOIN(__ctab, __itab2a, #EXPAND(__j1) LEFT.__count=RIGHT.__mode,
                           TRANSFORM(__tform, SELF:=LEFT),
                           INNER, LOOKUP);
    // choose
    LOCAL __itab := IF (groups = '', __itab1, __itab2b);
    RETURN __itab;
  ENDMACRO;
  EXPORT KELrankOrdinal(din, groups, fieldin, fieldout, up) := FUNCTIONMACRO
      // we're not offering this one in KEL for now - too expensive and the sequence is too arbitrary
    // insert ordinal rank annotation [a,b,b,c -> 1,2,3,4]
    //TODO -- not correct; grouping sort needs to be on a __CLEAN() copy of each grouping field
    //        which means adding them to the record, then stripping them out after the iterate
    LOCAL __outform := { din, KEL.typ.nint fieldout := __N(KEL.typ.int) };
    LOCAL __s1 := KEL.Routines.BuildSort(din, groups, fieldin, FALSE, up);
    LOCAL __b1 := KEL.Routines.BuildBreak(din, groups);
    LOCAL __int := PROJECT(din, __outform);
    RETURN ITERATE(SORT(__int, #EXPAND(__s1), RECORD),          // RECORD is there to give stable results
                        TRANSFORM(__outform, SELF.fieldout :=
                                  IF(__NL(RIGHT.fieldin), __N(KEL.typ.int),
                                                          IF(#EXPAND(__b1), __CN(1), __CN(__T(LEFT.fieldout)+1)));
                                  SELF := RIGHT));
  ENDMACRO;
  EXPORT KELrankTableRaw(din, groups, fieldin, up, standard, modified, fractional, dense, weighted) := FUNCTIONMACRO
  // generate standard [a,b,b,c -> 1,2,2,4], modified [a,b,b,c -> 1,3,3,4], fractional [a,b,b,c -> 1,2.5,2.5,4]
  //      and/or dense [a,b,b,c -> 1,2,2,3] rank annotations
  // bonus: __count is cardinality, but no entry for NULL
    LOCAL __ntab := din (__NN(fieldin));                                        // no NULLs
    LOCAL __ctab := KEL.Routines.KELcardinalityTable(__ntab, groups, fieldin, __count, weighted);
    LOCAL __m1 := KEL.Routines.BuildRecord(din, groups, '');
    LOCAL __outform := { #EXPAND(__m1)  din.fieldin, INTEGER standard := 0, INTEGER modified := 0, REAL fractional := 0,
                                                     INTEGER dense := 0, INTEGER __count := 0 };
    LOCAL __it := PROJECT(__ctab, __outform);
    LOCAL __s1 := KEL.Routines.BuildSort(__it, groups, fieldin, FALSE, up);
    LOCAL __b1 := KEL.Routines.BuildBreak(__it, groups);
    LOCAL __ro := ITERATE(SORT(__it, #EXPAND(__s1)),
                          TRANSFORM(__outform, SELF.standard := IF(#EXPAND(__b1), 1, LEFT.modified + 1);
                                               SELF.modified := SELF.standard + RIGHT.__count - 1;
                                               SELF.fractional := (SELF.standard + SELF.modified) / 2;
                                               SELF.dense := IF(#EXPAND(__b1), 1, LEFT.dense + 1);
                                               SELF := RIGHT));
    RETURN __ro;
  ENDMACRO;
  EXPORT KELrankTable(din, groups, fieldin, up, standard, modified, fractional, dense, weighted) := FUNCTIONMACRO
    LOCAL __rtab := KEL.Routines.KELrankTableRaw(din, groups, fieldin, up, standard, modified, fractional, dense, weighted);
    LOCAL __m1 := KEL.Routines.BuildRecord(din, groups, '');
    LOCAL __outform := { #EXPAND(__m1)  din.fieldin, KEL.typ.nint standard, KEL.typ.nint modified, KEL.typ.nfloat fractional, KEL.typ.nint dense };
    LOCAL __ro := PROJECT(__rtab, TRANSFORM(__outform, SELF.standard := __CN(LEFT.standard), SELF.modified := __CN(LEFT.modified),
                                                       SELF.fractional := __CN(LEFT.fractional), SELF.dense := __CN(LEFT.dense),
                                                       SELF := LEFT));
    RETURN __ro;
  ENDMACRO;
  EXPORT KELbucketTableRaw(din, groups, fieldin, up, weighted) := FUNCTIONMACRO
    LOCAL __rtab := KEL.Routines.KELrankTableRaw(din, groups, fieldin, up, __stdrank, __modrank, __frarank, __denrank, weighted);
    LOCAL __m2 := KEL.Routines.BuildRecord(__rtab, groups, fieldin);
    LOCAL __tform := { #EXPAND(__m2) __rtab.fieldin, __rtab.__fraRank, INTEGER __pop := 0 };
    #IF(#TEXT(groups) = '\'\'')
      // non-grouped
      LOCAL __population := SUM(__rtab, __count);
      RETURN PROJECT(__rtab, TRANSFORM(__tform, SELF.__pop:=__population, SELF:=LEFT));
    #ELSE
      // grouped (compile error on the JOIN if groups is empty)
      LOCAL __m1 := KEL.Routines.BuildRecord(__rtab, groups, '');
      LOCAL __ntab := TABLE(__rtab,
                            { #EXPAND(__m1) __pop := SUM(GROUP, __count) },
                            #EXPAND(__m1)
                            MERGE);
      LOCAL __j1 := KEL.Routines.BuildJoin(din, groups, '', '');
      RETURN JOIN(__rtab, __ntab, #EXPAND(__j1),
                         TRANSFORM(__tform, SELF.__pop:=RIGHT.__pop, SELF:=LEFT),
                         LEFT OUTER, LOOKUP);
    #END
  ENDMACRO;
  EXPORT INTEGER KELbucketCalc(REAL observ, INTEGER bins, INTEGER pop) := FUNCTION
    RETURN (TRUNCATE((observ-1) / (pop/bins))) + 1;
  END;
  EXPORT KELbucketTable(din, groups, fieldin, up, buckets1, fieldout1, buckets2=0, fieldout2='', buckets3=0, fieldout3='', weighted=false) := FUNCTIONMACRO
      // build support table { group, group, ... fieldin, bin1 [, bin2, [bin3]] }
    LOCAL __btab := KEL.Routines.KELbucketTableRaw(din, groups, fieldin, up, weighted);
    LOCAL __m1 := KEL.Routines.BuildRecord(din, groups, '');
    LOCAL __outform := { #EXPAND(__m1) din.fieldin,
                            KEL.typ.nint fieldout1 := __N(KEL.typ.int),
                            #IF(#TEXT(buckets2)  !=  '0')
                              KEL.typ.nint fieldout2 := __N(KEL.typ.int),
                            #END
                            #IF(#TEXT(buckets3)  !=  '0')
                              KEL.typ.nint fieldout3 := __N(KEL.typ.int),
                            #END
    };
    LOCAL __result := PROJECT(__btab, TRANSFORM(__outform,
                          SELF.fieldout1 := IF(__NL(LEFT.fieldin),
                                              __N(KEL.typ.int),
                                              __CN(KEL.Routines.KELbucketCalc(LEFT.__fraRank, buckets1, LEFT.__pop))),
                        #IF(#TEXT(buckets2)  !=  '0')
                          SELF.fieldout2 := IF(__NL(LEFT.fieldin),
                                              __N(KEL.typ.int),
                                              __CN(KEL.Routines.KELbucketCalc(LEFT.__fraRank, buckets2, LEFT.__pop))),
                        #END
                        #IF(#TEXT(buckets3)  !=  '0')
                          SELF.fieldout3 := IF(__NL(LEFT.fieldin),
                                              __N(KEL.typ.int),
                                              __CN(KEL.Routines.KELbucketCalc(LEFT.__fraRank, buckets3, LEFT.__pop))),
                        #END
                        SELF := LEFT));
    RETURN __result;
  ENDMACRO;
//============================================================================================
//      Date Related
// many are KEL wrapper functions for equivalents in ECL module STD.DATE
  EXPORT INTEGER YearFromDate (KEL.typ.kdate pdate) := FUNCTION
        RETURN STD.DATE.Year(pdate);
        END;
  EXPORT INTEGER MonthFromDate (KEL.typ.kdate pdate) := FUNCTION
        RETURN STD.DATE.Month(pdate);
        END;
  EXPORT INTEGER DayFromDate (KEL.typ.kdate pdate) := FUNCTION
        RETURN STD.DATE.Day(pdate);
        END;
  EXPORT KEL.typ.kdate DateFromParts (INTEGER2 yyyy, UNSIGNED1 mm, UNSIGNED1 dd) := FUNCTION
        RETURN STD.DATE.DateFromParts(yyyy, mm, dd);
        END;
  // this works on a year number
  EXPORT BOOLEAN YearIsLeapYear (INTEGER pdate) := FUNCTION
        RETURN STD.DATE.IsLeapYear(pdate);
        END;
  // this works on a DATE while STD.DATE.IsLeapYear works on a year number
  EXPORT BOOLEAN IsLeapYear (KEL.typ.kdate pdate) := FUNCTION
        RETURN STD.DATE.IsLeapYear(STD.DATE.Year(pdate));
        END;
  EXPORT INTEGER DayOfYear (KEL.typ.kdate pdate) := FUNCTION
        RETURN STD.DATE.DayOfYear(pdate);
        END;
  SHARED INTEGER intYearsBetween (KEL.typ.kdate from, KEL.typ.kdate to) := FUNCTION
    years := STD.DATE.Year(to)-STD.DATE.Year(from) - 1;
    adjusted:= years + IF ( STD.DATE.Month(from)>STD.DATE.Month(to) OR
                           (STD.DATE.Month(from)=STD.DATE.Month(to) AND STD.DATE.Day(from)>=STD.DATE.Day(to) ), 1, 0);
    RETURN adjusted;
    END;
  EXPORT INTEGER YearsBetween (KEL.typ.kdate pdate1, KEL.typ.kdate pdate2) := FUNCTION
        RETURN IF (pdate1<pdate2, intYearsBetween(pdate1, pdate2), -intYearsBetween(pdate2, pdate1));
        END;
  EXPORT INTEGER MonthsBetween (KEL.typ.kdate pdate1, KEL.typ.kdate pdate2) := FUNCTION
        RETURN STD.DATE.MonthsBetween(pdate1, pdate2);
        END;
  EXPORT INTEGER DaysBetween (KEL.typ.kdate pdate1, KEL.typ.kdate pdate2) := FUNCTION
        // compute the number of days between two dates
        STD.DATE.Days_t from := STD.DATE.FromGregorianDate(pdate1);
        STD.DATE.Days_t to   := STD.DATE.FromGregorianDate(pdate2);
        RETURN to-from;
        END;
  EXPORT INTEGER RDaysFromDate (KEL.typ.kdate pdate) := FUNCTION
      // convert yyyymmdd date to Rata Die (day count with 1/1/1 as day number 1)
    // (using RDays because DayFromDate and DaysFromDate look too much alike)
    RETURN STD.DATE.FromGregorianDate(pdate);
    END;
  EXPORT KEL.typ.kdate DateFromRDays (INTEGER pdate) := FUNCTION
      // convert Rata Die (day count with 1/1/1 as day number 1) date to yyyymmdd
    RETURN STD.DATE.ToGregorianDate(pdate);
    END;
  EXPORT INTEGER DateToday () := FUNCTION
    RETURN STD.DATE.Today();
    END;
  EXPORT DateFromString(pstr, format) := FUNCTIONMACRO
      // format is per IEEE Std 1003.1 for the strptime() function
      LOCAL KEL.typ.kdate __result:= KEL.Routines.DateFromStringHelper(__T(pstr), __T(format));
      // zero result indicates an error in conversion; make this a null
      LOCAL KEL.typ.nkdate __rval := IF(__NL(pstr) OR __NL(format) OR __result = 0 OR NOT KEL.Routines.IsValidDate(__result), __N(KEL.typ.kdate), __CN(__result));
      RETURN __rval;
      ENDMACRO;
  EXPORT KEL.typ.kdate DateFromStringHelper(KEL.typ.str pstr, KEL.typ.str format) := FUNCTION
      RETURN STD.DATE.FromString(pstr, format);
      END;
    // TODO - this currently doesn't work - the compiler wants all inputs and outputs of a
    // function to be nullable or non-nullable (all the same) but is not able to boost
    // a set of strings literal to nullable -- so it takes the all-non-nullable template
    // but the input string is nullable.  The choice is between a diagnostic at compile time
    // and a ECL compile error on __fn2 in the generated code
    EXPORT KEL.typ.kdate DateFromStringSet(STRING pstr, SET OF STRING formats) := FUNCTION
      // on the KEL side this should be ValueType.set(EclType.string)
      // formats are per IEEE Std 1003.1 for the strptime() function
      KEL.typ.kdate result:= STD.DATE.MatchDateString(pstr, formats);
      // TODO - as above in DateFromString
      RETURN result;
      END;
    EXPORT StringFromDate(KEL.typ.kdate pdate, STRING format) := FUNCTION
      // format is per IEEE Std 1003.1 for the strftime() function
      RETURN STD.DATE.ToString(pdate, format);
      END;
    EXPORT DayOfWeek(KEL.typ.kdate pdate) := FUNCTION
      // compute ISO 8601 weekday number [1..7] where 1 is Monday and 7 is Sunday
      STD.DATE.Days_t dcount := STD.DATE.FromGregorianDate(pdate);
      RETURN ((dcount-2) % 7) + 1;
      END;
    EXPORT WeekNumber(KEL.typ.kdate pdate) := FUNCTION
        // compute ISO 8601 week numbers
        // (zero means the date is in the last week of the preceeding year;
        //  53 may be a leap week or may be a date in the first week of the next year)
        RETURN (STD.DATE.DayOfYear(pdate) - DayOfWeek(pdate) + 10) DIV 7;
        // example Friday 26 September 2008 is in week 39
      END;
    // AddMonths and AddYears use the rule outlined in McGinn v. State, 46 Neb. 427, 65 N.W. 46 (1895)
    // "The term `calendar month,'whether employed in statutes or contracts, and not appearing to have
    //  been used in a different sense, denotes a period terminating with the day of the succeeding month
    //  numerically corresponding to the day of its beginning, less one. If there be no corresponding day
    //  of the succeeding month, it terminates with the last day thereof."
    // The internet suggests similar legal positions exist in the Commonwealth and Germany.
    SHARED INTEGER DaysInMonth(INTEGER yyyy, INTEGER mm) := FUNCTION
        // helper routine to find the last day in a particular month
        baseDays := CHOOSE(mm, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
        febDays := IF (STD.DATE.IsLeapYear(yyyy), 29, 28);
        result := IF (mm = 2, febDays, baseDays);
        RETURN result;
        END;
    EXPORT KEL.typ.kdate AddYears(KEL.typ.kdate pdate, INTEGER pyears) := FUNCTION
        // compute the date at a signed offset from pdate
        INTEGER yyyy := STD.DATE.Year(pdate) + pyears;
        INTEGER mm := STD.DATE.Month(pdate);
        INTEGER dd := STD.DATE.Day(pdate);
        rmmup := IF(dd > DaysInMonth(yyyy, mm), mm+1, mm);
        rddup := IF(dd > DaysInMonth(yyyy, mm), 1, dd);
        rmmdn := mm;
        rdddn := MIN(dd, DaysInMonth(yyyy, rmmdn));
        result := IF (pyears >= 0, STD.DATE.DateFromParts(yyyy, rmmup, rddup),
                                   STD.DATE.DateFromParts(yyyy, rmmdn, rdddn));
        RETURN result;
        END;
  SHARED KEL.typ.kdate SubMonths(KEL.typ.kdate pdate, INTEGER pmonths) := FUNCTION
          // helper routine for subtracting months
        INTEGER mm := ((STD.DATE.Month(pdate)-1 - pmonths) % 12) + 1;
        INTEGER borrow := ((STD.DATE.Month(pdate)-1 - pmonths) DIV 12);
        INTEGER yyyy := STD.DATE.Year(pdate) - borrow - IF(mm<=0,1,0);
        INTEGER dd := STD.DATE.Day(pdate);
        rmmdn := IF(mm <= 0, mm+12, mm);
        rdddn := MIN(dd, DaysInMonth(yyyy, rmmdn));
        RETURN STD.DATE.DateFromParts(yyyy, rmmdn, rdddn);
        END;
    EXPORT KEL.typ.kdate AddMonths(KEL.typ.kdate pdate, INTEGER pmonths) := FUNCTION
        // compute the date at a signed offset from pdate
        INTEGER mm := ((STD.DATE.Month(pdate)-1 + pmonths) % 12) + 1;
        INTEGER carry := ((STD.DATE.Month(pdate)-1 + pmonths) DIV 12);
        INTEGER yyyy := STD.DATE.Year(pdate) + carry;
        INTEGER dd := STD.DATE.Day(pdate);
        rmmup := IF(dd > DaysInMonth(yyyy, mm), mm+1, mm);
        rddup := IF(dd > DaysInMonth(yyyy, mm), 1, dd);
        result:= STD.DATE.DateFromParts(yyyy, rmmup, rddup);
        RETURN IF(pmonths >= 0, result, subMonths(pdate, -pmonths));
        END;
  EXPORT KEL.typ.kdate AddDays(KEL.typ.kdate pdate, INTEGER pdays) := FUNCTION
        // compute the date at a signed offset from pdate
        STD.DATE.Days_t base := STD.DATE.FromGregorianDate(pdate);
        RETURN STD.DATE.ToGregorianDate(base+pdays);
        END;
/**
 * Adjusts a date by incrementing or decrementing months and/or years.  This
 * routine uses the rule outlined in McGinn v. State, 46 Neb. 427, 65 N.W. 46 (1895):
 * "The term calendar month, whether employed in statutes or contracts, and
 * not appearing to have been used in a different sense, denotes a period
 * terminating with the day of the succeeding month numerically corresponding
 * to the day of its beginning, less one. If there be no corresponding day of
 * the succeeding month, it terminates with the last day thereof."  The
 * internet suggests similar legal positions exist in the Commonwealth
 * and Germany.  Note that day adjustments are performed after year and month
 * adjustments using the preceding rules.  As an example, Jan. 31, 2014 + 1 month
 * will result in Feb. 28, 2014; Jan. 31, 2014 + 1 month + 1 day will result
 * in Mar. 1, 2014.
 *
 * @param date          The date to adjust.
 * @param year_delta    The requested change to the year value;
 *                      optional, defaults to zero.
 * @param month_delta   The requested change to the month value;
 *                      optional, defaults to zero.
 * @param day_delta     The requested change to the day value;
 *                      optional, defaults to zero.
 * @return              The adjusted Date_t value.
 */
  EXPORT KEL.typ.kdate AdjustCalendar(KEL.typ.kdate date,
                            INTEGER year_delta = 0,
                            INTEGER month_delta = 0,
                            INTEGER day_delta = 0) := BEGINC++
    #option pure
    #include <time.h>
    #body
    struct tm       timeInfo;
    unsigned int    year = date / 10000;
    unsigned int    month = (date - (year * 10000)) / 100;
    unsigned int    day = date - (year * 10000) - (month * 100);
    int             expectedMonthVal = month + month_delta - 1;
    // Normalize the expected month value
    if (expectedMonthVal >= 0)
    {
        expectedMonthVal = expectedMonthVal % 12;
    }
    else
    {
        expectedMonthVal = 12 - (abs(expectedMonthVal) % 12);
    }
    memset(&timeInfo,0,sizeof(timeInfo));
    timeInfo.tm_year = year - 1900;
    timeInfo.tm_mon = month - 1;
    timeInfo.tm_mday = day;
    timeInfo.tm_year += year_delta;
    timeInfo.tm_mon += month_delta;
    mktime(&timeInfo);
    if (timeInfo.tm_mon != expectedMonthVal)
    {
        // If the returned month doesn't match the expected month, we need to
        // go back to the last day of the previous month
        timeInfo.tm_mday = 0;
        mktime(&timeInfo);
    }
    // Now apply the day delta
    timeInfo.tm_mday += day_delta;
    mktime(&timeInfo);
    unsigned int    result = 0;
    result = (timeInfo.tm_year + 1900) * 10000;
    result += (timeInfo.tm_mon + 1) * 100;
    result += timeInfo.tm_mday;
    return result;
  ENDC++;
  EXPORT BOOLEAN IsJulianLeapYear (INTEGER pdate) := FUNCTION
      RETURN STD.DATE.IsJulianLeapYear(pdate);
      END;
  EXPORT BOOLEAN IsValidDate3 (KEL.typ.kdate pdate, INTEGER yearlow, INTEGER yearhigh) := FUNCTION
    INTEGER yyyy := STD.DATE.Year(pdate);
    INTEGER mm   := STD.DATE.Month(pdate);
    INTEGER dd   := STD.DATE.Day(pdate);
    BOOLEAN result := IF ( (yyyy BETWEEN yearlow AND yearhigh) AND
                           (mm BETWEEN 1         AND 12) AND
                           (dd BETWEEN 1         AND DaysInMonth(yyyy, mm) ), 1, 0);
    RETURN result;
    END;
  EXPORT BOOLEAN IsValidDate (KEL.typ.kdate pdate) := FUNCTION
    RETURN IsValidDate3(pdate, 1800, 2200);
    END;
  EXPORT STRING ConvertDateFormat (STRING pdate, STRING iform, STRING oform) := FUNCTION
      RETURN STD.DATE.ConvertFormat(pdate, iform, oform);
      END;
  EXPORT STRING ConvertDateFormatMultiple (STRING pdate, SET OF STRING iform, STRING oform) := FUNCTION
      RETURN STD.DATE.ConvertFormatMultiple(pdate, iform, oform);
      END;
  EXPORT INTEGER DaysSince1900(INTEGER pyear, INTEGER pmonth, INTEGER pday) := FUNCTION
      RETURN STD.DATE.DaysSince1900(pyear, pmonth, pday);
      END;
  EXPORT INTEGER ToDaysSince1900(KEL.typ.kdate pdate) := FUNCTION
      RETURN STD.DATE.ToDaysSince1900(pdate);
      END;
  EXPORT KEL.typ.kdate FromDaysSince1900(INTEGER pdays) := FUNCTION
      RETURN STD.DATE.FromDaysSince1900(pdays);
      END;
  EXPORT DateFromInteger(pdate) := FUNCTIONMACRO
      LOCAL KEL.typ.kdate __result := __T(pdate);
      LOCAL KEL.typ.nkdate __rval := IF(__NN(pdate) AND KEL.Routines.IsValidDate(__result), __CN(__result), __N(Kel.typ.kdate));
      RETURN __rval;
      ENDMACRO;
  EXPORT IntegerFromDate(pdate) := FUNCTIONMACRO
      RETURN pdate;
      ENDMACRO;
  EXPORT NIntegerFromNDate(pdate) := FUNCTIONMACRO
      RETURN __CAST(KEL.typ.int, pdate);
      ENDMACRO;
//============================================================================================
//      Helper Functions for ECL syntax
  EXPORT SubStr2(STRING pstr, istart, iend) := FUNCTION
        RETURN pstr[istart..iend];
        END;
  EXPORT SubStr1(STRING pstr, istart) := FUNCTION
        RETURN pstr[istart..];
        END;
  // varients on TRIM keywords
  EXPORT TrimAll(STRING pstr) := FUNCTION
        RETURN TRIM(pstr, ALL);
        END;
  EXPORT TrimBoth(STRING pstr) := FUNCTION
        RETURN TRIM(pstr, LEFT, RIGHT);
        END;
  EXPORT TrimLeft(STRING pstr) := FUNCTION
        RETURN TRIM(pstr, LEFT);
        END;
//  clipping functions
  EXPORT BoundsFold(pvalue, plow, phigh) := FUNCTION 
        RETURN IF(pvalue < plow, 
                  plow,
                  IF(pvalue > phigh, phigh, pvalue));
          END;
  EXPORT BoundsClip(pvalue, plow, phigh) := FUNCTIONMACRO 
        RETURN IF( __NL(pvalue) OR 
                  (__NN(plow)  AND __T(pvalue) < __T(plow)) OR
                  (__NN(phigh) AND __T(pvalue) > __T(phigh)), 
                  __N(TYPEOF(__T(pvalue))), 
                  pvalue);
        ENDMACRO;
END;
