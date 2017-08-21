import _control;
export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													_Control.MyInfo.EmailAddressNotify+';qualityassurance@seisint.com',
													'DCARoxie Build Succeeded ' + filedate,
													'Sample records located in WUID: ' + workunit);

	export build_failure := fileservices.sendemail(
												_Control.MyInfo.EmailAddressNotify,
												'DCA '+filedate+' Roxie Build FAILED',
												workunit);						
end;