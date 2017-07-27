IMPORT SALT27;
EXPORT StringSubstituteOut(SALT27.StrType s, SALT27.StrType w, SALT27.StrType n) := 
#if (UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
