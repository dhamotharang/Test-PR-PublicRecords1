IMPORT SALT33;
EXPORT StringSubstituteOut(SALT33.StrType s, SALT33.StrType w, SALT33.StrType n) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
