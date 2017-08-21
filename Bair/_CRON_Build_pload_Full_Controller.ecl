import ut,wk_ut;
SUN_AND_WED_AT_4PM:='0 20 * * 0,3';  // thor has GMT time(4 hours ahead than us).

ECL:=
 '//Bair._CRON_Build_pload_full_Controller\n'
+'//scheduler job name -> Bair Full Build All Controller\n'
+'//queued job name -> Bair Full Build All Controller\n'
+'//SUN_AND_WED_AT_4PM:\n'
+'#WORKUNIT(\'name\', \'Bair Full Build All Controller\');\n'
+'NOTIFY(\'Bair Full Build All Scheduler\',\'*\');\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Full Build All Controller');
wk_ut.CreateWuid(ECL,'hthor',Bair._ESP):
													 WHEN(cron(SUN_AND_WED_AT_4PM))
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Full Build All Controller Scheduler Failure'
													,'SCHEDULE FAILURE\n'
													+'See '+workunit+'\n\n'
													+FAILMESSAGE
													));													