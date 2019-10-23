IMPORT SALT39;
EXPORT StringFilterOut(SALT39.StrType s,SALT39.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
