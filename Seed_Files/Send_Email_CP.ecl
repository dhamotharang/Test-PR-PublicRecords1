import VersionControl, _control;
export Send_Email_CP(string pversion) :=
module

	shared SuccessSubject := 'SUCCESS : CONSUMER REPORT TEST SEED  Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name;
	
	shared SuccessBody		:=  'CONSUMER REPORT  TEST SEED  BUILD' + pversion + ' Completed and is ready for Cert Roxie deployment ';
	
	shared Email_Notification_Lists := 'sudhir.kasavajjala@lexisnexis.com';

	export BuildSuccess	:= fileservices.sendemail(
													Email_Notification_Lists,
													SuccessSubject,
													SuccessBody);

	export BuildFailure	:= fileservices.sendemail(
													Email_Notification_Lists,
													'FAILURE : CONSUMER REPORT  TEST SEED  Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
													workunit + '\n' + failmessage);
													
end;