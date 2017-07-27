IMPORT SALT27;
EXPORT StringToUppercase(SALT27.StrType s) := 
#if (UseUnicode)
			Unicodelib.UnicodeToUpperCase(s);
#else
			Stringlib.StringToUpperCase(s);
#end
