export Send_Build_Completion_Email(string filedate) := 
function
	return fileservices.sendemail(Email_Notification_Lists.Stats
				,Dataset_Name + ': Build ' + filedate + ' completed', 
				 'workunit: ' + workunit);
end;