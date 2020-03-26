export Email_notification_lists (string filedate) := function

BuildCompletion	:= fileservices.sendemail('Sudhir.Kasavajjala@lexisnexis.com;qualityassurance@seisint.com',
			'LN PropertyV2 Full Build Process Completed ' + filedate,
			'workunit: ' + workunit);
			
return BuildCompletion;

end;
