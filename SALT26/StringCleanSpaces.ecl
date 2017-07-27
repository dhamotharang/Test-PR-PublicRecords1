IMPORT SALT26;
EXPORT StringCleanSpaces(SALT26.StrType s) := 
#if (UseUnicode)
			Unicodelib.UnicodeCleanSpaces(s);
#else
			Stringlib.StringCleanSpaces(s);
#end
