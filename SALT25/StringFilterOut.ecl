IMPORT SALT25;
EXPORT StringFilterOut(SALT25.StrType s,SALT25.StrType w) := 
#if (UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
