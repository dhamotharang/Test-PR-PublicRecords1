export format_real(REAL r, UNSIGNED1 chars) :=
FUNCTION

	FirstN := TRIM(((STRING)r)[1..chars]);
	isWhole := LENGTH(FirstN)=1;
	extraZeros := '000'[1..chars-LENGTH(FirstN)];
	
	
	RETURN FirstN + IF(isWhole,'.000',extraZeros);
END;