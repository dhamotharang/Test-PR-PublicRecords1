new_Tag:='W20200915-111742';
old_Tag:='W20200915-111742';

cond:='Person_NonFCRA';
// cond:='Person_FCRA';
// cond:='Business';

email_list:='karthik.reddy@lexisnexisrisk.com';

WUID_Macro:= Kel_Shell_QA_UI.WUID_Macro(new_Tag, old_Tag, cond, email_list);

WUID_Macro:FAILURE(FileServices.SendEmail(email_list,'KAT Notification',' Your compare job has failed. The failed workunit is:' + workunit + FailMessage));


EXPORT BWR_WUID_Macro := 'todo';