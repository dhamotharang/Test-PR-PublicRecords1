// This function performs WB matching based on a multiple matching definitions encoded in the command;
// Function returns the best score, or -9999 if all the matches fail their respective force tests
// commands - a radix 16 encoded string representing column-separated matching definitions
// commands = 'command1:command2:...:commandN'
// commandI - a radix16 encoded string representing |-separated match mode, force and scoremode
// commandI='modeI|forcesI|score_modeI'
// ScoreMode := ENUM(UNSIGNED1, Many=0, Most, All, Any);
EXPORT INTEGER4 MatchBagOfWordsMultiway(StrType l, StrType r, STRING command) := 
#if (UnicodeCfg.UseUnicode AND UnicodeCfg.UseLocale)
			saltlib.UnicodeLocaleMatchBagofwordsMultiway(l, r, UnicodeCfg.LocaleName, command);
#elseif (UnicodeCfg.UseUnicode AND NOT UnicodeCfg.UseLocale)		
			saltlib.UnicodeMatchBagofwordsMultiway(l, r, command);	
#else
			Fn_Match_Bagofwords_Multiway(l, r, command);
			//saltlib.StringMatchBagofwordsMultiway(l, r, command);
#end
;
