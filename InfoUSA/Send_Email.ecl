export Send_Email(string filedate, string source):= module
							
	export build_success := fileservices.sendemail(
													'tedman@seisint.com;qualityassurance@seisint.com',
													'InfoUsa '+source+' Roxie Build Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												'tedman@seisint.com',
												'InfoUsa '+source+' Roxie Build FAILED',
												workunit);						
end;