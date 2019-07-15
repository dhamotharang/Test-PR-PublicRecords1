import	STD;
/*
rec := RECORD
	STRING32	word;
END;

rec x(rec w1, rec w2, integer n) := 
		TRANSFORM	
 				self.word := if(n=1,'', 
												if(n=2,
												TRIM(Std.Str.GetNthWord(w1.word,1)) + ' ',
												TRIM(Std.Str.GetNthWord(w1.word,2)) + ' ')) + TRIM(w2.word);
		END;

export DATASET WordPairs(DATASET(rec) ds) := Iterate(ds, x(LEFT, RIGHT, COUNTER))[2..];
*/
rgxWordPair := '[A-Z0-9_\']+ +[A-Z0-9_\']+';
alphanum := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_\'';
export WordPairs(string s1) := FUNCTION
	s := Std.Str.CleanSpaces(Std.Str.SubstituteExcluded(s1, alphanum,' '));
  y := REGEXFINDSET(rgxWordPair, s) + REGEXFINDSET(rgxWordPair, STD.Str.ExcludeFirstWord(s));
	return dataset(y, {string32 word});

END;
