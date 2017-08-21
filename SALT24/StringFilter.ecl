IMPORT SALT24;
EXPORT StringFilter(SALT24.StrType s,SALT24.StrType w) := 
#if (UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
