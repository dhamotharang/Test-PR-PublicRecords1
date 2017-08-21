IMPORT SALT34;
EXPORT StringFilterOut(SALT34.StrType s,SALT34.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
