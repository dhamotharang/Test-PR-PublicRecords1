import STD;

alphanum := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_\'';

export DATASET WordSplit(string s) := 
/*					PROJECT(
						DATASET(
							Std.Str.SplitWords(Std.Str.CleanSpaces(Std.Str.SubstituteExcluded(s, alphanum, ' ')), ' '),
						{string32 word}),
						TRANSFORM({string32 word},
							self.word := REGEXREPLACE('(.+)(\')$',TRIM(REGEXREPLACE('^\'', LEFT.word, '')),'$1');
						));
*/
  DATASET(REGEXFINDSET('[A-Z0-9_\']+', s), {string32 word});


/*
	 PROJECT(DATASET(Address.TokenManagement.TokenSet(s,Address.TokenManagement.TokenCount(s)), {string32 word}),
					TRANSFORM({string32 word},
							self.word := REGEXREPLACE('(.+)(\')$',TRIM(REGEXREPLACE('^\'', LEFT.word, '')),'$1');
							));
*/
