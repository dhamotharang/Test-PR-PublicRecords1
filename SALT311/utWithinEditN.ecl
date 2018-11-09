alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT BOOLEAN utWithinEditN(STRING l,STRING r,UNSIGNED1 d, UNSIGNED1 mode=alg.Standard) := utWithinEditN_WithLengths(l,LENGTH(TRIM(l)),r,LENGTH(TRIM(r)),d,mode);
