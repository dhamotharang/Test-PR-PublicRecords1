// Bair._CRON_Delete_orphan_Inputs
// scheduler job nane -> Bair Importer Cleanup
// queued job nane -> Housekeeping
// ONCE_A_DAY:
//  Deletes obsolete input files
// Expected execution time -> 1-5 minutes

import wk_ut,ut;

ECL:=
 '//Bair._CRON_Delete_orphan_Inputs\n'
+'//scheduler job nane -> Bair Importer Cleanup\n'
+'//queued job nane -> Housekeeping\n'
+'//ONCE_A_DAY:\n'
+'// Deletes obsolete input files\n'
+'\n'
+'//Expected execution time -> 1-5 minutes\n'
+'\n'
+'#WORKUNIT(\'name\', \'Housekeeping\');\n'
+'\n'
+'Bair.fn_Housekeeping(false)\n'
+'		:failure(fileservices.sendemail(\'jose.bello@lexisnexis.com\',\'HOUSEKEEPING ERROR\',workunit+\'\\n\\n\'+failmessage))\n'
+'		;\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Importer Cleanup');	 
wk_ut.CreateWuid(ECL,'hthor',Bair._ESP):
													 WHEN('GO_CLEANUP')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** WARNING **** Housekeeping Scheduler Failure'
													,'SCHEDULE FAILURE\n'
													+'See '+workunit+'\n\n'
													+FAILMESSAGE
													));