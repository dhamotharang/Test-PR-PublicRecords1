// ScoreModeType := ENUM(UNSIGNED1, Many=0, Most, All, Any);
// score_mode is variable of the ScoreModeType type; Defines how the final score is calculated
// mode contains a bit-encoded definition of match mode;
// use SALT310.ConstructMatchMode(edit_distance:=2,edit_max_distance:=4, phonetic:=false, initial:=true, abbr:=true, abbt_type:=0, hyphen:=2, hyphen_min_distance:=1)
// to build it
EXPORT INTEGER4 MatchBagOfWords(StrType l, StrType r, UNSIGNED mode=0, UNSIGNED1 score_mode=0) := 
#if (UnicodeCfg.UseUnicode AND UnicodeCfg.UseLocale)
			//saltlib.UnicodeLocaleMatchBagofwords(l, r, UnicodeCfg.LocaleName, mode, score_mode);
			saltlib.UnicodeLocaleMatchBagofwords2(l, r, UnicodeCfg.LocaleName, mode, score_mode);
#elseif (UnicodeCfg.UseUnicode AND NOT UnicodeCfg.UseLocale)		
			//saltlib.UnicodeLocaleMatchBagofwords(l, r, UnicodeCfg.LocaleName, mode, score_mode);
			saltlib.UnicodeMatchBagofwords2(l, r, mode, score_mode);	
#else
			Fn_Match_Bagofwords_fuzzy(l, r, mode, score_mode);
			//saltlib.StringMatchBagofwords2(l, r, mode, score_mode);
#end
;
