 import VersionControl, _control, OIG;

export Send_Email(string pversion) := module
		shared SuccessSubject	:= if(VersionControl.IsValidVersion(pversion)
																		,OIG._Dataset().name + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
																		,OIG._Dataset().name + ' Build Skipped, No version parameter passed to build on ' + _Control.ThisEnvironment.Name
																);
		shared SuccessBody 		:= if(VersionControl.IsValidVersion(pversion)
																		,workunit
																		,workunit + '\nPlease pass a version date parameter and  a input raw file folder date parameter to ' + OIG._Dataset().name + '.Build_All and then resubmit through querybuilder.' +
                                              '\nSee ' + OIG._Dataset().name 
																);
   
		export BuildSuccess		:= fileservices.sendemail('randy.reyes@lexisnexisrisk.com; manuel.tarectecan@lexisnexisrisk.com; abednego.escobal@lexisnexisrisk.com;' + _control.MyInfo.EmailAddressNotify,
																										SuccessSubject,
																										SuccessBody
																										);
		export BuildFailure		:= fileservices.sendemail('saritha.myana@lexisnexis.com; randy.reyes@lexisnexisrisk.com; manuel.tarectecan@lexisnexisrisk.com; abednego.escobal@lexisnexisrisk.com' + _control.MyInfo.EmailAddressNotify,
																										OIG._Dataset().name + ' Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
																										workunit + '\n' + failmessage
																										);
end;
