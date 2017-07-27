/**
  * This function takes in a date/time format such as: Jul 7 2011 4:03PM and converts it to YYYYMMDD.
  * So long as the format is one of the following this should work:
  * MMM D YYYY h:mm     (Format 1)
  * YYYY-MM-DD hh:mm:ss (Format 2)
  * IF no partial date below STD library function is better option
  * STD.DATE.FromStringToDate( dateTime, '%Y-%m-%d')
  * STD.DATE.FromStringToDate( dateTime, '%b %d %Y')
**/
EXPORT DateTimeToYYYYMMDD (STRING dateTime) := FUNCTION
	useFormat2 := StringLib.StringFind(dateTime, '-', 1) > 0; // Format is: 2010-04-30 12:26:50
	
	dT := StringLib.StringToUpperCase(TRIM(dateTime[1..11], LEFT, RIGHT));
	mon := TRIM(dT[1..3], ALL);
	day := TRIM(dT[4..6], ALL);
	yyyy := TRIM(dT[7..11], ALL);
	
	mm := CASE(mon,
					'JAN' => '01',
					'FEB' => '02',
					'MAR' => '03',
					'APR' => '04',
					'MAY' => '05',
					'JUN' => '06',
					'JUL' => '07',
					'AUG' => '08',
					'SEP' => '09',
					'OCT' => '10',
					'NOV' => '11',
					'DEC' => '12',
									 ''); // Invalid format, return blanks
	dd := IF((UNSIGNED)day < 10, INTFORMAT((UNSIGNED)day,2,1) , day);
	
	format1Result := IF(TRIM(mm) <> '' AND useFormat2 = FALSE, (yyyy + mm + dd), '');
	
	yyyy2 := dateTime[1..4];
	mm2 := dateTime[6..7];
	dd2 := dateTime[9..10];
	
	format2Result := IF(StringLib.StringFind(yyyy2, '-', 1) <= 0 AND 
											StringLib.StringFind(mm2, '-', 1) <= 0 AND
											StringLib.StringFind(dd2, '-', 1) <= 0 AND
											useFormat2 = TRUE, (yyyy2 + mm2 + dd2), '');
											
	final := IF(useFormat2, format2Result, format1Result);
	
	RETURN(final);
END;