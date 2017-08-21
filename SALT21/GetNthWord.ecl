import ut;

export StrType GetNthWord(StrType s, integer1 n, string1 sep=' ') := 
#if (UseUnicode)
			unicodelib.UnicodeLocaleGetNthWord(s, n, LocaleName);
#else
			ut.Word(s, n, sep);
#end

