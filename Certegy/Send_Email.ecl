export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													'jbello@seisint.com',
													'Certegy Build Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												'jbello@seisint.com',
												'Certegy '+filedate+' Build FAILED',
												workunit);						
end;