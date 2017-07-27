IMPORT SALT33;
EXPORT StringFilter(SALT33.StrType s,SALT33.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilter(s,w);
#else
			StringLib.StringFilter(s,w);
#end
