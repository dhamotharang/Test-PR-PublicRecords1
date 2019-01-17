IMPORT SALT38;
EXPORT StringSubstituteOut(SALT38.StrType s, SALT38.StrType w, SALT38.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
