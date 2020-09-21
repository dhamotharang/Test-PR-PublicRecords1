import VersionControl, _control, INQL_FFD;

export Send_Email(string pversion, string pBody='') := module

	shared SuccessSubject	:= if(VersionControl.IsValidVersion(pversion)
															,INQL_FFD._Constants.DatasetName + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
															,INQL_FFD._Constants.DatasetName + ' Build Skipped, No version parameter passed to build on ' +
																				_Control.ThisEnvironment.Name );
																				
	shared SuccessBody 		:= if(VersionControl.IsValidVersion(pversion), 
															workunit, 
															workunit + '\nPlease pass in a version date parameter to ' +Inql_FFD._Constants.DatasetName+
															'.Build_All and then resubmit through querybuilder.' +
                               '\nSee ' + INQL_FFD._Constants.DatasetName + '._BWR_Build_Test attribute for more details.' );
   
	export BuildSuccess		:= fileservices.sendemail(
														Email_Notification_Lists.BuildSuccess,
														SuccessSubject,
														SuccessBody  );
	
	export BuildFailure		:= fileservices.sendemail(  
														Email_Notification_Lists.BuildFailure,
														INQL_FFD._Constants.DatasetName + ' Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
														workunit + '\n' + failmessage  );
														
  export DontBuild      := fileservices.sendemail(  
														Email_Notification_Lists.BuildFailure,
														INQL_FFD._Constants.DatasetName + ' - ' + pversion + ' build skipped', 
														workunit + ' on '+ _Control.ThisEnvironment.Name + '\n\n' + pBody  );														
	
	export ppcException    := fileservices.sendemail(  
														Email_Notification_Lists.ppcException,
														INQL_FFD._Constants.DatasetName + ' - ' + pversion + ' PPC Exception', 
														workunit + ' on '+ _Control.ThisEnvironment.Name + '\n\n' + pBody  );	



end;