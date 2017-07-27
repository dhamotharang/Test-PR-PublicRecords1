// Process to build the American Student List Files.
import ut, _control, roxiekeybuild;

export Proc_Build_American_Student_List(string filedate) :=
function
#workunit('name','American Student List Build');
// email_notification_list := _control.MyInfo.EmailAddressNotify + ';julianne.franzer@lexisnexis.com;tedman@seisint.com;' + roxiekeybuild.Email_Notification_List;
email_notification_list := 'david.lenz@lexisnexis.com';

e_mail_success := fileservices.sendemail(
										email_notification_list,
										'American Student List Roxie Build Succeeded ' + filedate,
										'keys: 1) thor_data400::key::american_student::qa::did(thor_data400::key::american_student::'+filedate+'::did),\n' +
										'		 2) thor_data400::key::fcra::american_student::qa::did(thor_data400::key::fcra::american_student::'+filedate+'::did), \n' +
   										// '	     3) thor_data400::key::american_student::qa::address(thor_data400::key::american_student::'+filedate+'::address),\n' + 
   										'      have been built and ready to be deployed to QA.');
							
e_mail_fail := fileservices.sendemail(
									  _control.MyInfo.EmailAddressNotify,
									  'American Student List Roxie Build FAILED',
									  failmessage);
																																
ut.MAC_SF_BuildProcess(American_student_list.Proc_rollup_American_Student_List_base(filedate),American_student_list.thor_cluster + 'base::american_student_list',a);
																	
build_base  				:= a : SUCCESS(OUTPUT('base files built successfully')), failure(OUTPUT('build of base files failed'));
build_keys  				:=	American_student_list.Proc_build_keys(filedate);
									 
email_notify := sequential(
							build_base,
							parallel(
										build_keys
										,American_student_list.Out_Base_Stats_Population(filedate)
										,American_student_list.Proc_Build_Autokeys(filedate)
									   )
							) : 
							SUCCESS(e_mail_success), 
							FAILURE(e_mail_fail);

return email_notify;

end;