IMPORT SALT27;
EXPORT StringCleanSpaces(SALT27.StrType s) := 
#if (UseUnicode)
			Unicodelib.UnicodeCleanSpaces(s);
#else
			Stringlib.StringCleanSpaces(s);
#end
