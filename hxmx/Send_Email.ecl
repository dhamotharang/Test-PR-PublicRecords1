IMPORT VersionControl, _control, hxmx;

EXPORT Send_Email(STRING pVersion, BOOLEAN pUseProd = FALSE) := MODULE
	SHARED SuccessSubject	:= IF(VersionControl.IsValidVersion(pVersion)
															,hxmx._Dataset(pUseProd).name + ' Build ' + pVersion + ' Completed on ' + _Control.ThisEnvironment.Name
															,hxmx._Dataset(pUseProd).name + ' Build Skipped, No version parameter passed to build on ' +
																				_Control.ThisEnvironment.Name );
	SHARED SuccessBody 		:= IF(VersionControl.IsValidVersion(pVersion), 
															WORKUNIT, 
															WORKUNIT + '\nPlease pass in a version date parameter to ' + hxmx._Dataset().name +
															'.Build_All AND then resubmit through querybuilder.' );

	EXPORT BuildSuccess		:= fileservices.sendemail(
														hxmx.Email_Notification_Lists.BuildSuccess,
														SuccessSubject,
														SuccessBody  );

	EXPORT BuildFailure		:= fileservices.sendemail(  
														Email_Notification_Lists.BuildFailure,
														hxmx._Dataset(pUseProd).name + ' Build ' + pVersion + ' Failed on '+ _Control.ThisEnvironment.Name,
														WORKUNIT + '\n' + FAILMESSAGE  );
END;