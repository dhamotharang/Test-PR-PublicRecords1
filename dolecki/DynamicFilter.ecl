STRING replaceQuotes(STRING s)   := REGEXREPLACE('"',s,'\'');
STRING handleNotRegex(STRING s)  := REGEXREPLACE('NOTREGEX\\(([^\\(\\)]*)\\)',s,'~REGEXFIND($1,COLUMN_NAME)');
STRING handleRegex(STRING s)     := REGEXREPLACE('REGEX\\(([^\\(\\)]*)\\)',s,'REGEXFIND($1,COLUMN_NAME)');
STRING handleNotMatch(STRING s)  := REGEXREPLACE('NOTMATCH\\(([^\\(\\)]*)\\)',s,'COLUMN_NAME <> $1');
STRING handleMatch(STRING s)     := REGEXREPLACE('MATCH\\(([^\\(\\)]*)\\)',s,'COLUMN_NAME = $1');
STRING handleGT(STRING s)        := REGEXREPLACE('GT\\(([^\\(\\)]*)\\)',s,'COLUMN_NAME > $1');
STRING handleGTE(STRING s)       := REGEXREPLACE('GTE\\(([^\\(\\)]*)\\)',s,'COLUMN_NAME >= $1');
STRING handleLT(STRING s)        := REGEXREPLACE('LT\\(([^\\(\\)]*)\\)',s,'COLUMN_NAME < $1');
STRING handleLTE(STRING s)       := REGEXREPLACE('LTE\\(([^\\(\\)]*)\\)',s,'COLUMN_NAME <= $1');
STRING handleEQ(STRING s)        := REGEXREPLACE('EQ\\(([^\\(\\)]*)\\)',s,'COLUMN_NAME = $1');

STRING insertColumnName(STRING s, STRING column_name) := REGEXREPLACE('COLUMN_NAME',s,column_name);

STRING constructFilter(STRING s, STRING column_name) := FUNCTION
	t1 := handleNotRegex(s);
	t2 := handleRegex(t1);

	t3 := handleNotMatch(t2);
	t4 := handleMatch(t3);

	t5 := handleGT(t4);
	t6 := handleGTE(t5);

	t7 := handleLT(t6);
	t8 := handleLTE(t7);

	t9 := handleEQ(t8);
	
	t10 := insertColumnName(t9,column_name);
	
	return t10;
END;

BOOLEAN isDirective(STRING s) := IF(length(s)>1 AND s[1] = '#',true,false);

STRING createFilter(STRING filter, STRING column_name) := FUNCTION
	return MAP(
		isDirective(filter) => constructFilter(filter[2..],column_name),
		column_name + ' = ' + filter
	);
END;

export DynamicFilter(STRING filter, STRING column_name) := FUNCTION
	return createFilter(replaceQuotes(filter),column_name);
END;