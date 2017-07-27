/*
Denotes search types which will only give a SSN match if name_last also matches
*/
export isLNameSsnSearch(STRING20 sType) := MAP(sType IN ['IE01','IE02','I500','PSRCH2_FL13Z_C','AAPSRCH2_FL13SZ','PSRCH2_FL13Z_X_5A'] 
																									=> 	true,
																											false
																								);;