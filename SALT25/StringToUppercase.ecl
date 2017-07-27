IMPORT SALT25;
EXPORT StringToUppercase(SALT25.StrType s) := 
#if (UseUnicode)
			Unicodelib.UnicodeToUpperCase(s);
#else
			Stringlib.StringToUpperCase(s);
#end
