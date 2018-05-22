IMPORT SALT311;
EXPORT StringFilterOut(SALT311.StrType s,SALT311.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
