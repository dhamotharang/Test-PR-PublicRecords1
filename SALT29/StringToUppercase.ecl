IMPORT SALT29;
EXPORT StringToUppercase(SALT29.StrType s) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeToUpperCase(s);
#else
			Stringlib.StringToUpperCase(s);
#end
