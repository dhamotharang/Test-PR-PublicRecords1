alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT BOOLEAN fn_EditDistance(StrType l, UNSIGNED1 ll, StrType r, UNSIGNED1 rl, UNSIGNED1 d, UNSIGNED1 mode=alg.Standard) := FUNCTION
#if (UnicodeCfg.UseUnicode AND UnicodeCfg.UseLocale)
	res := saltlib.UnicodeLocaleWithinEditN(l, r, d, UnicodeCfg.LocaleName);
#elseif (UnicodeCfg.UseUnicode AND NOT UnicodeCfg.UseLocale)		
	res := saltlib.UnicodeWithinEditN(l, r, d);
#else
	res := utWithinEditN_WithLengths(l, ll,r, rl, d, mode);
#end
	RETURN res;
END;
