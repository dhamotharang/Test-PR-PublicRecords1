EXPORT fn_isLNrec(string s) := REGEXFIND('\\<(LEXIS|NEXIS|LEXISNEXIS|SEISINT|MEAD DATA|MEADDATA)\\>', s);