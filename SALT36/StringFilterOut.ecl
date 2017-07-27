IMPORT SALT36;
EXPORT StringFilterOut(SALT36.StrType s,SALT36.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
