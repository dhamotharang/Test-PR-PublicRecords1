export isFuzzyNameSearch(STRING20 sType) := MAP(sType IN ['IE01','IE02','I500'] 
																									=> 	true,
																											false
																								);;