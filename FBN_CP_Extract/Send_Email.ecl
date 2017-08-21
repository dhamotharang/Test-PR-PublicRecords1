import VersionControl, _control;
export Send_Email(string pversion,string bldType = '') := module
	shared SuccessSubject					:= if(VersionControl.IsValidVersion(pversion)
                                             ,_Dataset(,bldType).name + ' Base File Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
                                             ,_Dataset(,bldType).name + ' Base File Build Skipped, No version parameter passed to build on ' + _Control.ThisEnvironment.Name
                                          );
	shared SuccessBody 						:= if(VersionControl.IsValidVersion(pversion)
                                             ,workunit
                                             ,workunit + '\nPlease pass in a version date parameter to ' + _Dataset(,bldType).name + '.Build_All and then resubmit through querybuilder.' +
                                              '\nSee ' + _Dataset(,bldType).name + '._BWR_Build_*_Extract attributes for more details.'
                                          );
   
	export BuildSuccess						:= fileservices.sendemail(
                                       Email_Notification_Lists.BuildSuccess,
                                       SuccessSubject,
                                       SuccessBody);
	export BuildFailure						:= fileservices.sendemail(
                                       Email_Notification_Lists.BuildFailure,
                                       _Dataset(,bldType).name + ' Base File Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
                                       workunit + '\n' + failmessage);
																			 
	export CopyFilingSuccess			:= fileservices.sendemail(
                                       Email_Notification_Lists.CopyFilingSuccess,
                                       _Dataset(,'').name + ' Filing File Copy ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name,
                                       '\nFBN Filing Extract Data is available for pickup at the Atlanta HPCC Landing Zone: thor_data400::out::fbn_extract::'+pversion+'::filing');
	export CopyFilingFailure			:= fileservices.sendemail(
                                       Email_Notification_Lists.CopyFilingFailure,
                                       _Dataset(,'').name + ' Filing File Copy ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
                                       workunit + '\n' + failmessage);	
																			 
	export CopyNameSuccess				:= fileservices.sendemail(
                                       Email_Notification_Lists.CopyNameSuccess,
                                       _Dataset(,'').name + ' Name File Copy ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name,
                                       '\nFBN Name Extract Data is available for pickup at the Atlanta HPCC Landing Zone: thor_data400::out::fbn_extract::'+pversion+'::name');
	export CopyNameFailure				:= fileservices.sendemail(
                                       Email_Notification_Lists.CopyNameFailure,
                                       _Dataset(,'').name + ' Name File Copy ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
                                       workunit + '\n' + failmessage);																				 
									   
   
end;
