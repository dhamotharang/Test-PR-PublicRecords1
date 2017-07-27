export Email_notification_lists(string filedate) := function

BuildCompletion	:= fileservices.sendemail('wma@seisint.com;risbctqualityassurance@reedelsevier.com;CAmaral@seisint.com',
			'LiensV2 Full Build Process Completed ' + filedate,
			'workunit: ' + workunit);
			
return BuildCompletion;

end;
