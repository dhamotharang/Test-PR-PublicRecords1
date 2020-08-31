EXPORT UNSIGNED8 fn_ConvertDateTime(STRING19 dateTimeStamp) := FUNCTION

	Year := dateTimeStamp[7..10];
	Month := dateTimeStamp[1..2];
	Day := dateTimeStamp[4..5];
	Hour := dateTimeStamp[12..13];
	Minute := dateTimeStamp[15..16];
	Second := dateTimeStamp[18..19];

	intDateTime := (UNSIGNED8) (Year+Month+Day+Hour+Minute+Second);
 RETURN intDateTime;
 
END;