IMPORT SALT25;
EXPORT StringSubstituteOut(SALT25.StrType s, SALT25.StrType w, SALT25.StrType n) := 
#if (UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end