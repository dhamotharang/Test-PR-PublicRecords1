import Std, Address;
EXPORT fn_valid_lname(string s, string src) := FUNCTION
	fields := Std.Str.SplitWords(s, '|', true);
	lname := fields[1];
	
	return NOT Address.Persons.InvalidLastName(lname);
END;