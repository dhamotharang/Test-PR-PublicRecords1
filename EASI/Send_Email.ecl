export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													'khumayun@seisint.com;jtrost@seisint.com',
													' Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												'khumayun@seisint.com',
												filedate+' Roxie Build FAILED',
												workunit);						
end;