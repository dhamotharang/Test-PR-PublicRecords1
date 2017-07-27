IMPORT SALT31;
EXPORT StringFilter(SALT31.StrType s,SALT31.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
