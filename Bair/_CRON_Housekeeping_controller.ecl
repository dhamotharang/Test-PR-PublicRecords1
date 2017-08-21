// Bair._CRON_Housekeeping_controller
// scheduler job nane -> Housekeeping_controller
// queued job nane -> Housekeeping_controller
// ONCE_AT_MIDNIGHT:
//  notify Bair._CRON_Delete_orphan_Inputs
// Expected execution time -> 1 minute

ONCE_AT_10AM:='0 15 * * *';
import wk_ut,ut;

ECL:=
 '//Bair._CRON_Housekeeping_controller\n'
+'//scheduler job nane -> Housekeeping_controller\n'
+'//queued job nane -> Housekeeping_controller\n'
+'//ONCE_AT_MIDNIGHT:\n'
+'// notify Bair._CRON_Delete_orphan_Inputs\n'
+'\n'
+'//Expected execution time -> 1 minute\n'
+'\n'
+'#WORKUNIT(\'name\', \'Housekeeping_controller\');\n'
+'notify(\'GO_CLEANUP\',\'*\');\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Housekeeping_controller');	 
wk_ut.CreateWuid(ECL,'hthor',Bair._ESP):
													 WHEN(cron(ONCE_AT_10AM))
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** WARNING **** Housekeeping Controller Failure'
													,'SCHEDULE FAILURE\n'
													+'See '+workunit+'\n\n'
													+FAILMESSAGE
													));