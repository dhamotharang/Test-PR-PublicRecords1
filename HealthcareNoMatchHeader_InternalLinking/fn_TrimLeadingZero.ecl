EXPORT fn_TrimLeadingZero(STRING20 s) := REGEXREPLACE('^[0]*',TRIM(s,LEFT,RIGHT),'');
