IMPORT SALT32;
EXPORT StringCleanSpaces(SALT32.StrType s) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeCleanSpaces(s);
#else
			Stringlib.StringCleanSpaces(s);
#end
