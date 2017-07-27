import _Control;

export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													_Control.MyInfo.EmailAddressNotify + ';qualityassurance@seisint.com',
													'American Student List Roxie Build Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												_Control.MyInfo.EmailAddressNotify,
												'American Student List '+filedate+' Roxie Build FAILED',
												workunit);						
end;