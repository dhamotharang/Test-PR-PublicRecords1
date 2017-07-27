IMPORT SALT27;
EXPORT StringFilterOut(SALT27.StrType s,SALT27.StrType w) := 
#if (UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
