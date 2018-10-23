export fn_TrimLeadingZero(string20 s) := REGEXREPLACE('^[0]*',TRIM(s,LEFT,RIGHT),'');
