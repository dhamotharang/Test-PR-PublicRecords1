IMPORT ut, NAICSCodes;

EXPORT integer fn_valid_NAICSCode(string code) := function

	pNAICSLookup := DATASET('~thor_data400::base::naicscodes::qa::lookup',NAICSCodes.Layouts.NAICSLookup,THOR);

	return ut.fn_NAICS_functions.fn_validate_NAICSCode(code);

END;
