
email_list:='karthik.reddy@lexisnexisrisk.com';

dfuWUID:='W20200915-111742';
dfuStatus:='finished';

success_message:='File spray successful.DFU WUID: ' + dfuWUID + '. State: ' + dfuStatus ;
fail_message:='Error during file spray. Unable to proceed. Please try again or manually spray the file. Failed DFU WUID: ' + dfuWUID + '. State: ' + dfuStatus ;

message:= if(dfuStatus='finished', success_message, fail_message);

FileServices.SendEmail(email_list,'KEL SHELL QA UI run job',message);


EXPORT File_spray_notification_macro := 'todo';