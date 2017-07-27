export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													'jose.bello@lexisnexis.com',
													'TransunionCred Build Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												'jose.bello@lexisnexis.com',
												'TransunionCred '+filedate+' Build FAILED',
												workunit);						
end;