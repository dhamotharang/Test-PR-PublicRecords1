import ut;
export boolean WithinEditN(StrType l, StrType r, unsigned1 d) := 
#if (UseUnicode)
			unicodelib.UnicodeLocaleEditDistanceWithinRadius(l, r, d, LocaleName);
#else
			ut.WithinEditN(l, r, d);
#end
