IMPORT SALT310;
EXPORT StringFilterOut(SALT310.StrType s,SALT310.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
