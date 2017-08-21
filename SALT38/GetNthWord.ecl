IMPORT SALT38;
EXPORT StrType GetNthWord(StrType s, INTEGER1 n, STRING1 sep=' ') := 
#if (UnicodeCfg.UseUnicode)
			unicodelib.UnicodeLocaleGetNthWord(s, n, UnicodeCfg.LocaleName);
#else
			SALT38.utWord(s, n, sep);
#end
