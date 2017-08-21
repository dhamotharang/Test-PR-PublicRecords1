IMPORT SALT24;
EXPORT StringToUppercase(SALT24.StrType s) := 
#if (UseUnicode)
			Unicodelib.UnicodeToUpperCase(s);
#else
			Stringlib.StringToUpperCase(s);
#end
