IMPORT SALT25;
EXPORT StringFilter(SALT25.StrType s,SALT25.StrType w) := 
#if (UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
