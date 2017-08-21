export Send_Email(string filedate):= module
							
 export email_list_success := 'Angela.Herzberg@lexisnexis.com';'john.freibaum@lexisnexis.com';
export email_list_failure := 'Angela.Herzberg@lexisnexis.com';'john.freibaum@lexisnexis.com';
	export build_success := fileservices.sendemail(
													'Angela.Herzberg@lexisnexis.com', 'john.freibaum@lexisnexis.com',
													'Experian Phones Build Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												'Angela.Herzberg@lexisnexis.com', 'john.freibaum@lexisnexis.com',
												'Experian Phones '+filedate+' Build FAILED',
												workunit);						
end;