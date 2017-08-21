import lib_fileservices;
export Email_notification_lists(string myjobname, string mywuid)  := module

//****** send email notice when job complete successfully

leMailTarget := 'wenhong.ma@lexisnexis.com;cmorton@seisint.com';

shared fSendMail(string pSubject, string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

export build_complete:= fSendMail(myjobname + ' Logs Complete','Logs Complete.  WUID: ' + mywuid);
export build_failed := fSendMail(myjobname + ' Logs FAILED','Logs Failed.  WUID: ' + mywuid);

end;
