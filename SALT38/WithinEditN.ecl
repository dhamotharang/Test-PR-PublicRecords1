/*
	If edit_threshold is set, then use EDIT1 for short strings, and EDIT2 for long string
	Otherwise use provided distance 'd'
*/
IMPORT SALT38;
EXPORT BOOLEAN WithinEditN(StrType l, StrType r, UNSIGNED1 d, UNSIGNED1 edit_threshold=0, BOOLEAN edFunction(STRING l,STRING r,UNSIGNED1 d,UNSIGNED1 mode=0) = SALT38.utWithinEditN) := FUNCTION
	distance := MAP(edit_threshold=0 =>d,
									edit_threshold>MIN(LENGTH(TRIM(l)),LENGTH(TRIM(r))) => 1,
									2);
#if (UnicodeCfg.UseUnicode AND UnicodeCfg.UseLocale)
	res := saltlib.UnicodeLocaleWithinEditN(l, r, distance, UnicodeCfg.LocaleName);
#elseif (UnicodeCfg.UseUnicode AND NOT UnicodeCfg.UseLocale)		
	res := saltlib.UnicodeWithinEditN(l, r, distance);
#else
	res := edFunction(l, r, distance);
#end
	RETURN res;
END;
