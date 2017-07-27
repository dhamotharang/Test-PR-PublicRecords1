export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													'Nirav.Bhatt@lexisnexis.com',
													'ExperianIRSG Build Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												'Nirav.Bhatt@lexisnexis.com',
												'ExperianIRSG '+filedate+' Build FAILED',
												workunit);						
end;

