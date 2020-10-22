EXPORT File_spray_notification_macro(email_list, dfuWUID, dfuStatus) := FUNCTIONMACRO
success_message:='File spray successful.DFU WUID: ' + dfuWUID + '. State: ' + dfuStatus ;
fail_message:='Error during file spray. Unable to proceed. Please try again or manually spray the file. Failed DFU WUID: ' + dfuWUID + '. State: ' + dfuStatus ;

message:= if(dfuStatus='finished', success_message, fail_message);

RETURN FileServices.SendEmail(email_list,'KEL SHELL QA UI run job',message);

ENDMACRO;

// email_list:='karthik.reddy@lexisnexisrisk.com';

// dfuWUID:='W20200915-111742';
// dfuStatus:='finished';

