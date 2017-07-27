IMPORT SALT37;
EXPORT StringFilter(SALT37.StrType s,SALT37.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
