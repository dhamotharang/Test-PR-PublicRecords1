import STD;
/**
The following fields are included in the data
prim_range:predir:prim_name:suffix:postdir:unit_desig:sec_range:city_name:st:zip:zip4:tnt:rawaid:dt_first_aeen:dt_last_seen:dt_vendor_first_reported:dt_vendor_last_reported
If zip4 is populated, then the assumption is that the address cleaned OK
**/
EXPORT fn_valid_address2(string s, string src) := FUNCTION

	fields := Std.Str.SplitWords(s, '|', true);
	zip4 := fields[11];
	dt_vendor_last_reported := TRIM(fields[17]);
	
	return iF(zip4='' OR dt_vendor_last_reported='0', false, true);		// field 11 is zip4

END;