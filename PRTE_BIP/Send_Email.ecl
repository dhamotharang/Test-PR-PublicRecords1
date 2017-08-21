import ut, VersionControl, _control;

export Send_Email(string pname, string pversion) := module
		shared SuccessSubject	:= if(VersionControl.IsValidVersion(pversion)
																		,ut.fnTrim2Upper(_Dataset().name) + ' - ' + pname + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
																		,ut.fnTrim2Upper(_Dataset().name) + ' - ' + pname + ' Build Skipped, No version parameter passed to build on ' + _Control.ThisEnvironment.Name
																);
		shared SuccessBody 		:= if(VersionControl.IsValidVersion(pversion)
																		,workunit
																		,workunit + '\nPlease pass in a version date parameter to ' + _Dataset().name + ' - ' + pname + '.  Build_All and then resubmit through querybuilder.'
																);
   
		export BuildSuccess		:= fileservices.sendemail(
																										Email_Notification_Lists.BuildSuccess,
																										SuccessSubject,
																										SuccessBody
																										);
		export BuildFailure		:= fileservices.sendemail(
																										Email_Notification_Lists.BuildFailure,
																										ut.fnTrim2Upper(_Dataset().name) + ' - ' + pname + ' Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
																										workunit + '\n' + failmessage
																										);

end;