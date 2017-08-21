export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													'Angela.Herzberg@lexisnexis.com; michael.gould@lexisnexis.com;Gabriel.Marcan@lexisnexis.com',
													'ExperianCred Build Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												'Angela.Herzberg@lexisnexis.com; michael.gould@lexisnexis.com;Gabriel.Marcan@lexisnexis.com',
												'ExperianCred '+filedate+' Build FAILED',
												workunit);						
end;