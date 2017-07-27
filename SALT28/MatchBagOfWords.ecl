// ScoreModeType := ENUM(UNSIGNED1, Many=0, Most, All, Any);
// score_mode is variable of the ScoreModeType type; Defines how the final score is calculated
// mode contains a bit-encoded definition of match mode;
// use SALT28.ConstructMatchMode(edit_distance:=2,edit_max_distance:=4, phonetic:=false, initial:=true, abbr:=true, hyphen:=2, hyphen_min_distance:=1)
// to build it
EXPORT INTEGER4 MatchBagOfWords(StrType l, StrType r, UNSIGNED mode=0, UNSIGNED1 score_mode=0) := 
#if (UseUnicode)
			saltlib.UnicodeLocaleMatchBagofwords(l, r, LocaleName, mode, score_mode);
#else
			//saltlib.StringMatchBagofwords(l, r, mode, score_mode);
			fn_match_bagofwords_fuzzy(l, r, mode, score_mode);
#end
;
