// For debugging name issues
IMPORT	Address;
EXPORT TestName(string name) := FUNCTION

		cln :=  Address.Precleanname(name);

		return MODULE
			export string40 namein := name;

			export string1		type := Address.Business.GetNameType(name);
			export string8		format := Address.namecleaner.PersonNameFormat(name);
			export string73		clean := address.NameCleaner.CleanNameEx(name);
			export string6		segments := Address.Persons.GetNameSegments(cln);
			export boolean		inv := Address.NameTester.InvalidNameFormat(name);
			export string3		quality := Address.Persons.NameQualityText(cln);

			export string40	preclean := Address.Precleanname(name);
			export string73	external := Address.CleanPerson73(name);
			export string140	external2 := Address.CleanDualName140(name);
		END;
END;