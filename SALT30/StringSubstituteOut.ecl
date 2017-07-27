IMPORT SALT30;
EXPORT StringSubstituteOut(SALT30.StrType s, SALT30.StrType w, SALT30.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
