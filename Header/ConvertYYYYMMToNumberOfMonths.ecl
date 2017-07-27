export ConvertYYYYMMToNumberOfMonths(integer pInput) := 
	 (((integer)(pInput[1..4])*12) + ((integer)(pInput[5..6])));