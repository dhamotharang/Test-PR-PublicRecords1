import VersionControl, _control;
export Send_Email(string pversion, string pState = '') :=
module

	shared lState						:= if(pState = '', '', ' ' + pState);
	shared lBuildAttribute	:= if(pState = ''
																,_dataset.name + '.Build_All'
																,_dataset.name + '.Build_State'
															);
	shared lBwrBuildAttribute	:= if(pState = ''
																,_dataset.name + '.bwr_Build_All'
																,_dataset.name + '.bwr_Build_State'
															);
															
	shared SuccessSubject := if(VersionControl.IsValidVersion(pversion)
															,_dataset.name + lState + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
															,_dataset.name + lState + ' Build Skipped, No valid version parameter passed to build on ' + _Control.ThisEnvironment.Name
														);
	shared SuccessBody		:= if(VersionControl.IsValidVersion(pversion)
															,workunit
															,workunit + '\nPlease pass in a valid version date parameter to ' + lBuildAttribute + ' and then resubmit through querybuilder.' +
															 '\nSee ' + lBwrBuildAttribute + ' attribute for more details.'
														);
	

	export BuildSuccess	:= fileservices.sendemail(
													Email_Notification_Lists.BuildSuccess,
													SuccessSubject,
													SuccessBody);

	export BuildFailure	:= fileservices.sendemail(
													Email_Notification_Lists.BuildFailure,
													_dataset.name + lState + ' Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
													workunit + '\n' + failmessage);
/*
	export Roxie :=
	module
	
		export QA := versioncontrol.fSendRoxieEmail( 
						 Email_Notification_Lists.roxie
						,Datasetname
						,keynames().dAll_superkeynames(regexfind('^(.*)::[qQ][aA]::(.*)$', name))
						,pversion);
		
		export Prod := versioncontrol.fSendRoxieEmail( 
						 Email_Notification_Lists.roxie
						,Datasetname
						,keynames().dAll_superkeynames(regexfind('^(.*)::[pP][rR][oO][dD]::(.*)$', name))
						,pversion);
	
	
	end;
*/
end;
