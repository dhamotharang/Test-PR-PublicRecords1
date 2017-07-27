IMPORT SALT33;
EXPORT StringFilterOut(SALT33.StrType s,SALT33.StrType w) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
