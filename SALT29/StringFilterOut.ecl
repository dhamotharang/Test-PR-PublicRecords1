IMPORT SALT29;
EXPORT StringFilterOut(SALT29.StrType s,SALT29.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
