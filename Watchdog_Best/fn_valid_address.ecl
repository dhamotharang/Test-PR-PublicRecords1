import STD;
/**
The following fields are included in the data
prim_range:predir:prim_name:suffix:postdir:unit_desig:sec_range:city_name:st:zip:zip4:tnt:rawaid:dt_first_seen
If zip4 is populated, then the assumption is that the address cleaned OK
**/
EXPORT fn_valid_address(string s, string src) := FUNCTION

	fields := Std.Str.SplitWords(s, '|', true);
	zip4 := fields[11];
	alldates := Std.Str.SplitWords(fields[14], '$');
	dt_first_seen := TRIM(fields[14]);
	
	return iF(zip4='' OR dt_first_seen='0', false, true);		// field 11 is zip4

END;