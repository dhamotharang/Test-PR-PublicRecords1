IMPORT SALT31;
EXPORT StringCleanSpaces(SALT31.StrType s) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeCleanSpaces(s);
#else
			Stringlib.StringCleanSpaces(s);
#end
