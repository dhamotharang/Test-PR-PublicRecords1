IMPORT SALT44;
EXPORT StringFilterOut(SALT44.StrType s,SALT44.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
