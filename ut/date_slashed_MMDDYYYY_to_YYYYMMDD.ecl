/**
  *Function to reformats MM/DD/YYYY TO YYYYMMDD  
  *IF no Partial dates in the input STD.date.ConvertDateFormat( inDate, '%Y%m%d','%m/%d/%Y') is better replacement
 */
EXPORT date_slashed_MMDDYYYY_to_YYYYMMDD (STRING s) := FUNCTION
  UNSIGNED1 _mm := (UNSIGNED1) s[1..StringLib.StringFind(s,'/',1) - 1];
  UNSIGNED1 _dd := (UNSIGNED1) s[StringLib.StringFind(s,'/',1) + 1 .. StringLib.StringFind(s,'/',2) - 1 ];
  UNSIGNED2 _yyyy := (UNSIGNED2) s[StringLib.StringFind(s,'/',2) + 1	.. ];
RETURN if(_yyyy > 0, (string4) _yyyy, '') + if(_mm > 0, intformat(_mm,2,1), '')  + IF(_dd > 0, intformat(_dd,2,1), '');
END;

