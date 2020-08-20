EXPORT UNSIGNED4 fn_ConvertDate(STRING19 dateTimeStamp) := FUNCTION

	Year := dateTimeStamp[7..10];
	Month := dateTimeStamp[1..2];
	Day := dateTimeStamp[4..5];

	intDate := (UNSIGNED4) (Year+Month+Day);
 RETURN intDate;
 
END;