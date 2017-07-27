IMPORT SALT26;
EXPORT StringToUppercase(SALT26.StrType s) := 
#if (UseUnicode)
			Unicodelib.UnicodeToUpperCase(s);
#else
			Stringlib.StringToUpperCase(s);
#end
