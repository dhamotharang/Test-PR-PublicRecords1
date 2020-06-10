import codes;
EXPORT fn_NaicCodeInterpreter(INTEGER NaicCodeInput) := FUNCTION
OutPutCode := Codes.Key_NAICS(KEYED(naics_code = (STRING)NaicCodeInput))[1].naics_description;
RETURN if(OutPutCode != '', OutPutCode , '-99998');
END;