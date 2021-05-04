IMPORT SALT44;
EXPORT StringToUppercase(SALT44.StrType s) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeToUpperCase(s);
#else
			Stringlib.StringToUpperCase(s);
#end
