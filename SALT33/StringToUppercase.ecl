IMPORT SALT33;
EXPORT StringToUppercase(SALT33.StrType s) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeToUpperCase(s);
#else
			Stringlib.StringToUpperCase(s);
#end
