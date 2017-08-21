IMPORT SALT35;
EXPORT StringFilter(SALT35.StrType s,SALT35.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
