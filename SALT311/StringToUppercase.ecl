IMPORT SALT311;
EXPORT StringToUppercase(SALT311.StrType s) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeToUpperCase(s);
#else
			Stringlib.StringToUpperCase(s);
#end
