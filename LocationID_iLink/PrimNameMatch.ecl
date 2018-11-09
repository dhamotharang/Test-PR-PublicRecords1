primNameExcludeRegEx1 := '^[0-9]+(TH|ND|ST|RD)$';
primNameExcludeRegEx2 := '^(TOWNSHIP ROAD|STATE ROUTE|US HIGHWAY|COUNTY ROAD|PRIVATE DRIVE|AVENUE |ROAD |TOWNLINE ROAD |COUNTY HIGHWAY |BOX |MKR |CH |JOINT |JNT |FOUNTAIN SQ|MKR_CH |OH |WR |00|PRIVATE ROAD |TOWNSHIP HIGHWAY|PO BOX |RR |GENERAL DELIVERY)';
primNameExcludeRegEx3 := '^[0-9]+(-| )[0-9]+$';
primNameExcludeRegEx4 := '^CH [[0-9]+ ]+$';
primNameExcludeRegEx5 := '^([0-9]| )+$';
primNameExcludeRegEx6 := '^[0-9][0-9]( |-)[0-9][0-9][0-9][0-9][0-9]';

doubleConsonantRegEx := '(BB|CC|DD|FF|GG|HH|JJ|KK|LL|MM|NN|PP|QQ|RR|SS|TT|VV|WW|XX|YY|ZZ)';

export boolean PrimNameMatch(string28 prim_name1, string28 prim_name2) := function
	matchRegEx1 := regexfind(primNameExcludeRegEx1, trim(prim_name1)) or
	               regexfind(primNameExcludeRegEx1, trim(prim_name2));
	matchRegEx2 := regexfind(primNameExcludeRegEx2, trim(prim_name1)) or
	               regexfind(primNameExcludeRegEx2, trim(prim_name2));
	matchRegEx3 := regexfind(primNameExcludeRegEx3, trim(prim_name1)) or
	               regexfind(primNameExcludeRegEx3, trim(prim_name2));
	matchRegEx4 := regexfind(primNameExcludeRegEx4, trim(prim_name1)) or
	               regexfind(primNameExcludeRegEx4, trim(prim_name2));
	matchRegEx5 := regexfind(primNameExcludeRegEx5, trim(prim_name1)) or
	               regexfind(primNameExcludeRegEx5, trim(prim_name2));
	matchRegEx6 := regexfind(primNameExcludeRegEx6, trim(prim_name1)) or
	               regexfind(primNameExcludeRegEx6, trim(prim_name2));
	tooShort    :=  (length(trim(prim_name1)) = 1) or (length(trim(prim_name2)) = 1);
	
	//Can't match if Road Name starts with TOWNSHIP ROAD, COUNTY HIGHWAY, etc. (COUNTY ROAD 1 vs COUNTRY RD 2)
	condition1 := not(matchRegEx1 or matchRegEx2 or matchRegEx3 or matchRegEx4 or matchRegEx5 or matchRegEx6 or tooShort);
	
	//If match expect for spaces then consider a match (SEA BISCUIT vs SEABISCUIT)
	condition2 := trim(StringLib.StringFilterOut(trim(prim_name1), ' ')) = trim(StringLib.StringFilterOut(trim(prim_name2), ' '));
	
	//IF match except for double consonant then a match is OK: (LAGGERHAM vs LAGERHAM)
	condition3 :=  (regexfind(doubleConsonantRegEx,prim_name1) and not(regexfind(doubleConsonantRegEx,prim_name2)))
	            or (regexfind(doubleConsonantRegEx,prim_name2) and not(regexfind(doubleConsonantRegEx,prim_name1)));
	
	return condition1 and (condition2 or condition3);
end;