IMPORT Accuity, STD;

r := RECORD
	string		id;
	string		country;
	integer		valueid := 99;
END;

EXPORT GetCountries(DATASET(Accuity.Layouts.input.rEntity) infile) := FUNCTION

	countries := Accuity.Functions.normAddresses(infile);
	
	withvalues := JOIN(countries, PEP.CountryCodes.dsCountryCodes, STD.Str.ToUpperCase(LEFT.country) = STD.Str.ToUpperCase(RIGHT.name),
									TRANSFORM(r,
											SELF.valueid := IF(LEFT.country='',99,RIGHT.valueid);
											SELF := LEFT;), LEFT OUTER);

	
	return withvalues;

END;