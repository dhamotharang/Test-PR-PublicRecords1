StrCmpFnType := ENUM(UNSIGNED1, ExactMatch=0, FuzzyMatch, Phonetic_Match);
// if fn = ExactMatch then fn_arg1 and fn_arg2 are ignored
// if fn = FuzzyMatch then fn_arg1 represents EditDistance radius, and fn_arg2 represents maximum cumulative distance
// if fn = PhoneticMatch the fn_arg1 is ENUM(unsigned1, METAPHONE1=0, METAPHONE2, METAPHONE_BOTH), and fn_arg2 is ignored
EXPORT INTEGER4 MatchBagOfWords(StrType l, StrType r, UNSIGNED1 mode=0, UNSIGNED1 score_mode=0, StrCmpFnType fn=0, UNSIGNED1 fn_arg1=0,UNSIGNED1 fn_arg2=0) := 
#if (UseUnicode)
			saltlib.UnicodeLocaleMatchBagofwords(l, r, LocaleName, mode, score_mode);
#else
			IF(fn=1,fn_match_bagofwords_fuzzy(l, r, mode, score_mode, fn, fn_arg1, fn_arg2),fn_match_bagofwords(l, r, mode, score_mode));
			//saltlib.StringMatchBagofwords(l, r, mode, score_mode, fn, fn_arg1, fn_arg2);
#end
;
