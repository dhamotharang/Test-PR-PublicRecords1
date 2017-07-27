/*
Determines if the search type matches on first initial of first name
*/
export isFInitialSearch(STRING20 sType) := MAP(sType IN ['AFNI_SFL13Z_C'] 
																									=> 	true,
																											false
																								);