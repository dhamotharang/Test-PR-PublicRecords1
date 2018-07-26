IMPORT SALT39;
EXPORT StringSubstituteOut(SALT39.StrType s, SALT39.StrType w, SALT39.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
