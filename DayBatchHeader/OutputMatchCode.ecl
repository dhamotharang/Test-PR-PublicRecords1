/*
Returns an output match code converted from the standard FL137ZS format into a search specific code
*/
export OutputMatchCode(boolean isHit, STRING10 matchCode,STRING20 search):= 
												MAP(isHit AND search IN ['AFNI_SFL13Z_C'] 
															AND stringLib.StringContains(matchCode,'S',false)
													=> '1',		// ssn match
												isHit AND search IN ['AFNI_SFL13Z_C'] 
															AND matchCode IN ['FL137Z','FL13Z']
													=> '2',		// full name and addr match
												isHit AND search IN ['AFNI_SFL13Z_C'] 
															AND matchCode IN ['fL137Z','fL13Z']
													=> '3',		// first initial addr match
												isHit AND search IN ['AFNI_SFL13Z_C'] 
															AND matchCode IN ['L137Z','L13Z']
													=> '4',		// last name addr match
												// AAPSRCH2_FL13SZ matchCode output is always FLASZ on a hit
												isHit AND search IN ['AAPSRCH2_FL13SZ']
													=> 'FLASZ',
												isHit => matchCode,
													'');