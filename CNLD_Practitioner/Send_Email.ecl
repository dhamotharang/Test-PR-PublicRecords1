IMPORT VersionControl, _Control;

EXPORT Send_Email(STRING pversion) := MODULE
	SHARED SuccessSubject	:= IF(VersionControl.IsValidVersion(pversion),
															_Dataset().name + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name,
															_Dataset().name + ' Build Skipped, No version parameter passed to build on ' +
															   _Control.ThisEnvironment.Name);
																 
	SHARED SuccessBody := IF(VersionControl.IsValidVersion(pversion), 
													 WORKUNIT, 
													 WORKUNIT + '\nPlease pass in a version date parameter to ' + _Dataset().name +
															'.Build_All and then resubmit through querybuilder.' +
                              '\nSee ' + _Dataset().name + '._BWR_Build_Test attribute for more details.' );
   
	EXPORT BuildSuccess := FileServices.SendEmail(Email_Notification_Lists.BuildSuccess,
														                    SuccessSubject,
														                    SuccessBody);
	
	EXPORT BuildFailure := Fileservices.Sendemail(  
													 Email_Notification_Lists.BuildFailure,
													 _Dataset().name + ' Build ' + pversion + ' Failed on ' + _Control.ThisEnvironment.Name,
														  WORKUNIT + '\n' + FAILMESSAGE);
END;