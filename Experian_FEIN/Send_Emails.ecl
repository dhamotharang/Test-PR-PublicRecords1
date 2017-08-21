import VersionControl,tools;

export Send_Emails(string pversion) := module

	export BuildSuccess	:= tools.fun_SendEmail(
													 Email_Notification_Lists().BuildSuccess
													,_Dataset().Name + ' Build Succeeded ' + pversion
													,workunit);

	export BuildFailure	:= tools.fun_SendEmail(
													Email_Notification_Lists().BuildFailure
												 ,_Dataset().Name + ' Build ' + pversion + ' Failed',
													workunit + '\n' + failmessage);
		
end;
