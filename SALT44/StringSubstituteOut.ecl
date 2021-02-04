IMPORT SALT44;
EXPORT StringSubstituteOut(SALT44.StrType s, SALT44.StrType w, SALT44.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
