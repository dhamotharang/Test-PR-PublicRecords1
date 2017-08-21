import VersionControl, _control, emdeon;

EXPORT Send_Email(STRING pVersion, BOOLEAN pUseProd = false) := MODULE

	SHARED SuccessSubject	:= IF(VersionControl.IsValidVersion(pVersion)
															,emdeon._Dataset(pUseProd).name + ' Build ' + pVersion + ' Completed on ' + _Control.ThisEnvironment.Name
															,emdeon._Dataset(pUseProd).name + ' Build Skipped, No version parameter passed to build on ' +
																				_Control.ThisEnvironment.Name );
																				
	SHARED SuccessBody 		:= IF(VersionControl.IsValidVersion(pVersion), 
															WORKUNIT, 
															WORKUNIT + '\nPlease pass in a version date parameter to ' + emdeon._Dataset().name +
															'.Build_All and then resubmit through querybuilder.' );
   
	EXPORT BuildSuccess		:= fileservices.sendemail(
														emdeon.Email_Notification_Lists.BuildSuccess,
														SuccessSubject,
														SuccessBody  );
	
	EXPORT BuildFailure		:= fileservices.sendemail(  
														Email_Notification_Lists.BuildFailure,
														emdeon._Dataset(pUseProd).name + ' Build ' + pVersion + ' Failed on '+ _Control.ThisEnvironment.Name,
														WORKUNIT + '\n' + FAILMESSAGE  );
END;
