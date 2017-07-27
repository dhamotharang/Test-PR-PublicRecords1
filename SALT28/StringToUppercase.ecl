IMPORT SALT28;
EXPORT StringToUppercase(SALT28.StrType s) := 
#if (UseUnicode)
			Unicodelib.UnicodeToUpperCase(s);
#else
			Stringlib.StringToUpperCase(s);
#end
