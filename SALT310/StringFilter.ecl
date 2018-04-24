IMPORT SALT310;
EXPORT StringFilter(SALT310.StrType s,SALT310.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
