IMPORT SALT38;
EXPORT StringFilterOut(SALT38.StrType s,SALT38.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
