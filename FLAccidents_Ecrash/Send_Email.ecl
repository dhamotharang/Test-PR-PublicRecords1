import VersionControl, _control;
export Send_Email(string pversion,string vnum) :=
module

	shared SuccessSubject := if(VersionControl.IsValidVersion(pversion)
															,'SUCCESS : ECRASH'+ vnum + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
															,'ECRASH'+ vnum + ' Build Skipped, No version parameter passed to build on ' + _Control.ThisEnvironment.Name
														);
	shared SuccessBody		:= map(VersionControl.IsValidVersion(pversion) and pversion[9] = 'b'
															=> 'ECRASH'+ vnum + ' BUILD' + pversion + ' Completed and is ready for Prod Roxie deployment ',
															VersionControl.IsValidVersion(pversion) and pversion[9] = ''
															=> 'ECRASH'+ vnum + ' BUILD' + pversion + ' Completed and is ready for Cert Roxie deployment '
															,workunit + '\nPlease pass in a version date parameter to ECRASH Build_All and then resubmit through querybuilder.' 
														);
	

	export BuildSuccess	:= fileservices.sendemail(
													Email_Notification_Lists.BuildSuccess,
													SuccessSubject,
													SuccessBody);

	export BuildFailure	:= fileservices.sendemail(
													Email_Notification_Lists.BuildFailure,
													'FAILURE : ECRASH'+ vnum +' Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
													workunit + '\n' + failmessage);
													
end;