IMPORT SALT44;
EXPORT StringCleanSpaces(SALT44.StrType s) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeCleanSpaces(s);
#else
			Stringlib.StringCleanSpaces(s);
#end
