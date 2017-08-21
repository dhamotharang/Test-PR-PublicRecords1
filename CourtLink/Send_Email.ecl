import VersionControl, _control;
export Send_Email(string pversion) := module
	shared SuccessSubject	:= if(VersionControl.IsValidVersion(pversion)
                                             ,_Dataset().name + ' Base File Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
                                             ,_Dataset().name + ' Base File Build Skipped, No version parameter passed to build on ' + _Control.ThisEnvironment.Name
                                          );
	shared SuccessBody 		:= if(VersionControl.IsValidVersion(pversion)
                                             ,workunit
                                             ,workunit + '\nPlease pass in a version date parameter to ' + _Dataset().name + '.Build_All and then resubmit through querybuilder.' +
                                              '\nSee ' + _Dataset().name + '._BWR_Build_Litigious_Debtor_Base attribute for more details.'
                                          );
   
	export BuildSuccess		:= fileservices.sendemail(
                                       Email_Notification_Lists.BuildSuccess,
                                       SuccessSubject,
                                       SuccessBody);
	export BuildFailure		:= fileservices.sendemail(
                                       Email_Notification_Lists.BuildFailure,
                                       _Dataset().name + ' Base File Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
                                       workunit + '\n' + failmessage);
									   
	shared KeySuccessSubj	:= if(VersionControl.IsValidVersion(pversion)
                                             ,_Dataset().name + ' Key Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
                                             ,_Dataset().name + ' Key Build Skipped, No version parameter passed to build on ' + _Control.ThisEnvironment.Name
                                          );
	shared KeySuccessBody 	:= if(VersionControl.IsValidVersion(pversion)
                                             ,workunit
                                             ,workunit + '\nPlease pass in a version date parameter to ' + _Dataset().name + '.Proc_Build_Keys and then resubmit through querybuilder.' +
                                              '\nSee ' + _Dataset().name + '._BWR_Build_Litigious_Debtor_Keys attribute for more details.'
                                          );
   
	export KeySuccess		:= fileservices.sendemail(
                                       Email_Notification_Lists.BuildSuccess,
                                       KeySuccessSubj,
                                       KeySuccessBody);
	export KeyFailure		:= fileservices.sendemail(
                                       Email_Notification_Lists.BuildFailure,
                                       _Dataset().name + ' Key Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
                                       workunit + '\n' + failmessage);									   
end;
