import VersionControl, _control,Medschool_standardization ;

export Send_Email(string pversion, boolean pUseProd = false) := module
	shared SuccessSubject	:= if(VersionControl.IsValidVersion(pversion)
															,'Medschool '+ ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
															, 'Medschool '+ ' Build Skipped, No version parameter passed to build on ' +
																				_Control.ThisEnvironment.Name );
	shared SuccessBody 		:= if(VersionControl.IsValidVersion(pversion), 
															workunit, 
															workunit + '\nPlease pass in a version date parameter to ' + Medschool_standardization._Dataset().name +
															'.Build_All and then resubmit through querybuilder.' +
                               '\nSee ' + Medschool_standardization._Dataset().name + '._BWR_Build_Test attribute for more details.' );
   
	export BuildSuccess		:= fileservices.sendemail(
														Medschool_standardization.Email_Notification_Lists.BuildSuccess,
														SuccessSubject,
														SuccessBody  );
	
	export BuildFailure		:= fileservices.sendemail(  
														Medschool_standardization.Email_Notification_Lists.BuildFailure,
														' Medschool '+ ' Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
														workunit + '\n' + failmessage  );
end;
