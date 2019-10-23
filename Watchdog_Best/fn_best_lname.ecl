import STD, NId;
// returns true if the name cleaned as a person
EXPORT fn_best_lname(string s, string src) := FUNCTION
	fields := Std.Str.SplitWords(s, '|', true);
	lname := fields[1];
	nameind := fields[2];
	ntype := Nid.NameIndicators.GetTypeFromInd((unsigned2)nameind);
	return if(ntype in ['P','D','T'], true, false);

END;