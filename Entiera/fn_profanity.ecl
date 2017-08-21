EXPORT fn_profanity(string pIn):= FUNCTION
	RETURN regexfind(Profanity_Set.Censure, pIn,NOCASE)	AND ~regexfind(Profanity_Set.Exceptions, pIn,NOCASE);
END;