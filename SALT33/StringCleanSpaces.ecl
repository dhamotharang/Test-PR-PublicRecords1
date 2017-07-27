IMPORT SALT33;
EXPORT StringCleanSpaces(SALT33.StrType s) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeCleanSpaces(s);
#else
			Stringlib.StringCleanSpaces(s);
#end
