IMPORT SALT36;
EXPORT StringFilter(SALT36.StrType s,SALT36.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
