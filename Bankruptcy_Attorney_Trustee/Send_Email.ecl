import _control;
export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													'aherzberg@seisint.com; ' + _control.MyInfo.EmailAddressNotify,
													'Bankruptcy Attorney Trustee Build Succeeded ' + filedate,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												'aherzberg@seisint.com; ' + _control.MyInfo.EmailAddressNotify,
												'Bankruptcy Attorney Trustee '+filedate+' Build FAILED',
												workunit);						
end;