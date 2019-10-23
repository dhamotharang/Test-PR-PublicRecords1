IMPORT SALT39;
EXPORT StringToUppercase(SALT39.StrType s) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeToUpperCase(s);
#else
			Stringlib.StringToUpperCase(s);
#end
