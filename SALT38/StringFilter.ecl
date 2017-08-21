IMPORT SALT38;
EXPORT StringFilter(SALT38.StrType s,SALT38.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
