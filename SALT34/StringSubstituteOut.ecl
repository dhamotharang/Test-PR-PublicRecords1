IMPORT SALT34;
EXPORT StringSubstituteOut(SALT34.StrType s, SALT34.StrType w, SALT34.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
