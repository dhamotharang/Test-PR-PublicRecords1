EXPORT Mailing_List(string st, string ut) := module

	shared Dev_list := 'oscar.barrientos@lexisnexis.com'
										+',Srinivas.Bhimineni@lexisnexisrisk.com'
										// +',Sesha.Nookala@lexisnexisrisk.com'
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

	shared FL_KNOWNFRAUD_list := Dev_list
										// +',oscar.barrientos@lexisnexis.com'
										// +',Srinivas.Bhimineni@lexisnexisrisk.com'
										// +',Jose.Bello@lexisnexis.com'
										;

	shared fn_mail_recipiant(string recipiant) := function
		return		map(
									recipiant='Validation' =>
										map (
													 st = 'FL' and ut = 'IDENTITYDATA'	=> Dev_list
													,st = 'FL' and ut = 'KNOWNFRAUD'		=> Dev_list
													,Dev_list
													)
									,recipiant='Alert' =>
											map (
													 st = 'FL' and ut = 'IDENTITYDATA' 	=> FL_IDENTITYDATA_list
													,st = 'FL' and ut = 'KNOWNFRAUD' 		=> FL_KNOWNFRAUD_list
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