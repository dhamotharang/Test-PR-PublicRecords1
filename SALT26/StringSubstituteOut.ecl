IMPORT SALT26;
EXPORT StringSubstituteOut(SALT26.StrType s, SALT26.StrType w, SALT26.StrType n) := 
#if (UseUnicode)
			Unicodelib.UnicodeSubstituteOut(s, w, n);
#else
			Stringlib.StringSubstituteOut(s, w, n);
#end
