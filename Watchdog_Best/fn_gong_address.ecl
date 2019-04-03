import STD;
/**
The following fields are included in the data
prim_range:predir:prim_name:suffix:postdir:unit_desig:sec_range:city_name:st:zip:zip4:tnt:rawaid:dt_first_seen
If zip4 is populated, then the assumption is that the address cleaned OK
**/
EXPORT fn_gong_address(string s, string src) := FUNCTION

	fields := Std.Str.SplitWords(s, '|', true);
	zip4 := fields[11];
	tnt := TRIM(fields[12]);
	dt_first_seen := TRIM(fields[14]);

	return iF(zip4 <> '' AND tnt = 'B' AND dt_first_seen<>'000000', true, false);		// matches current gong address

END;;