import VersionControl, _control;
export Send_Email(string pversion) :=
module

	shared SuccessSubject := if(VersionControl.IsValidVersion(pversion)
															,'Header NonUpdating Key Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
															,'Header NonUpdating Key Build Skipped, No version parameter passed to build on ' + _Control.ThisEnvironment.Name
														);
	shared SuccessBody		:= if(VersionControl.IsValidVersion(pversion)
															,'Header NonUpdating Key BUILD' + pversion + 'is ready for CERT deployment '
															,workunit + '\nPlease pass in a version date parameter to Header NonUpdating Keys Build_All and then resubmit through querybuilder.' 
														);
	

	export BuildSuccess	:= fileservices.sendemail(
													'skasavajjala@seisint.com',
													SuccessSubject,
													SuccessBody);

	export BuildFailure	:= fileservices.sendemail(
													'skasavajjala@seisint.com',
													'Header NonUpdating Key Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
													workunit + '\n' + failmessage);
													
end;