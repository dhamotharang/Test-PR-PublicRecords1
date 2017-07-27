IMPORT SALT37;
EXPORT StringFilterOut(SALT37.StrType s,SALT37.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
