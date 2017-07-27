// Process to build the iBehavior Files.
import ut, _control, roxiekeybuild, VersionControl;

export Proc_build_all(string version) :=
function
#workunit('name','iBehavior - ' + version);
										
e_mail_success := fileservices.sendemail(
										Email_Notification_Lists.BuildSuccess,
										'iBehavior Build Succeeded - ' + version,
										'');										
							
e_mail_fail := fileservices.sendemail(
									  Email_Notification_Lists.BuildFailure,
									  'iBehavior Build FAILED',
									  failmessage);
										
build_base			:=	iBehavior.proc_build_base(version);																																
build_keys  		:=	iBehavior.Proc_build_keys(version);
build_strata		:=	iBehavior.proc_build_strata(version);

//Update Roxie Page with Key Version
/* UpdateRoxiePage := sequential(RoxieKeybuild.updateversion('iBehaviorKeys', version, Email_Notification_Lists.Roxie)
											,RoxieKeybuild.updateversion('FCRA_iBehaviorKeys', version, Email_Notification_Lists.Roxie)); */
									 
email_notify := sequential(
							build_base,
							parallel(
											build_keys
										/*,	build_autokeys*/ //Not building Autokeys at this time.
										,	build_strata
									   )/*,
							 UpdateRoxiePage */
							) : 
							SUCCESS(e_mail_success), 
							FAILURE(e_mail_fail);

return email_notify;

end;