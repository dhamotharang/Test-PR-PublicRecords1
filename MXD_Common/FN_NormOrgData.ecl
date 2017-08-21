
export Unicode FN_NormOrgData(Unicode dataIn) := FUNCTION
	dataUpper := UnicodeLib.UnicodeToUpperCase(dataIn);
	dataTrim := TRIM(dataUpper);
	d1 := u' ' + UnicodeLib.UnicodeCleanSpaces(dataTrim) + u' ';
	d2 := REGEXREPLACE(u'(,|\\+|_|=|\\{|\\}|\\[|\\]|\\(|\\)|<|>|\\.|[0-9])',d1, u' ');
	d3 := UnicodeLib.UnicodeFindReplace(d2,u' A C G ',u' ACG ');
	d4 := UnicodeLib.UnicodeFindReplace(d3,u' A C B ',u' ACB ');
	d5 := UnicodeLib.UnicodeFindReplace(d4,u' A C H ',u' ACH ');
	d6 := UnicodeLib.UnicodeFindReplace(d5,u' A C A ',u' ACA ');
	d7 := UnicodeLib.UnicodeFindReplace(d6,u' A C V ',u' ACV ');

	beforereplace := d7;
	
	f1 := REGEXREPLACE(u'( SA DE CV | SRL DE CV | S A DE CV | SACV | A DE CV | DE CV | DE R L | S RL | SRL | SFRLCV | INC | SRLCV | CO | DE C V | CV | SA | S C | R L | F K A | FKA )',beforereplace, u' ');
	
	f2 := REGEXREPLACE(u'( DE | DEL | A LA | AND | LA | EN | EL | LOS | Y | E | ET AL | S A | AR | SC | F R L )',f1, u' ');
	f3 := if (f2 != u' AC ',UnicodeLib.UnicodeFindReplace(f2,u' AC ',u' '),f2);
	f4 := if (f3 != u' A C ',UnicodeLib.UnicodeFindReplace(f3,u' A C ',u' '),u' AC ');
	
	// d7 := UnicodeLib.UnicodeFindReplace(d6,u' S ',u' ');
	// d9 := UnicodeLib.UnicodeFindReplace(d8,u' S A ',u' ');

	return f4;
END;