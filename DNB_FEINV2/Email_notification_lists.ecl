import _control;
export Email_notification_lists(string filedate) := function

BuildCompletion	:= fileservices.sendemail(_control.MyInfo.EmailAddressNotify,
			'DNB_Fein Full Build Process Completed ' + filedate,
			'workunit: ' + workunit);
			
return BuildCompletion;

end;
