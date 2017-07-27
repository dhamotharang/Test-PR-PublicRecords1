
export UNSIGNED4 ConvertDate(STRING arg, BOOLEAN ymd=FALSE) := FUNCTION
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
	UNSIGNED4 rslt := dy + (100*mo) + (10000*yr);
	RETURN rslt;
END;