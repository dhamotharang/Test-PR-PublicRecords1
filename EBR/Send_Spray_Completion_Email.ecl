export Send_Spray_Completion_Email(string sourcefile, string thor_filename, string superfilename, string segmentcode, string segment_description, string filedate) := 
function
	return fileservices.sendemail(EBR_Email_Notification_List_Spray,
				Dataset_Name + ': ' + trim(segmentcode) + ' ' + trim(segment_description) + ' ' + filedate + ' segment spray completed',
				'Unix source file: ' + sourcefile + '\r\nThor destination file: ' + thor_filename + 
				'\r\nSpray successful and added to superfile: ' + superfilename + '\r\nworkunit: ' + workunit);

end;