export ConvertYYYYMMToNumberOfMonths(integer pInput) := 
	 (((integer)(((STRING)pInput)[1..4])*12) + ((integer)(((STRING)pInput)[5..6])));