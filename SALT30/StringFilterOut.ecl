IMPORT SALT30;
EXPORT StringFilterOut(SALT30.StrType s,SALT30.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
