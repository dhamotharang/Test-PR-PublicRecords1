IMPORT Address;

string70 GetName1(string s, integer n, string t) := (string5)Address.Persons.Title(s, n, 'U', t) +
							Address.Persons.FormatName(s, n)[6..];
							

EXPORT string73 CleanPerson73(string name) := FUNCTION
	t := TRIM(StringLib.StringToUpperCase(name),LEFT,RIGHT);
	s := Address.PrecleanName(t);
	n := Address.Persons.PersonalNameFormat(s, true);

	cln := IF(Address.Persons.validPersonNameFormat(n), 
				GetName1(s, n, t), '');

	return	(string70)cln + '   ';
END;
