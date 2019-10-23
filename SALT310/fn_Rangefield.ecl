EXPORT REAL fn_Rangefield(REAL weight, REAL AvgDelay, REAL diff) := FUNCTION
	res1 := weight * EXP(-ABS(diff)/AvgDelay);
	//res := IF(res1 < 50, -1.000 * sweight, res1);
	RETURN res1;
END;
