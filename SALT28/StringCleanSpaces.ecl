IMPORT SALT28;
EXPORT StringCleanSpaces(SALT28.StrType s) := 
#if (UseUnicode)
			Unicodelib.UnicodeCleanSpaces(s);
#else
			Stringlib.StringCleanSpaces(s);
#end
