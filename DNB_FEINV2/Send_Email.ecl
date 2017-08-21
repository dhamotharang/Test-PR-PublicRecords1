import _control;
export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													_control.MyInfo.EmailAddressNotify +'; qualityassurance@seisint.com',
													'DNBFEINV2 Roxie Build Succeeded ' + filedate,
													'Sample records located in WUID: ' + workunit);

	export build_failure := fileservices.sendemail(
												_control.MyInfo.EmailAddressNotify,
												'DNBFEINV2 '+filedate+' Roxie Build FAILED',
												workunit);						
end;