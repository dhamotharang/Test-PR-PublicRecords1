import _control;

admin_list := _control.MyInfo.EmailAddressNotify+';jbello@seisint.com;';						
		
export Send_Email(string filedate):= module

	export scrubs_report :=_control.MyInfo.EmailAddressNotify +';jbello@seisint.com' +';saritha.myana@lexisnexis.com';
						
	export build_success := fileservices.sendemail(admin_list,
																								 'Certegy Build Succeeded ' + filedate,
																								 'Sample records are in WUID: ' + workunit);

	export build_failure := fileservices.sendemail(admin_list,
																								 'Certegy '+filedate+' Build FAILED',
																								 workunit);
												
   export KeySuccess	 := fileservices.sendemail(admin_list,									  
																								 'CertegyKeys Build Succeeded ' + filedate,
																								 'WUID: ' + workunit);
									   
	export KeyFailure		 := fileservices.sendemail(admin_list,
																								 'CertegyKeys Build Failed ' + filedate,
																								 'WUID: ' + workunit + '\n' + failmessage);	
end;