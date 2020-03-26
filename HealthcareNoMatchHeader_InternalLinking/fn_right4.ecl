EXPORT fn_right4(STRING s) := IF(LENGTH(TRIM(s))>4,s[LENGTH(TRIM(s))-3..],s);
