export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													'',
													'FLCrash Build Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
													'',
													'FLCrash '+filedate+' Build FAILED',
													workunit);						
end;