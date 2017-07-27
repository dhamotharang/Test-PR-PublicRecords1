IMPORT SALT32;
EXPORT StringFilterOut(SALT32.StrType s,SALT32.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
