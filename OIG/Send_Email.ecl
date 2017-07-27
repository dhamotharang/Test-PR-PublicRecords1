 import VersionControl, _control;

export Send_Email(string pversion) := module
		shared SuccessSubject	:= if(VersionControl.IsValidVersion(pversion)
																		,_Dataset().name + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
																		,_Dataset().name + ' Build Skipped, No version parameter passed to build on ' + _Control.ThisEnvironment.Name
																);
		shared SuccessBody 		:= if(VersionControl.IsValidVersion(pversion)
																		,workunit
																		,workunit + '\nPlease pass a version date parameter and  a input raw file folder date parameter to ' + _Dataset().name + '.Build_All and then resubmit through querybuilder.' +
                                              '\nSee ' + _Dataset().name 
																);
   
		export BuildSuccess		:= fileservices.sendemail('randy.reyes@lexisnexis.com; manuel.tarectecan@lexisnexis.com' + _control.MyInfo.EmailAddressNotify,
																										SuccessSubject,
																										SuccessBody
																										);
		export BuildFailure		:= fileservices.sendemail('saritha.myana@lexisnexis.com; randy.reyes@lexisnexis.com; manuel.tarectecan@lexisnexis.com' + _control.MyInfo.EmailAddressNotify,
																										_Dataset().name + ' Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
																										workunit + '\n' + failmessage
																										);
end;
