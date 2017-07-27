IMPORT SALT31;
EXPORT StringFilterOut(SALT31.StrType s,SALT31.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
