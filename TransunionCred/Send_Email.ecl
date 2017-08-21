export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													'aherzberg@seisint.com,michael.gould@lexisnexis.com',
													'TransunionCred Build Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												'aherzberg@seisint.com,michael.gould@lexisnexis.com',
												'TransunionCred '+filedate+' Build FAILED',
												workunit);						
end;