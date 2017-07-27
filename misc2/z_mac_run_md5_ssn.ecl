export mac_run_md5_ssn(/*sourceIP,sourceFile,*/ filedate /*,recordsize,group_name*/) := macro

#workunit('name','mac run md5 SSN')
// #uniquename(spray_file)
//
// #uniquename(clear_super)
// #uniquename(move2father)
// #uniquename(add_super)
// 
#uniquename(clear_superkey)
#uniquename(add_superkey)
//
#uniquename(e_mail_success)
#uniquename(e_mail_fail)

// %spray_file%  := fileservices.sprayfixed(sourceIP,sourcefile,recordsize,group_name,'~thor_data400::in::md5::'+filedate+'::ssn',-1,,,true,true);
//
// %move2father% := fileservices.AddSuperFile('~thor_data400::in::md5::father::ssn','~thor_data400::in::md5::qa::ssn',,true);
// %clear_super% := fileservices.clearsuperfile('~thor_data400::in::md5::qa::ssn');
// %add_super%   := fileservices.addsuperfile('~thor_data400::in::md5::qa::ssn','~thor_data400::in::md5::'+filedate+'::ssn');
//
%clear_superkey% := fileservices.clearsuperfile('~thor_data400::key::md5::qa::ssn');
%add_superkey%   := fileservices.addsuperfile('~thor_data400::key::md5::qa::ssn','~thor_data400::key::md5::'+filedate+'::ssn');
//
%e_mail_success% := fileservices.sendemail('rvanheusen@seisint.com,roxiebuilds@seisint.com',
										'md5_ssn Roxie Build Succeeded ' + filedate,
										'key: thor_data400::key::md5::qa::ssn (thor_data400::key::md5::'+filedate+'::ssn),\n' + 
										'      has been built and ready to be deployed to QA.');
%e_mail_fail% := fileservices.sendemail('rvanheusen@seisint.com,roxiebuilds@seisint.com',
										'md5_ssn Roxie Build Failed',
										failmessage);
//
//%update_dops% := roxiekeybuild.updateversion('SSNOverride_Keys',filedate,misc2.build_notification_email_address);

sequential(/*%spray_file%,%move2father%,%clear_super%,%add_super%,*/misc2.proc_build_keys(filedate),%clear_superkey%,%add_superkey%) 
		: success(%e_mail_success%),
		  failure(%e_mail_fail%);
	
endmacro;


