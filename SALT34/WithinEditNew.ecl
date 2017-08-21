/*
	If edit_threshold is set, then use EDIT1 for short strings, and EDIT2 for long string
	Otherwise use provided distance 'd'
*/
IMPORT ut;
EXPORT BOOLEAN WithinEditNew(StrType l,UNSIGNED1 ll, StrType r,UNSIGNED1 rl,UNSIGNED1 d, UNSIGNED1 edit_threshold=0) := FUNCTION
	distance := MAP(edit_threshold=0 =>d,
									((ll+rl)=0) AND edit_threshold>MIN(LENGTH(TRIM(l)),LENGTH(TRIM(r))) => 1,
									((ll+rl)>0) AND edit_threshold>MIN(ll,rl) => 1,
									2);
#if (UnicodeCfg.UseUnicode AND UnicodeCfg.UseLocale)
	res := saltlib.UnicodeLocaleWithinEditN(l, r, distance, UnicodeCfg.LocaleName);
#elseif (UnicodeCfg.UseUnicode AND NOT UnicodeCfg.UseLocale)		
	res := saltlib.UnicodeWithinEditN(l, r, distance);
#else
	res := IF(ll+rl>0, ut.WithinEditN_WithLengths(l, ll,r, rl, distance), ut.WithinEditN(l, r, distance));
#end
	RETURN res;
END;
