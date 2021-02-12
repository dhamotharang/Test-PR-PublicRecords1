EXPORT UNSIGNED4 HyphenMatch (StrType l, StrType r, UNSIGNED1 minlen = 1) :=
#if (UnicodeCfg.UseUnicode AND UnicodeCfg.UseLocale)
			saltlib.UnicodeLocaleHyphenMatch(l, r, minlen, UnicodeCfg.LocaleName);
#elseif (UnicodeCfg.UseUnicode AND NOT UnicodeCfg.UseLocale)		
			saltlib.UnicodeHyphenMatch(l, r, minlen);
#else
			fn_hyphen_match(l, r, minlen);
#end
