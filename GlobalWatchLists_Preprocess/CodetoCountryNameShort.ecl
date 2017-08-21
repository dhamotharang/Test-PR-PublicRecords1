dict := DICTIONARY(LookupFiles.dsCountryCodes, {country_code => country_name_short});

EXPORT CodetoCountryNameShort(string code) := dict[code].country_name_short;