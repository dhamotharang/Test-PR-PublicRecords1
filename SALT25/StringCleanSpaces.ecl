IMPORT SALT25;
EXPORT StringCleanSpaces(SALT25.StrType s) := 
#if (UseUnicode)
			Unicodelib.UnicodeCleanSpaces(s);
#else
			Stringlib.StringCleanSpaces(s);
#end