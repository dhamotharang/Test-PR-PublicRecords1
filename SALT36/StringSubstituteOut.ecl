IMPORT SALT36;
EXPORT StringSubstituteOut(SALT36.StrType s, SALT36.StrType w, SALT36.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
