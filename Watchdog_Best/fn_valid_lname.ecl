import Address;
EXPORT fn_valid_lname(string s, string src) := 
					NOT Address.Persons.InvalidLastName(s);
