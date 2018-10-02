/*
	If edit_threshold is set, then use EDIT1 for short strings, and EDIT2 for long string
	Otherwise use provided distance 'd'
*/
alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT BOOLEAN WithinEditNew(StrType l,UNSIGNED1 ll, StrType r,UNSIGNED1 rl,UNSIGNED1 d, UNSIGNED1 edit_threshold=0,UNSIGNED1 mode=alg.Standard, BOOLEAN edFunction(StrType l,UNSIGNED1 ll, StrType r,UNSIGNED1 rl,UNSIGNED1 d,UNSIGNED1 mode) = fn_EditDistance) := FUNCTION
  lLen := IF(ll+rl>0,ll,LENGTH(TRIM(l)));
	rLen := IF(ll+rl>0,rl,LENGTH(TRIM(r)));
	distance := MAP(edit_threshold=0 =>d,
	                edit_threshold>MIN(lLen,rLen) => 1,
									2);
									
	RETURN edFunction(l,lLen,r,rLen,distance,mode);								
END;
