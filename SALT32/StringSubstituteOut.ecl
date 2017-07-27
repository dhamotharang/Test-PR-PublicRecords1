IMPORT SALT32;
EXPORT StringSubstituteOut(SALT32.StrType s, SALT32.StrType w, SALT32.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
