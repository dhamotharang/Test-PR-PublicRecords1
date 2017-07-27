export fn_build_roxie_key(string vdate) := function


clear_superkey 	:= fileservices.clearsuperfile('~thor_data400::key::md5::qa::ssn');
add_superkey   	:= fileservices.addsuperfile('~thor_data400::key::md5::qa::ssn','~thor_data400::key::md5::'+vdate+'::ssn');
//
e_mail_success 	:= fileservices.sendemail('skasavajjala@seisint.com,roxiebuilds@seisint.com',
										'md5_ssn Roxie Build Succeeded ' + vdate,
										'key: thor_data400::key::md5::qa::ssn (thor_data400::key::md5::'+vdate+'::ssn),\n' + 
										'      has been built and ready to be deployed to QA.');
e_mail_fail 	:= fileservices.sendemail('skasavajjala@seisint.com,roxiebuilds@seisint.com',
										'md5_ssn Roxie Build Failed',
										failmessage);
//
//%update_dops% := roxiekeybuild.updateversion('SSNOverride_Keys',vdate,misc2.build_notification_email_address);

do_it := sequential(misc2.proc_build_keys(vdate),clear_superkey,add_superkey) 
		: success(e_mail_success),
		  failure(e_mail_fail);
	
return do_it;
end;
