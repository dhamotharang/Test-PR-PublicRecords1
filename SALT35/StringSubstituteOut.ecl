IMPORT SALT35;
EXPORT StringSubstituteOut(SALT35.StrType s, SALT35.StrType w, SALT35.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
