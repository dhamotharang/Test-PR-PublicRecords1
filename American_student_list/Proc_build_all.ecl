// Process to build the American Student List Files.
import ut, _control, roxiekeybuild, VersionControl, Scrubs_American_Student_List,dops;

export Proc_build_all(string filedate, string filename) :=
function

GroupName	:=	VersionControl.GroupName('44');

American_student_list.Mac_spray_american_student_V2(_control.IPAddress.bctlpedata11
																					,'/data/data_build_1/american_student/data/'+filedate[1..8]+'/'
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
UpdateRoxiePage := sequential(dops.updateversion('AmericanstudentKeys', filedate, Email_Notification_Lists.Roxie,,'N')
											,dops.updateversion('FCRA_AmericanstudentKeys', filedate, Email_Notification_Lists.Roxie,,'F'));

email_notify := sequential(
							//DF-20264 Build base file for ASL suppression list
							American_student_list.Proc_build_suppression(filedate),
							doSpray,
							American_student_list.Proc_build_base,
							American_student_list.proc_build_address_list(filedate),
							parallel(
										build_keys
										,American_student_list.Out_Base_Stats_Population(filedate)
										,American_student_list.Out_Base_Stats_Population_V2(filedate)    //populate STRATA for v2 6/11/13
										,American_student_list.Proc_Build_Autokeys(filedate)
									   ),
										 American_student_list.fn_Key_Compare(filedate),
							Scrubs_American_Student_List.PostBuildScrubs(filedate),
							if(American_student_list.fn_CheckBeforeDops(filedate),UpdateRoxiePage),
							) : 
							SUCCESS(e_mail_success), 
							FAILURE(e_mail_fail)
							
							;

return email_notify;

end;