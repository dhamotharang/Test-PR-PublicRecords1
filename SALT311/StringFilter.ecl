IMPORT SALT311;
EXPORT StringFilter(SALT311.StrType s,SALT311.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
