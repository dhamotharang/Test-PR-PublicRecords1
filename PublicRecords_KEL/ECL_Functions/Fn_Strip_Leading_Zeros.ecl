EXPORT Fn_Strip_Leading_Zeros(STRING ZeroedNumber) := FUNCTION
	strip_leadingzeroes(STRING number) := REGEXREPLACE('^[ |0]*', TRIM(number, LEFT, RIGHT), '');
	ExceptLeadingZeros  := strip_leadingzeroes(ZeroedNumber); 
	// We have leading zero's and now remove the left over dash - only remove dash if preceeding 0s were found
	RemoveDash := IF(ExceptLeadingZeros != ZeroedNumber AND ExceptLeadingZeros[1..1] = '-', 
		ExceptLeadingZeros[2..], ExceptLeadingZeros);
	RETURN RemoveDash;	
END;