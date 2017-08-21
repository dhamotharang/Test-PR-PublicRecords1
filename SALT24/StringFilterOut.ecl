IMPORT SALT24;
EXPORT StringFilterOut(SALT24.StrType s,SALT24.StrType w) := 
#if (UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
