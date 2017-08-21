IMPORT SALT34;
EXPORT StringFilter(SALT34.StrType s,SALT34.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
