IMPORT SALT44;
EXPORT StringFilter(SALT44.StrType s,SALT44.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
