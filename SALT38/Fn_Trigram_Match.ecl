IMPORT STD;
// The strings are encoded with Specificity values.  
// <uber specificity> (<string> <specificity>)+
// where specificity values are 100x integers.
EXPORT INTEGER fn_trigram_match(StrType l, StrType r) := FUNCTION
	StrType exPat := '([[:alnum:]]+) ([[:digit:]]+)';
	
	// Get l data
	#if (UnicodeCfg.UseUnicode)
		INTEGER startL := STD.Uni.Find(l, ' ',1) + 1;	
	#else
		INTEGER startL := STD.Str.Find(l, ' ',1) + 1;
	#end
	INTEGER2 specL := IF(startL>1, (INTEGER) l[1..startL-1], 0);
	StrType wordsL := REGEXREPLACE(exPat, l[startL..], '$1');
	
	// Get r data
	#if (UnicodeCfg.UseUnicode)
		INTEGER startR := STD.Uni.Find(r, ' ',1) + 1;	
	#else
		INTEGER startR := STD.Str.Find(r, ' ',1) + 1;
	#end
	INTEGER2 specR := IF(startR>1, (INTEGER) r[1..startR-1], 0);
	StrType wordsR := REGEXREPLACE(exPat, r[startR..], '$1');
	
	// Compare
	#if (UnicodeCfg.UseUnicode)
		INTEGER2 simScore := Trigram.compare_unicode(wordsL,wordsR);	
	#else
		INTEGER2 simScore := Trigram.compare_string(wordsL,wordsR);
	#end
	INTEGER2 spec := IF(specL < specR, specL, specR);
	REAL bestScore := (REAL) spec;
	REAL ratio := 1.0 - simScore/1000;
	INTEGER score := ROUND(bestScore - (2.0 * ratio * bestScore));
	
	RETURN score;
END;
