rec := RECORD
	STRING32	word;
END;

rec pairup(rec l, rec r) := TRANSFORM
	self.word := IF (TRIM(r.word)='', SKIP, TRIM(l.word) + ' ' + TRIM(r.word));
END;

// cannot use this because it causes unsupported "child queries"
//export WordPairs(DATASET(rec) ds) := COMBINE(ds, ds[2..] + DATASET([{''}],rec), pairup(LEFT,RIGHT));



export DATASET WordPairs(DATASET(rec) ds) := FUNCTION

	s := SET(ds, word);
	
	SET OF STRING32 words := 
	[
		IF(COUNT(s) >= 2, TRIM(s[1]) + ' ' + TRIM(s[2]), ''),
		IF(COUNT(s) >= 3, TRIM(s[2]) + ' ' + TRIM(s[3]), ''),
		IF(COUNT(s) >= 4, TRIM(s[3]) + ' ' + TRIM(s[4]), ''),
		IF(COUNT(s) >= 5, TRIM(s[4]) + ' ' + TRIM(s[5]), ''),
		IF(COUNT(s) >= 6, TRIM(s[5]) + ' ' + TRIM(s[6]), ''),
		IF(COUNT(s) >= 7, TRIM(s[6]) + ' ' + TRIM(s[7]), ''),
		IF(COUNT(s) >= 8, TRIM(s[7]) + ' ' + TRIM(s[8]), ''),
		IF(COUNT(s) >= 9, TRIM(s[8]) + ' ' + TRIM(s[9]), ''),
		IF(COUNT(s) >= 10, TRIM(s[9]) + ' ' + TRIM(s[10]), '')
	];

	return DATASET(words, rec)(word != '');
END;



/*rgx := '([A-Z]+)([^A-Z]+)?([A-Z-]+)?([^A-Z]+)?([A-Z-]+)?([^A-Z]+)?([A-Z-]+)?([^A-Z]+)?([A-Z-]+)?([^A-Z]+)?([A-Z-]+)?([^A-Z]+)?([A-Z-]+)?([^A-Z]+)?([A-Z-]+)?';

rgx1 := '^([A-Z]+[^A-Z]+[A-Z]+)';
rgx2 := '^([A-Z]+[^A-Z]+)([A-Z]+[^A-Z]+[A-Z]+)';
rgx3 := '^([A-Z]+[^A-Z]+[A-Z]+[^A-Z]+)([A-Z]+[^A-Z]+[A-Z]+)';

export DATASET WordPairs(string s) := FUNCTION

	SET OF STRING32 words := 
	[
		REGEXFIND(rgx1, s, 1, NOCASE),
		REGEXFIND(rgx2, s, 2, NOCASE),
		REGEXFIND(rgx3, s, 2, NOCASE)
	];
	
	return DATASET(words, rec)(word != '');
END;
*/
