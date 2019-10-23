IMPORT SALT39;
EXPORT StringFilter(SALT39.StrType s,SALT39.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
