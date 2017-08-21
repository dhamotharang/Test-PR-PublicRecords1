IMPORT ut;

EXPORT Date_Standard := MODULE

  EXPORT dateError(STRING pDT, STRING pDF) := FUNCTION
    //Some error logic needs to go here.  Still determining what that should be.
    //RETURN(IF(Logging.addWorkunitWarning('Bad Date or Date Format'), pDT, pDT));
    RETURN(pDT);
    
  END;

  EXPORT date_dashed(STRING s) := FUNCTION
    UNSIGNED2 _yyyy := (UNSIGNED2) s[1..(StringLib.StringFind(s,'-',1) - 1)];
    UNSIGNED1 _mm := (UNSIGNED1) s[(StringLib.StringFind(s,'-',1) + 1)..(StringLib.StringFind(s,'-',2) - 1)];
    UNSIGNED1 _dd := (UNSIGNED1) s[(StringLib.StringFind(s,'-',2) + 1)..];
    new_date := IF(_yyyy > 0, (STRING4) _yyyy, '') + IF(_mm > 0, INTFORMAT(_mm,2,1), '')  + IF(_dd > 0, INTFORMAT(_dd,2,1), '');
    
    RETURN IF(LENGTH(s) >= 8 AND LENGTH(s) <= 10 AND StringLib.StringFindCount(s, '-') = 2, new_date, dateError(s, 'YYYY-M-D'));
    
  END;

  EXPORT YYYYMMDD(STRING pDateTime, STRING pDateFormat) := FUNCTION
    
    dateStandard := CASE(pDateFormat,
                      'YYYY-M-D' => date_dashed(pDateTime),
                      'M/D/YYYY' => ut.date_slashed_MMDDYYYY_to_YYYYMMDD(pDateTime),
                      'MMM D YYYY h:mm' => ut.DateTimeToYYYYMMDD(pDateTime),
                      'YYYY-MM-DD hh:mm:ss' => ut.DateTimeToYYYYMMDD(pDateTime),
                      'M-D-YY' => ut.date_hyphenated_MMDDYY_to_YYYYMMDD(pDateTime),
                      'M-D-YYYY' => ut.date_hyphenated_MMDDYY_to_YYYYMMDD(pDateTime),
                      dateError(pDateTime, pDateFormat));
                      
    RETURN(dateStandard);
    
  END;
  
END;