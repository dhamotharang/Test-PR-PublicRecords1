EXPORT Mailing_List(string st, string ut) := module

	shared Dev_list := 'oscar.barrientos@lexisnexis.com'
										// +',Srinivas.Bhimineni@lexisnexisrisk.com'
										// +',oscar.barrientos@lexisnexis.com'
										// +',Jose.Bello@lexisnexis.com'
										;
	shared DOPS_list := 'oscar.barrientos@lexisnexis.com'
										// +',Srinivas.Bhimineni@lexisnexisrisk.com'
										// +',Jose.Bello@lexisnexis.com'
										;

	shared FL_IDENTITYDATA_list := Dev_list
										// +',oscar.barrientos@lexisnexis.com'
										// +',Srinivas.Bhimineni@lexisnexisrisk.com'
										// +',Jose.Bello@lexisnexis.com'
										;
	shared D1_IDENTITYDATA_list := Dev_list
										// +',oscar.barrientos@lexisnexis.com'
										// +',Srinivas.Bhimineni@lexisnexisrisk.com'
										// +',Jose.Bello@lexisnexis.com'
										;
										
	shared FL_KNOWNFRAUD_list := Dev_list
										// +',oscar.barrientos@lexisnexis.com'
										// +',Srinivas.Bhimineni@lexisnexisrisk.com'
										// +',Jose.Bello@lexisnexis.com'
										;

	shared D1_KNOWNFRAUD_list := Dev_list
										// +',oscar.barrientos@lexisnexis.com'
										// +',Srinivas.Bhimineni@lexisnexisrisk.com'
										// +',Jose.Bello@lexisnexis.com'
										;
										
	shared NA_INQUIRYLOGS_list := Dev_list
											// +',oscar.barrientos@lexisnexis.com'
											// +',Srinivas.Bhimineni@lexisnexisrisk.com'
											// +',Jose.Bello@lexisnexis.com'
											;
										
	shared fn_mail_recipiant(string recipiant) := function
		return		map(
									recipiant='Validation' =>
										map (
													 st = 'FL' and ut = 'IDENTITYDATA'	=> Dev_list
													,st = 'D1' and ut = 'IDENTITYDATA'	=> Dev_list
													,st = 'FL' and ut = 'KNOWNFRAUD'		=> Dev_list
													,st = 'D1' and ut = 'KNOWNFRAUD'		=> Dev_list
													,ut = 'INQUIRYLOGS'									=> Dev_list
													,Dev_list
													)
									,recipiant='Alert' =>
											map (
													 st = 'FL' and ut = 'IDENTITYDATA' 	=> FL_IDENTITYDATA_list
													,st = 'D1' and ut = 'IDENTITYDATA' 	=> D1_IDENTITYDATA_list 
													,st = 'FL' and ut = 'KNOWNFRAUD' 		=> FL_KNOWNFRAUD_list
													,st = 'D1' and ut = 'KNOWNFRAUD' 		=> D1_KNOWNFRAUD_list
													,ut = 'INQUIRYLOGS'									=> NA_INQUIRYLOGS_list
													,DOPS_list
													)
									,DOPS_list
									)
									;
	end;

	export Validation := fn_mail_recipiant('Validation');
	export Alert      := fn_mail_recipiant('Alert');
	export BocaOps    := fn_mail_recipiant('BocaOps');

end;