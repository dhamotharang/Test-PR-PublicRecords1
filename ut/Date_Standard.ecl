EXPORT Date_Standard := MODULE

  EXPORT date_dashed(STRING s) := FUNCTION
    UNSIGNED2 _yyyy := (UNSIGNED2) s[1..(StringLib.StringFind(s,'-',1) - 1)];
    UNSIGNED1 _mm := (UNSIGNED1) s[(StringLib.StringFind(s,'-',1) + 1)..(StringLib.StringFind(s,'-',2) - 1)];
    UNSIGNED1 _dd := (UNSIGNED1) s[(StringLib.StringFind(s,'-',2) + 1)..];
    new_date := IF(_yyyy > 0, (STRING4) _yyyy, '') + IF(_mm > 0, INTFORMAT(_mm,2,1), '')  + IF(_dd > 0, INTFORMAT(_dd,2,1), '');
    
    RETURN IF(LENGTH(s) >= 8 AND LENGTH(s) <= 10 AND StringLib.StringFindCount(s, '-') = 2, new_date, s);
    
  END;

  EXPORT YYYYMMDD(STRING pDateTime, STRING pDateFormat) := FUNCTION
    
    dateStandard := CASE(pDateFormat,
                      'YYYY-M-D' => date_dashed(pDateTime),
                      'M/D/YYYY' => ut.date_slashed_MMDDYYYY_to_YYYYMMDD(pDateTime),
                      'MMM D YYYY h:mm' => ut.DateTimeToYYYYMMDD(pDateTime),
                      'YYYY-MM-DD hh:mm:ss' => ut.DateTimeToYYYYMMDD(pDateTime),
                      'M-D-YY' => ut.date_hyphenated_MMDDYY_to_YYYYMMDD(pDateTime),
                      'M-D-YYYY' => ut.date_hyphenated_MMDDYY_to_YYYYMMDD(pDateTime),
                      pDateTime);
                      
    RETURN(dateStandard);
    
  END;
  
END :DEPRECATED('Use Std.Date.ConverDateFormat Instead');