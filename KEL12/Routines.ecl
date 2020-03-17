﻿IMPORT KEL12 AS KEL;
IMPORT STD;
IMPORT * FROM KEL12.Null;

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
                #IF(__ISNULLABLE(din.%@label%))
                  #APPEND(newFields, '__EEQP(LEFT.'+%'@label'%+',RIGHT.'+%'@label'%+')')
                #ELSE
                  #APPEND(newFields, 'LEFT.'+%'@label'%+'=RIGHT.'+%'@label'%)
                #END
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
                  #APPEND(newFields, ' OR ');
                #END
                #IF(__ISNULLABLE(din.%@label%))
                  #APPEND(newFields, 'NOT __EEQP(LEFT.'+%'@label'%+',RIGHT.'+%'@label'%+')')
                #ELSE
                  #APPEND(newFields, 'LEFT.'+%'@label'%+'<>RIGHT.'+%'@label'%)
                #END
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

  EXPORT KELcardinalityTableRaw(din, groups, fieldin, fieldout, weighted) := FUNCTIONMACRO
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

  EXPORT KELcardinalityTable(layout, din, groups, fieldin, fieldout, weighted) := FUNCTIONMACRO
    RETURN PROJECT(KEL.Routines.KELcardinalityTableRaw(din, groups, fieldin, fieldout, weighted), layout);
    ENDMACRO;

  EXPORT KELmodeTable(layout, din, groups, fieldin, weighted) := FUNCTIONMACRO
  // insert mode annotation
    LOCAL __ntab := din (__NN(fieldin));                                        // no NULLs
    LOCAL __ctab := KEL.Routines.KELcardinalityTableRaw(__ntab, groups, fieldin, __count, weighted);
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
    RETURN PROJECT(__itab, layout);
  ENDMACRO;

  EXPORT KELrankOrdinal(layout, din, groups, fieldin, fieldout, up) := FUNCTIONMACRO
      // we're not offering this one in KEL for now - too expensive and the sequence is too arbitrary
    // insert ordinal rank annotation [a,b,b,c -> 1,2,3,4]
    //TODO -- not correct; grouping sort needs to be on a __CLEAN() copy of each grouping field
    //        which means adding them to the record, then stripping them out after the iterate
    LOCAL __outform := { din, KEL.typ.nint fieldout := __N(KEL.typ.int) };
    LOCAL __s1 := KEL.Routines.BuildSort(din, groups, fieldin, FALSE, up);
    LOCAL __b1 := KEL.Routines.BuildBreak(din, groups);
    LOCAL __int := PROJECT(din, __outform);
    RETURN PROJECT(ITERATE(SORT(__int, #EXPAND(__s1), RECORD),          // RECORD is there to give stable results
                        TRANSFORM(__outform, SELF.fieldout :=
                                  IF(__NL(RIGHT.fieldin), __N(KEL.typ.int),
                                                          IF(#EXPAND(__b1), __CN(1), __CN(__T(LEFT.fieldout)+1)));
                                  SELF := RIGHT)), layout);
  ENDMACRO;

  EXPORT KELrankTableRaw(din, groups, fieldin, up, standard, modified, fractional, dense, weighted) := FUNCTIONMACRO
  // generate standard [a,b,b,c -> 1,2,2,4], modified [a,b,b,c -> 1,3,3,4], fractional [a,b,b,c -> 1,2.5,2.5,4]
  //      and/or dense [a,b,b,c -> 1,2,2,3] rank annotations
  // bonus: __count is cardinality, but no entry for NULL

    LOCAL __ntab := din (__NN(fieldin));                                        // no NULLs
    LOCAL __ctab := KEL.Routines.KELcardinalityTableRaw(__ntab, groups, fieldin, __count, weighted);
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

  EXPORT KELrankTable(layout, din, groups, fieldin, up, standard, modified, fractional, dense, weighted) := FUNCTIONMACRO
    LOCAL __rtab := KEL.Routines.KELrankTableRaw(din, groups, fieldin, up, standard, modified, fractional, dense, weighted);
    LOCAL __m1 := KEL.Routines.BuildRecord(din, groups, '');
    LOCAL __outform := { #EXPAND(__m1)  din.fieldin, KEL.typ.nint standard, KEL.typ.nint modified, KEL.typ.nfloat fractional, KEL.typ.nint dense };
    LOCAL __ro := PROJECT(__rtab, TRANSFORM(__outform, SELF.standard := __CN(LEFT.standard), SELF.modified := __CN(LEFT.modified),
                                                       SELF.fractional := __CN(LEFT.fractional), SELF.dense := __CN(LEFT.dense),
                                                       SELF := LEFT));
    RETURN PROJECT(__ro, layout);
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
    RETURN IF( pop>1,ROUND((observ-1)/((pop-1)/bins)),100);
  END;

  EXPORT KELbucketTable(layout, din, groups, fieldin, up, buckets1, fieldout1, buckets2=0, fieldout2='', buckets3=0, fieldout3='', weighted=false) := FUNCTIONMACRO
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
    RETURN PROJECT(__result, layout);
  ENDMACRO;


//============================================================================================
//      Date Related

// many are KEL wrapper functions for equivalents in ECL module STD.DATE

  EXPORT INTEGER Year (KEL.typ.kdate pdate) := FUNCTION
        RETURN STD.DATE.Year(pdate);
        END;

  EXPORT INTEGER Month (KEL.typ.kdate pdate) := FUNCTION
        RETURN STD.DATE.Month(pdate);
        END;

  EXPORT INTEGER Day (KEL.typ.kdate pdate) := FUNCTION
        RETURN STD.DATE.Day(pdate);
        END;

  EXPORT KEL.typ.kdate DateFromParts (INTEGER2 yyyy, UNSIGNED1 mm, UNSIGNED1 dd) := FUNCTION
        RETURN STD.DATE.DateFromParts(yyyy, mm, dd);
        END;

  // this works on a year number
  EXPORT BOOLEAN IsLeapYear (INTEGER pdate) := FUNCTION
        RETURN STD.DATE.IsLeapYear(pdate);
        END;

  // this works on a DATE while STD.DATE.IsLeapYear works on a year number
  EXPORT BOOLEAN IsDateLeapYear (KEL.typ.kdate pdate) := FUNCTION
        RETURN STD.DATE.IsDateLeapYear(pdate);
        END;

  EXPORT INTEGER DayOfYear (KEL.typ.kdate pdate) := FUNCTION
        RETURN STD.DATE.DayOfYear(pdate);
        END;

  EXPORT INTEGER YearsBetween (KEL.typ.kdate pdate1, KEL.typ.kdate pdate2) := FUNCTION
        RETURN STD.DATE.YearsBetween(pdate1, pdate2);
        END;

  EXPORT INTEGER MonthsBetween (KEL.typ.kdate pdate1, KEL.typ.kdate pdate2) := FUNCTION
        RETURN STD.DATE.MonthsBetween(pdate1, pdate2);
        END;

  EXPORT INTEGER DaysBetween (KEL.typ.kdate pdate1, KEL.typ.kdate pdate2) := FUNCTION
        RETURN STD.DATE.DaysBetween(pdate1, pdate2);
        END;

  EXPORT INTEGER FromGregorianDate (KEL.typ.kdate pdate) := FUNCTION
      // convert yyyymmdd date to Rata Die (day count with 1/1/1 as day number 1)
    RETURN STD.DATE.FromGregorianDate(pdate);
    END;

  EXPORT KEL.typ.kdate ToGregorianDate (INTEGER pdate) := FUNCTION
      // convert Rata Die (day count with 1/1/1 as day number 1) date to yyyymmdd
    RETURN STD.DATE.ToGregorianDate(pdate);
    END;

  EXPORT INTEGER Today () := FUNCTION
    RETURN STD.DATE.Today();
    END;

  EXPORT FromStringToDate(pstr, format) := FUNCTIONMACRO
      // format is per IEEE Std 1003.1 for the strptime() function
      LOCAL KEL.typ.kdate __result:= KEL.Routines.StringToDateHelper(__T(pstr), __T(format));
      // zero result indicates an error in conversion; make this a null
      LOCAL KEL.typ.nkdate __rval := IF(__NL(pstr) OR __NL(format) OR __result = 0 OR NOT KEL.Routines.IsValidDate(__result), __N(KEL.typ.kdate), __CN(__result));
      RETURN __rval;
      ENDMACRO;
            
  EXPORT KEL.typ.kdate StringToDateHelper(KEL.typ.str pstr, KEL.typ.str format) := FUNCTION
      RETURN STD.DATE.FromStringToDate(pstr, format);
      END;

  EXPORT CastStringToDate(pstr) := FUNCTIONMACRO
      RETURN KEL.Routines.FromStringToDate(pstr, __CN('%Y%m%d'));
      ENDMACRO;

    // TODO - this currently doesn't work - the compiler wants all inputs and outputs of a
    // function to be nullable or non-nullable (all the same) but is not able to boost
    // a set of strings literal to nullable -- so it takes the all-non-nullable template
    // but the input string is nullable.  The choice is between a diagnostic at compile time
    // and a ECL compile error on __fn2 in the generated code
    EXPORT MatchDateString(pstr, formats) := FUNCTIONMACRO
      // on the KEL side this should be ValueType.set(EclType.string)
      // formats are per IEEE Std 1003.1 for the strptime() function
      LOCAL KEL.typ.kdate __result:= STD.DATE.MatchDateString(__T(pstr), formats);
      LOCAL KEL.typ.nkdate __rval := IF(__NL(pstr) OR __result = 0 OR NOT KEL.Routines.IsValidDate(__result), __N(KEL.typ.kdate), __CN(__result));
      RETURN __rval;
      ENDMACRO;

    EXPORT DateToString(KEL.typ.kdate pdate, STRING format) := FUNCTION
      // format is per IEEE Std 1003.1 for the strftime() function
      RETURN STD.DATE.DateToString(pdate, format);
      END;

    EXPORT DayOfWeek(KEL.typ.kdate pdate) := FUNCTION
      // compute US-convention weekday number [1..7] where 1 is Sunday and 7 is Saturday
      RETURN STD.DATE.DayOfWeek(pdate);
      END;

    EXPORT WeekNumber(KEL.typ.kdate pdate) := FUNCTION
        // compute ISO 8601 week numbers
        // (zero means the date is in the last week of the preceeding year;
        //  53 may be a leap week or may be a date in the first week of the next year)
        RETURN (STD.DATE.DayOfYear(pdate) - DayOfWeek(pdate) + 10) DIV 7;
        // example Friday 26 September 2008 is in week 39
      END;

  EXPORT KEL.typ.kdate AdjustCalendar(KEL.typ.kdate date,
                            INTEGER year_delta = 0,
                            INTEGER month_delta = 0,
                            INTEGER day_delta = 0) := FUNCTION
      RETURN STD.DATE.AdjustCalendar(date, year_delta, month_delta, day_delta);
      END;

  EXPORT BOOLEAN IsJulianLeapYear (INTEGER pdate) := FUNCTION
      RETURN STD.DATE.IsJulianLeapYear(pdate);
      END;

  EXPORT BOOLEAN IsValidDate3 (KEL.typ.kdate pdate, INTEGER yearlow, INTEGER yearhigh) := FUNCTION
    RETURN STD.DATE.IsValidDate(pdate, yearlow, yearhigh);
    END;

  EXPORT BOOLEAN IsValidDate (KEL.typ.kdate pdate) := FUNCTION
    RETURN STD.DATE.IsValidDate(pdate,,9999);
    END;

  EXPORT BOOLEAN IsValidTimeStamp (KEL.typ.timestamp ptimestamp) := FUNCTION
    LOCAL __date := ptimestamp DIV 1000000000;
    LOCAL __time := (ptimestamp - (__date*1000000000)) DIV 1000;
    LOCAL BOOLEAN __valid := MAP(NOT IsValidDate(__date) => FALSE,
                                 NOT STD.DATE.IsValidTime(__time) => FALSE,
                                 TRUE);
    RETURN __valid;
    END;

  EXPORT STRING ConvertDateFormat (STRING pdate, STRING iform, STRING oform) := FUNCTION
      RETURN STD.DATE.ConvertDateFormat(pdate, iform, oform);
      END;

  EXPORT STRING ConvertDateFormatMultiple (STRING pdate, SET OF STRING iform, STRING oform) := FUNCTION
      RETURN STD.DATE.ConvertDateFormatMultiple(pdate, iform, oform);
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

  EXPORT KEL.typ.kdate DatesForMonthStart(KEL.Typ.kdate pdays) := FUNCTION
      RETURN STD.DATE.DatesForMonth(pdays).startDate;
      END;

  EXPORT KEL.typ.kdate DatesForMonthEnd(KEL.Typ.kdate pdays) := FUNCTION
      RETURN STD.DATE.DatesForMonth(pdays).endDate;
      END;

  EXPORT KEL.typ.kdate DatesForWeekStart(KEL.Typ.kdate pdays) := FUNCTION
      RETURN STD.DATE.DatesForWeek(pdays).startDate;
      END;

  EXPORT KEL.typ.kdate DatesForWeekEnd(KEL.Typ.kdate pdays) := FUNCTION
      RETURN STD.DATE.DatesForWeek(pdays).endDate;
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
//      Helper Functions for FromFlat macro handling DATEs

  EXPORT KEL.typ.nkdate DateFromField(KEL.typ.kdate pdate) := FUNCTION
    KEL.typ.nkdate rval := IF(IsValidDate(pdate), __CN(pdate), __N(Kel.typ.kdate));
    RETURN rval;
  END;

  EXPORT DateFromField2(pdate, prule) := FUNCTIONMACRO
    KEL.typ.kdate tdate := (KEL.typ.kdate)prule(pdate);
    LOCAL KEL.typ.nkdate __rval := IF(KEL.Routines.IsValidDate(tdate), __CN(tdate), __N(Kel.typ.kdate));
    RETURN __rval;
  ENDMACRO;

//============================================================================================
//      Helper Functions for FromFlat macro handling TIMESTAMPs

  EXPORT KEL.typ.ntimestamp NTimestampFromField(KEL.typ.timestamp ptimestamp) := FUNCTION
    KEL.typ.ntimestamp rval := IF(IsValidTimestamp(ptimestamp), __CN(ptimestamp), __N(KEL.typ.timestamp));
    RETURN rval;
  END;

  EXPORT NTimestampFromField2(ptimestamp, prule) := FUNCTIONMACRO
    KEL.typ.timestamp ttimestamp := (KEL.typ.timestamp)prule(ptimestamp);
    LOCAL KEL.typ.ntimestamp __rval := IF(KEL.Routines.IsValidTimestamp(ttimestamp), __CN(ttimestamp), __N(KEL.typ.timestamp));
    RETURN __rval;
  ENDMACRO;

    EXPORT KEL.typ.timestamp TimestampFromField(KEL.typ.timestamp ptimestamp) := FUNCTION
      KEL.typ.timestamp rval := IF(IsValidTimestamp(ptimestamp), ptimestamp, (KEL.typ.timestamp) 0);
      RETURN rval;
    END;

    EXPORT TimestampFromField2(ptimestamp, prule) := FUNCTIONMACRO
      KEL.typ.timestamp ttimestamp := (KEL.typ.timestamp)prule(ptimestamp);
      LOCAL KEL.typ.timestamp __rval := IF(KEL.Routines.IsValidTimestamp(ttimestamp), ttimestamp, (KEL.typ.timestamp) 0);
      RETURN __rval;
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

//  string operations (added in #1159)

  EXPORT KEL.Typ.bool EndsWith(STRING psource, STRING psuffix) := FUNCTION
        RETURN STD.Str.EndsWith( psource, psuffix );
        END; 

  EXPORT KEL.Typ.bool StartsWith(STRING psource, STRING pprefix) := FUNCTION
        RETURN STD.Str.StartsWith( psource, pprefix );
        END;
                
  EXPORT KEL.Typ.bool Contains(STRING psource, STRING ptarget) := FUNCTION
        RETURN STD.Str.Find( psource, ptarget);
        END;                

  EXPORT ToUpperCase(STRING psource) := FUNCTION
        RETURN STD.Str.ToUpperCase( psource );
        END;

  // [harder than expected to find pairs of COUNT and GET with matching semantics]
  EXPORT INTEGER CountWords(STRING psource, STRING pseparator=' ') := 
          if ( pseparator = ' ',
             STD.Str.CountWords( psource, pseparator ),
             STD.Str.FindCount( psource, pseparator ) + 1);

  import lib_stringlib;
  sp(string s,integer1 n,string1 sep) := if( stringlib.stringfind(s,sep,n)=0, length(s)+1, stringlib.stringfind(s,sep,n) );
  export string word(string s,integer1 n,string1 sep=' ') := 
          IF ( sep = ' ',
               STD.Str.GetNthWord(s, n),  
               // copied from the SALT33 ut.mod library
              if (n = 1, s[1..sp(s,1,sep)-1],
                   s[sp(s,n-1,sep)+1..sp(s,n,sep)-1]) );

  // Floor and Ceiling functions (added in #1785)
  EXPORT INTEGER Floor(REAL preal) := IF (preal > 0, truncate(preal),roundup(preal));
  EXPORT INTEGER Ceiling(REAL preal) := IF (preal > 0, roundup(preal),truncate(preal));
  
//============================================================================================
//      Helper Functions for scalar MIN/MAX on nullable values

  EXPORT MinN(v1, v2) := FUNCTIONMACRO
        LOCAL __v1 := v1;
        LOCAL __v2 := v2;
        LOCAL __v1Null := __NL(__v1);
        LOCAL __v2Null := __NL(__v2);
        LOCAL __v1Value := __T(__v1);
        LOCAL __v2Value := __T(__v2);
        LOCAL __flag := __v1Null AND __v2NULL;
        LOCAL __value := MAP(__v1Null => __v2Value, __v2Null => __v1Value, __v1Value < __v2Value => __v1Value, __v2Value); 
        RETURN __BN(__value, __flag);
  ENDMACRO;

  EXPORT MaxN(v1, v2) := FUNCTIONMACRO
        LOCAL __v1 := v1;
        LOCAL __v2 := v2;
        LOCAL __v1Null := __NL(__v1);
        LOCAL __v2Null := __NL(__v2);
        LOCAL __v1Value := __T(__v1);
        LOCAL __v2Value := __T(__v2);
        LOCAL __flag := __v1Null AND __v2NULL;
        LOCAL __value := MAP(__v1Null => __v2Value, __v2Null => __v1Value, __v1Value > __v2Value => __v1Value, __v2Value); 
        RETURN __BN(__value, __flag);
  ENDMACRO;

//============================================================================================
//      Helper function for sorting child datasets - only sorts datasets listed in names

  EXPORT SortChildren(s, names) := FUNCTIONMACRO
    LoadXml('<xml/>');
    LOCAL __s := s;
    LOCAL __l := DATASET([], RECORDOF(__s));

    #EXPORTXML(fields, __l)
    #DECLARE(IsDataset)       // Stack of Y/N tracking whether field is in a dataset
    #DECLARE(IsRecord)        // Stack of Y/N tracking whether field is in a record
    #DECLARE(Current)         // Full qualified name of current field
    #DECLARE(Filter)          // Full qualified name of current field without KEL nullable record fields
    #DECLARE(SkipNested)      // > 0 indicates nested fields should be skipped
    #DECLARE(Code)            // The ECL created here
    #SET(IsDataset, 'N')
    #SET(IsRecord, 'N')
    #SET(Current, '__s')
    #SET(Filter, '')
    #SET(SkipNested, 0)
    #SET(Code, 'PROJECT(TABLE(__s,{')
    #FOR(fields)
      #FOR(field)
        #IF (%@IsEnd%=0)
          #APPEND(Current, '.' + %'@name'%)
        #END
        #IF (%@IsEnd%=0 AND %'@label'% <> 'v')
          #IF (%'Filter'% <> '')
            #APPEND(Filter, '.')
          #END
          #APPEND(Filter, %'@name'%)
        #END
        #IF (%@IsRecord%=1)
          #SET(IsDataset, 'N' + %'IsDataset'%)
          #SET(IsRecord, 'Y' + %'IsRecord'%)
          #IF (%SkipNested% = 0)
            #APPEND(Code, '{')
          #END
        #ELSEIF (%@IsDataset%=1)
          #SET(IsDataset, 'Y' + %'IsDataset'%)
          #SET(IsRecord, 'N' + %'IsRecord'%)
          #IF (%SkipNested% = 0)
              #IF (REGEXFIND( ','+%'Filter'%+',', ','+names+','))
                #APPEND(Code, 'TYPEOF(' + %'Current'% + ') ' + %'@name'% + ':=SORT(TABLE(' + %'Current'% + ',{')
              #ELSE
                #APPEND(Code, 'TYPEOF(' + %'Current'% + ') ' + %'@name'% + ':=' + %'Current'% + ',')
                #SET(SkipNested, %SkipNested% + 1)
              #END
          #ELSE
            #SET(SkipNested, %SkipNested% + 1)
          #END
        #ELSEIF (%@IsEnd%=1 AND %'IsDataset'%[1]='Y' AND %SkipNested% = 0)
          #SET(Code, REGEXREPLACE(',$', %'Code'%, ''))
          #APPEND(Code, '}),RECORD),')
        #ELSEIF (%@IsEnd%=1 AND %'IsDataset'%[1]='Y')
          #SET(SkipNested, %SkipNested% - 1)
        #ELSEIF (%@IsEnd%=1 AND %'IsRecord'%[1]='Y' AND %SkipNested% = 0)
          #SET(Code, REGEXREPLACE(',$', %'Code'%, ''))
          #APPEND(Code, '} ' + %'@name'% + ',')
        #ELSEIF (%SkipNested% = 0)
          #Append(Code, %'Current'% + ',')
        #END

        #IF (%@IsRecord%=0 AND %@IsDataset%=0)
          #SET(Current, REGEXREPLACE('\\.[^\\.]+$', %'Current'%, ''))
        #END
        #IF (%@IsRecord%=0 AND %@IsDataset%=0 AND %'@name'% <> 'v')
          #SET(Filter, REGEXREPLACE('(^|\\.)[^\\.]+$', %'Filter'%, ''))
        #END

        #IF (%@IsEnd%=1)
          #SET(IsDataset, %'IsDataset'%[2..])
          #SET(IsRecord, %'IsRecord'%[2..])
        #END
      #END
    #END

    #SET(Code, REGEXREPLACE(',$', %'Code'%, ''))
    #APPEND(Code, '}),RECORDOF(__s))')

    RETURN #EXPAND(%'Code'%);
//    RETURN %'Code'%;
  ENDMACRO;

//============================================================================================
//      Helper function for sorting and then copying and filtering children - this is used
//      for duplicate detection on child dataset where the duplicate should be based only on the
//      properties and not metadata like record count or epoch.

  EXPORT SortAndAppendFilteredChildren(s, tosort, children, suffix, metadata) := FUNCTIONMACRO
    LoadXml('<xml/>');
    LOCAL __s := KEL.Routines.SortChildren(s, tosort);
    LOCAL __l := DATASET([], RECORDOF(__s));

    #EXPORTXML(fields, __l)
    #DECLARE(InNested)         // Stack of Y/N tracking whether field is in a dataset
    #DECLARE(Curr)             // Full qualified name of Current field
    #DECLARE(Flt)              // Full qualified name of Current field without KEL nullable record fields
    #DECLARE(Skip)             // > 0 indicates nested fields should be skipped
    #DECLARE(Remove)           // > 0 indicates nested metadata fields should be removed
    #DECLARE(Defs)             // ECL for record definitions goes here
    #DECLARE(DefStack)         // Stack of in-progress record defintions
    #DECLARE(Stmt)             // ECL for table statement goes here
    #DECLARE(IsChild)          // > 0 indicates this matches an item in 'children'
    #DECLARE(IsMeta)           // > 0 indicates this matches an item in 'meta'
    #DECLARE(RecName)          // Current field converted to record name
    #DECLARE(RecOp)            // Holds what operation to perform on the record definition

    #SET(InNested, 'N')
    #SET(Curr, '__s')
    #SET(Flt, '')
    #SET(Skip, 0)
    #SET(Remove, 0)
    #SET(Defs, '')
    #SET(DefStack, '~')
    #SET(Stmt, 'TABLE(__s,{')

    #FOR(fields)
      #FOR(field)

        // Track the full name of the current field including dataset
        #IF (%@IsEnd%=0)
          #APPEND(Curr, '.' + %'@name'%)
        #END

        // Track the full name of the current excluding dataset and any nullable field names (v & f)
        #IF (%@IsEnd%=0 AND %'@label'% <> 'v')
          #IF (%'Flt'% <> '')
            #APPEND(Flt, '.')
          #END
          #APPEND(Flt, %'@name'%)
        #END

        // Calculate a name that can be used as a record name for this field when the metadata is stripped
        #SET(RecName, REGEXREPLACE('\\.',%'Curr'%,'_') + '_Layout')
        #SET(RecOp, '')

        // Manage stack of nested types
        #IF (%@IsRecord%=1)
          #SET(InNested, 'R' + %'InNested'%)
        #ELSEIF (%@IsDataset%=1)
          #SET(InNested, 'D' + %'InNested'%)
        #END

        // Check this item against parameters
        #SET(IsChild, IF(REGEXFIND(','+%'Flt'%+',', ','+children+','),1,0))
        #SET(IsMeta, IF(REGEXFIND(','+%'@name'%+',', ','+metadata+','),1,0))

        #IF (%@IsRecord%=1)
          // ***** Start of new record
          #IF (%Remove% = 0 AND %IsChild% > 0)
            // This is a record where we need to strip metadata from inside
            //   - Keep a copy of this record under the original name and type
            //   - Start a new record definition which will be a copy with metadata removed
            //   - Set flag to start removing metadata
            #APPEND(Stmt, %'Curr'% + ',')
            #APPEND(Stmt, '{')
            #SET(Remove, 1)
            #SET(RecOp, 'DEFINEREC')
          #ELSEIF (%Remove% > 0 AND %Skip% = 0 AND %IsMeta% = 0)
            // We're inside a structure where we need to strip metadata
            //   - Start a new record definition which will be a copy with metadata removed
            //   - Increment the nesting level
            #APPEND(Stmt, '{')
            #SET(Remove, %Remove% + 1)
            #SET(RecOp, 'DEFINEREC')
          #ELSEIF (%Remove% > 0)
            // This is a record which is metadata and should be removed
            #SET(Skip, %Skip% + 1)
            #SET(Remove, %Remove% + 1)
          #ELSEIF (%Skip% = 0)
            // We're starting a record which will just be copied field-wise (in case any fields need to be filtered)
            #APPEND(Stmt, '{')
          #ELSE
            // This is a record being skipped because the default parent assign will handle it
            #SET(Skip, %Skip% + 1)
          #END

        #ELSEIF (%@IsDataset%=1)
          // ***** Start of child dataset
          #IF (%Remove% = 0 AND %IsChild% > 0)
            // This a child dataset which needs to be duplicated and filtered
            //   - Make a normal copy
            //   - Setup to make an additional copy with metadata removed
            //   - Increment the nesting
            #APPEND(Stmt, 'TYPEOF(' + %'Curr'% + ') ' + %'@name'% + ':=' + %'Curr'% + ',')
            #APPEND(Stmt, 'DATASET(' + %'RecName'% + ') ' + %'@name'% + suffix + ':=TABLE(' + %'Curr'% + ',{')
            #SET(Remove, %Remove% + 1)
            #SET(RecOp, 'DEFINEDS')
          #ELSEIF (%Remove% > 0 AND %Skip% = 0 AND %IsMeta% = 0)
            // We're in the middle of something where we need to remove metadata
            //  - Setup to copy the child dataset with filtering
            //  - Start a record definition for the leaner record
            //  - Increment the nesting
            #APPEND(Stmt, 'DATASET(' + %'RecName'% + ') ' + %'@name'% + ':=TABLE(' + %'Curr'% + ',{')
            #SET(Remove, %Remove% + 1)
            #SET(RecOp, 'DEFINEDS')
          #ELSEIF (%Remove% > 0)
            // This is a child dataset which is part of metadata that should be skipped
            #SET(Skip, %Skip% + 1)
            #SET(Remove, %Remove% + 1)
          #ELSEIF (%Skip% = 0)
            // This a child dataset which just needs to be kept
            //   - Make the normal copy
            //   - Increment the flag to avoid explicitly copying children - they are handled by default
            #APPEND(Stmt, 'TYPEOF(' + %'Curr'% + ') ' + %'@name'% + ':=' + %'Curr'% + ',')
            #SET(Skip, %Skip% + 1)
          #ELSE
            #SET(Skip, %Skip% + 1)
          #END

        #ELSEIF (%@IsEnd%=1 AND %'InNested'%[1]='D')
          // ***** End of child dataset
          #IF (%Skip% = 0)
            // We're at the end of a child dataset which is being copied
            //  - Remove the trailing comma and close the TABLE expression
            //  - Decrement the nesting level (but not below zero)
            #SET(Stmt, REGEXREPLACE(',$', %'Stmt'%, ''))
            #APPEND(Stmt, '}),')
            #SET(RecOp, IF(%Remove% > 0, 'CLOSE', ''))
          #END
          #SET(Skip, IF(%Skip% > 0, %Skip% - 1, 0))
          #SET(Remove, IF(%Remove% > 0, %Remove% - 1, 0));
        #ELSEIF (%@IsEnd%=1 AND %'InNested'%[1]='R')
          // ***** End of record
          #IF (%Skip% = 0)
            // We're ending a record which is being copied
            //  - Remove the ending comma
            //  - Close the record definition and add a name
            //  - Decrement the nesting level (but not below zero)
            #SET(Stmt, REGEXREPLACE(',$', %'Stmt'%, ''))
            #APPEND(Stmt, '} ' + %'@name'% + IF(%Remove% = 1, suffix, '') + ',')
            #SET(RecOp, IF(%Remove% > 0, 'CLOSE', ''))
          #END
          #SET(Skip, IF(%Skip% > 0, %Skip% - 1, 0))
          #SET(Remove, IF(%Remove% > 0, %Remove% - 1, 0))

        #ELSE
          // A simple field
          #IF (%Skip% = 0 AND (%Remove% = 0 OR %IsMeta% = 0))
            #APPEND(Stmt, %'Curr'% + ',')
            #SET(RecOp, 'ADD')
          #END
        #END

        // Handle record operations
        #IF (%'RecOp'% = 'DEFINEREC')
          // Add this field to the parent record definition
          #APPEND(DefStack, %'RecName'% + ' ' + %'@name'% + ',')
          // Create a 'lean' record definition for this field without metadata
          #APPEND(DefStack, '~LOCAL ' + %'RecName'% + ':={');
        #ELSEIF (%'RecOp'% = 'DEFINEDS')
          // Add this field to the parent record definition
          #APPEND(DefStack, 'DATASET(' + %'RecName'% + ') ' + %'@name'% + ',')
          // Create a 'lean' record definition for this field without metadata
          #APPEND(DefStack, '~LOCAL ' + %'RecName'% + ':={');
        #ELSEIF (%'RecOp'% = 'ADD')
          // Add this field to the parent record definition
          #APPEND(DefStack, 'TYPEOF(' + %'Curr'% + ')' + ' ' + %'@name'% + ',')
        #ELSEIF (%'RecOp'% = 'CLOSE')
          // Eliminate trailing comma
          #SET(DefStack, REGEXREPLACE(',$', %'DefStack'%, ''))
          // Close record definition
          #APPEND(DefStack, '};\n')
          // Append this definition to the list
          #APPEND(Defs, REGEXFIND('~([^~]*)$', %'DefStack'%, 1))
          // Pop this definition from the stack
          #SET(DefStack, REGEXREPLACE('~[^~]*$', %'DefStack'%, ''))
        #END

        // Backup current and filter values
        #IF (%@IsRecord%=0 AND %@IsDataset%=0)
          #SET(Curr, REGEXREPLACE('\\.[^\\.]+$', %'Curr'%, ''))
        #END
        #IF (%@IsRecord%=0 AND %@IsDataset%=0 AND %'@name'% <> 'v')
          #SET(Flt, REGEXREPLACE('(^|\\.)[^\\.]+$', %'Flt'%, ''))
        #END

        // Pop the nesting stack
        #IF (%@IsEnd%=1)
          #SET(InNested, %'InNested'%[2..])
        #END
      #END
    #END

    #SET(Stmt, REGEXREPLACE(',$', %'Stmt'%, ''))
    #APPEND(Stmt, '})')
    #EXPAND(%'Defs'%)
    RETURN #EXPAND(%'Stmt'%);
//    RETURN %'Defs'% + '\n' + %'Stmt'%;
  ENDMACRO;

//============================================================================================
//  Sequence Append

  EXPORT SequenceAppendSortAndGroup(din, sort_fields, group_fields) := FUNCTIONMACRO
    LoadXml('<xml/>');
    #DECLARE(fullsort)
    #IF (group_fields != '')
      #SET(fullsort, group_fields + ',' + sort_fields)
    #ELSE
      #SET(fullsort, sort_fields)
    #END
    LOCAL __sorted := SORT(din, #EXPAND(%'fullsort'%));
    #IF (group_fields != '')
      LOCAL __result := GROUP(__sorted, #EXPAND(group_fields));
    #ELSE
      LOCAL __result := __sorted;
    #END
    RETURN __result;
  ENDMACRO;

  // Sort dataset by sort fields and then iterate over the result in that order and apply transform
  EXPORT SequenceAppendSmall(din, sort_fields, process_rec, process_trans, final_trans, group_fields) := FUNCTIONMACRO
    LOCAL __grouped := KEL.Routines.SequenceAppendSortAndGroup(din, sort_fields, group_fields);
    LOCAL __process_format := PROJECT(__grouped, TRANSFORM(process_rec, SELF:=LEFT, SELF:=[]));
    LOCAL __appended := ITERATE(__process_format, process_trans(LEFT, RIGHT, LEFT, COUNTER) #IF (group_fields = '') ,LOCAL #END);
    LOCAL __final := PROJECT(__appended, final_trans(LEFT));
    RETURN __final;
  ENDMACRO;

  // Sort dataset by sort fields, project over all records and, for each record, iterate over all the previous records and apply transform.
  // This version is used when the conditions in the transform depend on both the current and previous which means
  // the results can't be calculated in just one pass over the dataset.  This version does not support grouping.
  EXPORT SequenceAppendSmallCorr(din, sort_fields, process_rec, process_trans, final_trans, group_fields) := FUNCTIONMACRO
    LOCAL __grouped := KEL.Routines.SequenceAppendSortAndGroup(din, sort_fields, group_fields);
    LOCAL __local_rec := { process_rec __payload, INTEGER __recno };
    LOCAL __process_format := PROJECT(__grouped, TRANSFORM(__local_rec, SELF.__recno := COUNTER, SELF.__payload:=LEFT, SELF:=[]));
    LOCAL __local_rec __call_transform(__local_rec __l, __local_rec __r) := TRANSFORM
      SELF.__payload := IF(__l.__recno = __r.__recno, __r.__payload, ROW(process_trans(__l.__payload, __r.__payload, __r.__payload, __r.__recno)));
      SELF.__recno := __r.__recno;
    END;
    LOCAL process_rec __process(__local_rec __rec) := TRANSFORM
      SELF := PROCESS(NOCOMBINE(__process_format(__recno <= __rec.__recno)), __rec, __call_transform(LEFT, RIGHT), __call_transform(LEFT, RIGHT))[__rec.__recno].__payload;
    END;
    LOCAL __processed := PROJECT(__process_format, __process(LEFT));
    LOCAL __final := PROJECT(__processed, final_trans(LEFT));
    RETURN __final;
  ENDMACRO;

  // Sort dataset by sort fields, project over all records and, for each record, iterate over all the previous records and apply transform.
  // This version is used when the conditions in the transform depend on both the current and previous which means
  // the results can't be calculated in just one pass over the dataset. This version does support grouping
  EXPORT SequenceAppendSmallCorrGrouped(din, sort_fields, process_rec, process_trans, final_trans, group_fields) := FUNCTIONMACRO
    LOCAL __grouped := KEL.Routines.SequenceAppendSortAndGroup(din, sort_fields, group_fields);
    LOCAL __local_rec := { process_rec __payload, INTEGER __recno };
    LOCAL __group_rec := { __local_rec; DATASET(__local_rec) __group };
    LOCAL __process_format := PROJECT(__grouped, TRANSFORM(__group_rec, SELF.__recno := COUNTER, SELF.__payload:=LEFT, SELF:=[]));
    LOCAL __group_rec __call_transform(__group_rec __l, __group_rec __r) := TRANSFORM
      SELF.__payload := IF(__l.__recno = __r.__recno, __r.__payload, ROW(process_trans(__l.__payload, __r.__payload, __r.__payload, __r.__recno)));
      SELF.__recno := __r.__recno;
      SELF := [];
    END;
    LOCAL __group_rec __process(__group_rec __rec, DATASET(__group_rec) __recs) := TRANSFORM
      __local_rec __inner(__group_rec __group_rec) := TRANSFORM
        SELF := ROW(PROCESS(__recs(__recno <= __group_rec.__recno), __group_rec, __call_transform(LEFT, RIGHT), __call_transform(LEFT, RIGHT))[__group_rec.__recno], __local_rec);
        SELF := [];
      END;
      SELF.__group := PROJECT(__recs, __inner(LEFT));
      SELF := [];
    END;
    LOCAL __processed := ROLLUP(__process_format, GROUP, __process(LEFT, ROWS(LEFT)));
    LOCAL __normalized := NORMALIZE(__processed, LEFT.__group, TRANSFORM(process_rec, SELF:=RIGHT.__payload));
    LOCAL __final := PROJECT(__normalized, final_trans(LEFT));
    RETURN __final;
  ENDMACRO;

  // Sort dataset by sort fields, assign unique record numbers to the result, join those numbers back to combine
  // current to previous records and apply transform.
  EXPORT SequencePreviousLarge(din, sort_fields, process_rec, process_trans, final_trans) := FUNCTIONMACRO
    LOCAL __sorted := SORT(din, #EXPAND(sort_fields));
    LOCAL __local_rec := { process_rec __payload, INTEGER __recno };
    LOCAL __process_format := PROJECT(__sorted, TRANSFORM(__local_rec, SELF.__payload:=LEFT, SELF.__recno:=COUNTER, SELF:=[]));
    LOCAL __joined := JOIN(__process_format, __process_format, LEFT.__recno = RIGHT.__recno + 1,
                           process_trans(RIGHT.__payload, LEFT.__payload, LEFT.__payload, LEFT.__recno), LEFT OUTER, HASH);
    LOCAL __final := PROJECT(__joined, final_trans(LEFT));
    RETURN __final;
  ENDMACRO;

  // Sort dataset by sort fields, assign unique record numbers to the result, filter result by condition to find which
  // records satisfy the condition, assign new record numbers to these records and join them back to match previous to
  // current.  Then normalize the result based on the size of the gap between each one so that every original record
  // number now has a matching record with it's previous information.  Join this back to the original to match current
  // to previous and apply the transform.
  EXPORT SequencePreviousLargeCond(din, sort_fields, process_rec, process_trans, final_trans, cond) := FUNCTIONMACRO
    LOCAL __sorted := SORT(din, #EXPAND(sort_fields));
    // This names __payload and __base below are referenced in Names.SEQUENCEAPPEND_FILTER_BASE and must match that value
    LOCAL __local_rec := { process_rec __payload, INTEGER __recno, INTEGER __matchno, INTEGER __nextno };
    LOCAL __base := PROJECT(__sorted, TRANSFORM(__local_rec, SELF.__payload:=LEFT, SELF.__recno:=COUNTER, SELF:=[]));
    LOCAL __filtered := PROJECT(__base(cond), TRANSFORM(__local_rec, SELF.__matchno:=COUNTER, SELF:=LEFT, SELF:=[]));
    LOCAL __matched := JOIN(__filtered, __filtered, LEFT.__matchno + 1 = RIGHT.__matchno,
                            TRANSFORM(__local_rec, SELF.__nextno:=IF(RIGHT.__recno!=0,RIGHT.__recno,COUNT(__base)), SELF:=LEFT, SELF:=[]), LEFT OUTER, HASH);
    LOCAL __expanded := NORMALIZE(__matched, LEFT.__nextno-LEFT.__recno, TRANSFORM(__local_rec, SELF.__recno:=LEFT.__recno + COUNTER, SELF:=LEFT));
    LOCAL __joined := JOIN(__base, __expanded, LEFT.__recno = RIGHT.__recno, process_trans(RIGHT.__Payload, LEFT.__payload, LEFT.__payload, LEFT.__recno), LEFT OUTER, HASH);
    LOCAL __final := PROJECT(__joined, final_trans(LEFT));
    RETURN __final;
  ENDMACRO;

END;

