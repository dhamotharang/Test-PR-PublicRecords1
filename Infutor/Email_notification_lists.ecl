export Email_notification_lists (string filedate) := function

BuildCompletion	:= fileservices.sendemail('akayttala@seisint.com;jtrost@seisint.com;dsunderman@seisint.com',
			'Infutor Tracker File Build Process Completed ' + filedate,
			'workunit: ' + workunit);
			
return BuildCompletion;

end;
