IMPORT SALT26;
EXPORT StringFilterOut(SALT26.StrType s,SALT26.StrType w) := 
#if (UseUnicode)
			Unicodelib.UnicodeFilterOut(s,w);
#else
			StringLib.StringFilterOut(s,w);
#end
