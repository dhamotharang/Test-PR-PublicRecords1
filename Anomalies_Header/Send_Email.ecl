Import STD, _Control, VersionControl;

Export Send_Email( String pversion, Boolean pUseProd = False ) := Module


    Shared Anomalies_Support := 'Maurice.Vigueras@lexisnexisrisk.com';

	Shared SuccessSubject := if(VersionControl.IsValidVersion(pversion), 
							    _Dataset(pUseProd).name + 'Build' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name, 
								_Dataset(pUseprod).name + ' Build Skipped, No version paramter passed to build upon ' + 
								_Control.ThisEnvironment.Name 
								 );

	Shared SuccessBody    := if(VersionControl.IsValidVersion(pversion),
								workunit,
								workunit + '\nPlease pass in a version date parameter to ' + 
								_Dataset().Name + '.Build_All and then resubmit through querybuilder.' + 
								'\nSee ' + _Dataset().name + '._BWR_Build_Test attribute for more details.');

	Export BuildSuccess    := STD.System.Email.SendEmail(Email_Notification_list.BuildSuccess,
	                                                     SuccessSubject, 
														 SuccessBody,,, Anomalies_Support);
													

	Export BuildFailure    := STD.System.Email.SendEmail(Email_Notification_list.BuildFailure,
	                                                     SuccessSubject, 
														 SuccessBody,,, Anomalies_Support);
	



End;