export isLNameAddrSearch(STRING20 sType) := MAP(sType IN ['IE01','IE02','I500','PSRCH2_FL13Z_C','PSRCH2_SSN_C','AAPSRCH2_FL13SZ','AFNI_SFL13Z_C','PSRCH2_FL13Z_X_5A'] 
																									=> 	true,
																											false
																								);;