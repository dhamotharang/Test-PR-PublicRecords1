IMPORT SALT29;
EXPORT StringSubstituteOut(SALT29.StrType s, SALT29.StrType w, SALT29.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
