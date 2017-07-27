IMPORT SALT31;
EXPORT StringSubstituteOut(SALT31.StrType s, SALT31.StrType w, SALT31.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
