import VersionControl, _control;
export Send_Email(string pversion,string build_name) :=
module

shared emaillist := Email_Notification_Lists;

	shared SuccessSubject := if(VersionControl.IsValidVersion(pversion)
															,'SUCCESS : '+build_name + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
															,build_name + ' Build Skipped, No version parameter passed to build on ' + _Control.ThisEnvironment.Name
														);
	shared SuccessBody		:=
															build_name +  ' BUILD' + pversion + ' Completed and is ready for Cert Roxie deployment ';
														
					
	

	export BuildSuccess	:= fileservices.sendemail(
													emaillist,
													SuccessSubject,
													SuccessBody);

	export BuildFailure	:= fileservices.sendemail(
													emaillist,
													'FAILURE : '+build_name+ ' Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
													workunit + '\n' + failmessage);
													
end;