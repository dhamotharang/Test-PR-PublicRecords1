import VersionControl;
export Send_Email(string pVersion) :=
module

	export BuildSuccess	:= fileservices.sendemail(
													Email_Notification_Lists.BuildSuccess,
													'DNB Build ' + pVersion + ' Completed',
													workunit);

	export BuildFailure	:= fileservices.sendemail(
													Email_Notification_Lists.BuildFailure,
													'DNB Build ' + pVersion + ' Failed',
													workunit + '\n' + failmessage);

end;