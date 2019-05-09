import STD;
/**
The following fields are included in the data
prim_range:predir:prim_name:suffix:postdir:unit_desig:sec_range:city_name:st:zip:zip4:tnt:rawaid:alldates
If zip4 is populated, then the assumption is that the address cleaned OK
**/
// date should be within one year
boolean isRecent(unsigned4 dt) := IF( STD.Date.MonthsBetween((dt * 100) + 1, STD.date.Today()) <= 12, 
													true, false);
nonstates := ['AA','AE','AP'];
EXPORT fn_best_address(string s, string src) := FUNCTION

	fields := Std.Str.SplitWords(s, '|', true);
	prim_name := fields[3];
	st := fields[9];
	zip4 := fields[11];
	tnt := TRIM(fields[12]);
	dt_last_seen := TRIM(fields[15]);

	return iF(zip4='' OR REGEXFIND('^(PO BOX|RR|HC)\\b', prim_name) OR st IN nonstates OR dt_last_seen='0'
											OR NOT IsRecent((unsigned4)dt_last_seen), false, true);		

END;
