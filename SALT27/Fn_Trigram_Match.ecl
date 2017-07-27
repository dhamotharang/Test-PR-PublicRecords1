IMPORT ut;
// The strings are encoded with Specificity values.  
// <uber specificity> (<string> <specificity>)+
// where specificity values are 100x integers.
EXPORT INTEGER fn_trigram_match(STRING l, STRING r) := FUNCTION
	STRING exPat := '([[:alnum:]]+) ([[:digit:]]+)';
	
	// Get l data
	INTEGER startL := StringLib.StringFind2(l, ' ') + 1;
	INTEGER2 specL := IF(startL>1, (INTEGER) l[1..startL-1], 0);
	STRING wordsL := REGEXREPLACE(exPat, l[startL..], '$1');
	
	// Get r data
	INTEGER startR := StringLib.StringFind2(R, ' ') + 1;
	INTEGER2 specR := IF(startR>1, (INTEGER) r[1..startR-1], 0);
	STRING wordsR := REGEXREPLACE(exPat, r[startR..], '$1');
	
	// Compare
	INTEGER2 simScore := ut.StringSimilar3Gram(wordsL, wordsR, 1000);
	INTEGER2 spec := IF(specL < specR, specL, specR);
	REAL bestScore := (REAL) spec;
	REAL ratio := 1.0 - simScore/1000;
	INTEGER score := ROUND(bestScore - (2.0 * ratio * bestScore));
	
	RETURN score;
END;
