IMPORT SALT27;
EXPORT StringFilter(SALT27.StrType s,SALT27.StrType w) := 
#if (UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
