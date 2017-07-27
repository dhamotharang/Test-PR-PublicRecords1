EXPORT FN_Unicode2Flat(unicode str) := FUNCTION
	// lines below take care of flattening specian characters, e.g. Ñ -> N
	s1 := UnicodeLib.UnicodeFindReplace(str,u'Á' ,u'A');
	s2 := UnicodeLib.UnicodeFindReplace(s1,u'É' ,u'E');
	s3 := UnicodeLib.UnicodeFindReplace(s2,u'Í' ,u'I');
	s4 := UnicodeLib.UnicodeFindReplace(s3,u'Ó' ,u'O');																				
	s5 := UnicodeLib.UnicodeFindReplace(s4,u'Ã‘',u'N');																		
	s6 := UnicodeLib.UnicodeFindReplace(s5,u'Ñ' ,u'N');								
	s7 := UnicodeLib.UnicodeFindReplace(s6,u'\301' ,u'A'); // Á in utf-8 octal																
	s8 := UnicodeLib.UnicodeFindReplace(s7,u'\311' ,u'E'); // É in utf-8 octal																
	s9 := UnicodeLib.UnicodeFindReplace(s8,u'\315' ,u'I'); // Í in utf-8 octal																
	s10 := UnicodeLib.UnicodeFindReplace(s9,u'\323' ,u'O'); // Ó in utf-8 octal																
	s11 := UnicodeLib.UnicodeFindReplace(s10,u'\321' ,u'N'); // Ñ in utf-8 octal									
	return s11;
END;