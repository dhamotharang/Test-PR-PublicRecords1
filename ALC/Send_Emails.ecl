IMPORT _Control, ALC, VersionControl;

EXPORT Send_Emails(STRING  pversion,
                   BOOLEAN pUseProd = FALSE) := MODULE

	SHARED SuccessSubject	:= IF(VersionControl.IsValidVersion(pversion),
															ALC._Dataset(pUseProd).name + ' Build ' + pversion +
															   ' Completed on ' + _Control.ThisEnvironment.Name,
															ALC._Dataset(pUseProd).name + ' Build Skipped, No version ' +
															   'parameter passed to build on ' + _Control.ThisEnvironment.Name );

	SHARED SuccessBody 		:= IF(VersionControl.IsValidVersion(pversion),
															WORKUNIT,
															WORKUNIT + '\nPlease pass in a version date parameter to ' + ALC._Dataset().name +
															   '.Build_All and then resubmit through querybuilder.' +
                                 '\nSee ALC._BWR_Build attribute for more details.');

	EXPORT BuildSuccess		:= FileServices.SendEmail(ALC.Email_Notification_Lists.BuildSuccess,
																									SuccessSubject,
																									SuccessBody);

	EXPORT BuildFailure		:= FileServices.SendEmail(
														 ALC.Email_Notification_Lists.BuildFailure,
														 ALC._Dataset(pUseProd).name + ' Build ' + pversion + ' Failed on ' +
														    _Control.ThisEnvironment.Name,
														 WORKUNIT + '\n' + FAILMESSAGE);

END;
