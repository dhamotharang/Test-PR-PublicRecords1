export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													'jbello@seisint.com',
													' Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit
													);

	export build_failure := fileservices.sendemail(
													'jbello@seisint.com',
													filedate+' Roxie Build FAILED',
													workunit
													);						
end;