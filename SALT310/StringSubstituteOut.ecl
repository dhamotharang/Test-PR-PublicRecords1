IMPORT SALT310;
EXPORT StringSubstituteOut(SALT310.StrType s, SALT310.StrType w, SALT310.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
