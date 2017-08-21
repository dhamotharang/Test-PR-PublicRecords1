EXPORT LookupFiles := MODULE;

	EXPORT dsOFACSanctionCodes 	:= DATASET(root+'ofac_sanctions_lookup', Layouts.rOFACSanctionCodes, CSV(separator('|'),heading(1),quote('\t'), UNICODE, NOTRIM));
	EXPORT dsCountryCodes 			:= DATASET(root+'county_code_lookup', Layouts.rCountryCodes, THOR);

END;