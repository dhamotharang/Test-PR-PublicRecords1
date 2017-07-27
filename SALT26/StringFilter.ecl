IMPORT SALT26;
EXPORT StringFilter(SALT26.StrType s,SALT26.StrType w) := 
#if (UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
