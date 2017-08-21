import lib_fileservices;

export Send_Emails(
	
	 string		pversion

) :=
module

	export BuildSuccess	:= fileservices.sendemail(
													 Email_Notification_Lists.BuildSuccess
													,_Dataset().Name + ' Build ' + pversion + ' Completed\n'
													,workunit
												);

	export BuildFailure	:= fileservices.sendemail(
													 Email_Notification_Lists.BuildFailure
													,_Dataset().Name + ' Build ' + pversion + ' Failed\n'
													,workunit + '\n' + failmessage
												);

end;