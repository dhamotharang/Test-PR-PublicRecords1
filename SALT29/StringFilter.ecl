IMPORT SALT29;
EXPORT StringFilter(SALT29.StrType s,SALT29.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
