/*
Determines if the search type is allowed to use glba sources
Permissible use is still determined by value passed in with search for that customer
*/
export isGlbaSearch(STRING20 sType) := MAP(sType IN ['IE02','I500','AAPSRCH2_FL13SZ','AFNI_SFL13Z_C',
																										'PSRCH2_SSN_C','PSRCH2_FL13Z_C','PSRCH2_FL13Z_X_5A']
																									=> 	true,
																											false
																								);
																								



