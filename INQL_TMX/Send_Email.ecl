import VersionControl, _control;

export Send_Email(string pversion, boolean pUseProd = false, boolean pIsFull = false) := 
module

	shared SuccessSubject	:= if(VersionControl.IsValidVersion(pversion)
															,_Dataset(pUseProd, pIsFull).name + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
															,_Dataset(pUseProd, pIsFull).name + ' Build Skipped, No version parameter passed to build on ' +
																				_Control.ThisEnvironment.Name );
                                        
	shared SuccessBody 		:= if(VersionControl.IsValidVersion(pversion), 
															workunit, 
															workunit + '\nPlease pass in a version date parameter to ' + _Dataset(pUseProd, pIsFull).name +
															'.Build_All and then resubmit through querybuilder.' +
                               '\nSee ' + _Dataset(pUseProd, pIsFull).name + '._BWR_Build_Test attribute for more details.');
   
	export BuildSuccess		:= fileservices.sendemail(
														Email_Notification_Lists.BuildSuccess,
														SuccessSubject,
														SuccessBody);
	
	export BuildFailure		:= fileservices.sendemail(  
														Email_Notification_Lists.BuildFailure,
														_Dataset(pUseProd, pIsFull).name + ' Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
														workunit + '\n' + failmessage);
end;
