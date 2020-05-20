IMPORT ut, SICCodes;

EXPORT integer fn_valid_SicCode(string code
) := function

	return ut.fn_SIC_functions.fn_validate_SicCode(code);

END;