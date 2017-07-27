// date validation for text search

EXPORT isValidDate(STRING arg, BOOLEAN ymd) := FUNCTION
	STRING srch1Pattern := '^(.*)/(.*)/(.*)$';
	BOOLEAN is1 := REGEXFIND(srch1Pattern, arg);
	STRING srch2Pattern := '^(.*)-(.*)-(.*)$';
	BOOLEAN is2 := REGEXFIND(srch2Pattern, arg);
	STRING year := MAP(
				ymd AND is1 => REGEXFIND(srch1Pattern, arg, 1),
				ymd AND is2 => REGEXFIND(srch2Pattern, arg, 1),
				is1					=> REGEXFIND(srch1Pattern, arg, 3),
				is2					=> REGEXFIND(srch2Pattern, arg, 3),
				'0');
	STRING month := MAP(
				ymd AND is1 => REGEXFIND(srch1Pattern, arg, 2),
				ymd AND is2 => REGEXFIND(srch2Pattern, arg, 2),
				is1					=> REGEXFIND(srch1Pattern, arg, 1),
				is2					=> REGEXFIND(srch2Pattern, arg, 1),
				'0');
	STRING day := MAP(
				ymd AND is1 => REGEXFIND(srch1Pattern, arg, 3),
				ymd AND is2 => REGEXFIND(srch2Pattern, arg, 3),
				is1					=> REGEXFIND(srch1Pattern, arg, 2),
				is2					=> REGEXFIND(srch2Pattern, arg, 2),
				'0');
	INTEGER yr := (INTEGER) year;
	INTEGER mo := (INTEGER) month;
	INTEGER dy := (INTEGER) day;
	SET OF INTEGER days31 := [1,3,5,7,8,10,12];
	BOOLEAN isLeapYr(INTEGER yr) := MAP(
			yr%100 = 0		=> IF(yr%400=0, TRUE, FALSE),
			yr%4 = 0			=> TRUE,
			FALSE);
	BOOLEAN isValidDD(INTEGER yy, INTEGER mm, INTEGER dd) := MAP(
			dd < 29																		=> TRUE,
			dd = 29 AND mm = 2												=> isLeapYr(yy),
			dd = 29 AND mm <> 2												=> TRUE,
			dd = 30 AND mm <> 2												=> TRUE,
			dd = 31 AND mm IN days31									=> TRUE,
			FALSE);
	BOOLEAN rslt := MAP(
		yr > 2040													=> FALSE,
		yr < 1800													=> FALSE,
		mo < 1														=> FALSE,
		mo > 12														=> FALSE,
		isValidDD(yr, mo, dy));
	RETURN rslt;
END;

