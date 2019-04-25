import ut;
export unsigned4 WordCount(StrType s, string1 sep=' ') := 
#if (UseUnicode)
			unicodelib.UnicodeLocaleWordCount(s, LocaleName);
#else
			ut.NoWords(s, sep);
#end
;

