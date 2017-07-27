IMPORT SALT37;
EXPORT StringSubstituteOut(SALT37.StrType s, SALT37.StrType w, SALT37.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
