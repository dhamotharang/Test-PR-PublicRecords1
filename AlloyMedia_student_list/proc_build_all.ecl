// Process to build the American Student List Files.
import ut, _control, roxiekeybuild, VersionControl;

export Proc_build_all(string version) :=
function
#workunit('name','Alloy Student Directory Build - ' + version);
										
e_mail_success := fileservices.sendemail(
										Email_Notification_Lists.BuildSuccess,
										'Alloy Student Directory Build Succeeded - ' + version,
										'');										
							
e_mail_fail := fileservices.sendemail(
									  Email_Notification_Lists.BuildFailure,
									  'Alloy Student Directory Build FAILED',
									  failmessage);
										
build_base			:=	alloymedia_student_list.Proc_build_base(version);																																
build_keys  		:=	alloymedia_student_list.Proc_build_keys(version);
build_autokeys  :=	alloymedia_student_list.Proc_build_autokeys(version);
build_strata		:=	alloymedia_student_list.proc_build_strata(version);

//Update Roxie Page with Key Version
UpdateRoxiePage := sequential(RoxieKeybuild.updateversion('AlloyKeys', version, Email_Notification_Lists.Roxie,,'N')
											,RoxieKeybuild.updateversion('FCRA_AlloyKeys', version, Email_Notification_Lists.Roxie,,'F'));
									 
email_notify := sequential(
							build_base,
							parallel(
											build_keys
										/*,	build_autokeys*/ //Not building Autokeys at this time.
										,	build_strata
									   ),
							UpdateRoxiePage
							) : 
							SUCCESS(e_mail_success), 
							FAILURE(e_mail_fail);

return email_notify;

end;