IMPORT ut;
EXPORT UNSIGNED4 WordCount(StrType s, STRING1 sep=' ') := 
#if (UnicodeCfg.UseUnicode)
			unicodelib.UnicodeLocaleWordCount(s, UnicodeCfg.LocaleName);
#else
			ut.NoWords(s, sep);
#end
;
