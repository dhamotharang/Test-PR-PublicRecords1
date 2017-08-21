export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													'David.Lenz@lexisnexis.com',
													'OptinCellphone Build Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												'David.Lenz@lexisnexis.com',
												'OptinCellphone '+filedate+' Build FAILED',
												workunit);						
end;

