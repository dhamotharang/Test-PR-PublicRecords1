// Process to build the American Student List Files.
import ut, _control, roxiekeybuild, VersionControl;

export Proc_build_all(string filedate, string filename) :=
function
#workunit('name','American Student List Build');
GroupName	:=	VersionControl.GroupName('88');

American_student_list.Mac_spray_american_student_V2(_control.IPAddress.edata12
   																				,'/data_build_1/american_student/data/'+filedate[1..8]+'/'
   																				,filedate
   																				,filename
																					,GroupName
   																				,'Y'
																					,doSpray);


e_mail_success := fileservices.sendemail(
										Email_Notification_Lists.BuildSuccess,
										'American Student List Roxie Build Succeeded ' + filedate,
										'keys: 1) thor_data400::key::american_student::qa::did(thor_data400::key::american_student::'+filedate+'::did),\n' +
										'		 2) thor_data400::key::fcra::american_student::qa::did(thor_data400::key::fcra::american_student::'+filedate+'::did), \n' +
   										// '	     3) thor_data400::key::american_student::qa::address(thor_data400::key::american_student::'+filedate+'::address),\n' + 
   										'      have been built and ready to be deployed to QA.');
							
e_mail_fail := fileservices.sendemail(
									  Email_Notification_Lists.BuildFailure,
									  'American Student List Roxie Build FAILED',
									  failmessage);
																																
build_keys  				:=	American_student_list.Proc_build_keys(filedate);

//Update Roxie Page with Key Version
UpdateRoxiePage := sequential(RoxieKeybuild.updateversion('AmericanstudentKeys', filedate, Email_Notification_Lists.Roxie)
											,RoxieKeybuild.updateversion('FCRA_AmericanstudentKeys', filedate, Email_Notification_Lists.Roxie));
									 
email_notify := sequential(
							doSpray,
							American_student_list.Proc_build_base,
							parallel(
										build_keys
										,American_student_list.Out_Base_Stats_Population(filedate)
										,American_student_list.Proc_Build_Autokeys(filedate)
									   ),
							UpdateRoxiePage
							) : 
							SUCCESS(e_mail_success), 
							FAILURE(e_mail_fail);

return email_notify;

end;