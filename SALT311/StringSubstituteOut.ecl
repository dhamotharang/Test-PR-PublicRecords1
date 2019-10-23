IMPORT SALT311;
EXPORT StringSubstituteOut(SALT311.StrType s, SALT311.StrType w, SALT311.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
