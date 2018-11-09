export header_records(
	boolean include_dailies = false, 
	boolean allow_wildcard = false,
	set of STRING1 daily_autokey_skipset=[],
	boolean noFail = false,
	boolean isrollup = false) :=
FUNCTION

d := get_dids(,noFail);

l := doxie.header_records_byDID(d, include_dailies, allow_wildcard, daily_autokey_skipset,,,,,,,,isrollup);

RETURN l;

END;