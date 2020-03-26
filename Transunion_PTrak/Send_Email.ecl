EXPORT Send_Email(string filedate):= MODULE
							
	SHARED	dev:= 'Gabriel.Marcan@lexisnexisrisk.com,';
	SHARED	ops:= 'Harry.Gist@lexisnexisrisk.com';
	EXPORT	build_success := fileservices.sendemail(
													dev+ops,
													'TUCS Build Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	EXPORT	build_failure := fileservices.sendemail(
													dev+ops,
													'TUCS '+filedate+' Build FAILED',
													workunit);						
END;