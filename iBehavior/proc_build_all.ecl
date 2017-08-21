// Process to build the iBehavior Files.
import ut, _control, roxiekeybuild, VersionControl;


export Proc_build_all(string version) := function
#workunit('name','iBehavior - ' + version);

										
e_mail_success := fileservices.sendemail(
										Email_Notification_Lists.BuildSuccess,
										'iBehavior Build Succeeded - ' + version,
										'');										
							
e_mail_fail := fileservices.sendemail(
									  Email_Notification_Lists.BuildFailure,
									  'iBehavior Build FAILED',
									  failmessage);
 
e_mail_qa   := fileservices.sendemail(Email_Notification_Lists.QaSample,
                    'iBehavior Sample Records Completed- '+ version,	'workunit: ' + workunit);

 
build_base			:=	iBehavior.proc_build_base(version);																																
build_keys  		:=	iBehavior.Proc_build_keys(version);
build_strata		:=	iBehavior.proc_build_strata(version);

//send email to qa with sample records.
sample_records_for_qa	:= iBehavior.sampleRecords(version) : success(e_mail_qa);

//Update Roxie Page with Key Version
 UpdateRoxiePage := sequential(RoxieKeybuild.updateversion('iBehaviorKeys', version, Email_Notification_Lists.Roxie,,'N')
											,RoxieKeybuild.updateversion('FCRA_iBehaviorKeys', version, Email_Notification_Lists.Roxie,,'F')); 
									 
email_notify := sequential(
							build_base,
							parallel(
											build_keys
										/*,	build_autokeys*/ //Not building Autokeys at this time.
										,	build_strata

									   ),
                    sample_records_for_qa 
                    ,UpdateRoxiePage 
                  ) : 
							SUCCESS(e_mail_success), 
							FAILURE(e_mail_fail);

return email_notify;

end;