export ConvertYYYYMMToNumberOfMonths(integer pInput) := 
	 (((integer)(((string)pInput)[1..4])*12) + ((integer)(((string)pInput)[5..6])));