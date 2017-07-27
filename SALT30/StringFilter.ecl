IMPORT SALT30;
EXPORT StringFilter(SALT30.StrType s,SALT30.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
