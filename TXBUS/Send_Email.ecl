import _Control;
export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													_Control.MyInfo.EmailAddressNotify+ ';qualityassurance@seisint.com;michael.gould@lexisnexis.com;kevin.reeder@lexisnexis.com;charlene.ros@lexisnexis.com',
													'TXBUS Roxie Build Succeeded ' + filedate,
													'Sample records are in WUID: ' + workunit);

	export build_failure := fileservices.sendemail(
												_Control.MyInfo.EmailAddressNotify+ ';michael.gould@lexisnexis.com;charlene.ros@lexisnexis.com',
												'TXBUS '+filedate+' Roxie Build FAILED',
												workunit);						
end;