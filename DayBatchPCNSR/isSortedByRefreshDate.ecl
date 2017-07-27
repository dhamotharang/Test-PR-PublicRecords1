export isSortedByRefreshDate(STRING20 sType) := MAP(sType IN ['AC2A','AC2B','USPAGE_FL13Z','USPAGE_FL137Z','PHA1'] 
																									=> 	true,
																											false
																								);;