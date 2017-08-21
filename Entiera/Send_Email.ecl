export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													'snarra@seisint.com;jlezcano@seisint.com',
													'Entiera Email Addresses Build Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												'khumayun@seisint.com;snarra@seisint.com',
												'Entiera '+filedate+' Roxie Build FAILED',
												workunit);						
end;