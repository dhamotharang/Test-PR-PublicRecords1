// Bair._CRON_RAIDS_Report_Controller
// scheduler job nane -> Bair Raids Report Monitor
// queued job nane -> Bair Raids Report Controller
// EVERY_TWO_MINUTES:
	// if any 'Bair Raids Report Email' in process, do nothing
		// else spin Bair.raidsReportScheduler_CRON by notifying the scheduler -> Bair Raids Report Scheduler
// Expected execution time -> 30 seconds

import ut,wk_ut,_Control;
THOR:='hthor';
EVERY_TWO_MINUTES:='0-59/2 * *	*	*';

ECL:=
 '//Bair._CRON_RAIDS_Report_Controller\n'
+'//scheduler job nane -> Bair Raids Report Monitor\n'
+'//queued job nane -> Bair Raids Report Controller\n'
+'//EVERY_TWO_MINUTES:\n'
+'// if any \'Bair Raids Report Email\' in process, do nothing\n'
+'// else spin Bair.raidsReportScheduler_CRON by notifying the scheduler -> Bair Raids Report Scheduler\n'
+'// Expected execution time -> 30 seconds\n'
+'\n'
+'#stored(\'cluster\',\'bair-qa\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'\n'
+'wumonitor := \'Bair Raids Report Monitor\';\n'
+'#WORKUNIT(\'name\', wumonitor);\n'
+'wuname := \'Bair Raids Report Email\';\n'
+'valid_state := [\'blocked\',\'running\',\'wait\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit = false, NOTIFY(\'Bair Raids Report Scheduler\',\'*\'));\n'
;
 
#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Raids Report Controller');
wk_ut.CreateWuid(ECL,THOR,Bair._ESP):
													WHEN(cron(EVERY_TWO_MINUTES))
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Raids Report Controller Failure'
													,Bair.email_msg(workunit).NOC_MSG
													));