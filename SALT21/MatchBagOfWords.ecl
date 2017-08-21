StrCmpFnType := ENUM(unsigned1, ExactMatch=0, FuzzyMatch, Phonetic_Match);
// if fn = ExactMatch then fn_arg is ignored
// if fn = FuzzyMatch then fn_arg represents EditDistance radius
// if fn = PhoneticMatch the fn_arg is ENUM(unsigned1, METAPHONE1=0, METAPHONE2, METAPHONE_BOTH)
export integer4 MatchBagOfWords(StrType l, StrType r, unsigned1 mode=0, unsigned1 score_mode=0, StrCmpFnType fn=0, unsigned1 fn_arg=0) := 
#if (UseUnicode)
			saltlib.UnicodeLocaleMatchBagofwords(l, r, LocaleName, mode, score_mode);
#else
			fn_match_bagofwords(l, r, mode, score_mode);
			//saltlib.StringMatchBagofwords(l, r, LocaleName, mode, score_mode, fn, fn_arg);
#end
;
