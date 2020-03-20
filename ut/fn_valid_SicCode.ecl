IMPORT SICCodes;

EXPORT integer fn_valid_SicCode(string code) := function

	RETURN ut.fn_SIC_functions.fn_validate_SICCode(code);

END;