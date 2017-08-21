export Email_Notification_List(string filedate) := function

BuildCompletion	:= fileservices.sendemail('skasavajjala@seisint.com;qualityassurance@seisint.com;DCADataInsightTeam@Choicepoint.com;DataQuestionsGRP@lexisnexis.com',
			'Marriage Divorce Build Process Completed ' + filedate,
			'workunit: ' + workunit);
			
return BuildCompletion;

end;
