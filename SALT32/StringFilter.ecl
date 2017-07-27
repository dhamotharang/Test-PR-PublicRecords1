IMPORT SALT32;
EXPORT StringFilter(SALT32.StrType s,SALT32.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
