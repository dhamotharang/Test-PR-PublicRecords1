export returnsInput(STRING20 searchType) := MAP(searchType IN ['AAPSRCH2_FL13SZ', 'AFNI_SFL13Z_C','PSRCH2_SSN_C',
																																'PSRCH2_FL13Z_C'/*, 'PSRCH2_FL13Z_X_5A'*/] 
																													=> false,
																													true);

// All possible searches 
// 'IE01','IE02','I500','AAPSRCH2_FL13SZ','AFNI_SFL13Z_C','PSRCH2_SSN_C','PSRCH2_FL13Z_C','PSRCH2_FL13Z_X_5A'

