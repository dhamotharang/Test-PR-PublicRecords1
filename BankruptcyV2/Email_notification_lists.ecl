export Email_notification_lists(string filedate) := function

BuildCompletion	:= fileservices.sendemail('wma@seisint.com;qualityassurance@seisint.com;christopher.brodeur@lexisnexis.com;CAmaral@seisint.com;mohammad.alam@lexisnexis.com;Michael.Gould@lexisnexis.com;Randy.Reyes@lexisnexis.com;Manuel.Tarectecan@lexisnexis.com;intel357@bellsouth.net;Sayeed.ahmed@lexisnexis.com',
			'BankruptcyV2 Full Build Process Completed ' + filedate,
			'workunit: ' + workunit);
			
return BuildCompletion;

end;