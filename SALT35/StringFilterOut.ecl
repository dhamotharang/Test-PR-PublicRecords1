IMPORT SALT35;
EXPORT StringFilterOut(SALT35.StrType s,SALT35.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
