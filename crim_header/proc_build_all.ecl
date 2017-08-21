
//
// Process to update the Crim Header base file
//
import ut, _control, roxiekeybuild;

export proc_build_all(string filedate) :=
function

email_notification_list := 'rvanheusen@seisint.com';

e_mail_success := fileservices.sendemail(
										email_notification_list,
										'Update Crim Header Succeeded ' + filedate,
										'Base file built, ready for NGCDL2');
									
e_mail_fail := fileservices.sendemail(
									  email_notification_list,
									  'Update crim Header Failed',
									  failmessage);

	
ut.MAC_SF_BuildProcess(crim_header.updated_crim_header,'~thor_data400::base::crim_header',a);

build_base  := a : success(output('base files built successfully')), failure(output('build of base files failed'));

							 
email_notify := sequential(build_base)  :
							success(e_mail_success), 
							failure(e_mail_fail);
return email_notify;

end;