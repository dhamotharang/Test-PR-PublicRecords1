/*
************************************************************************************
************************************************************************************
*************** SCHEDULE IN BOTH PROD and DR ***************************************
************************************************************************************
************************************************************************************
*/
// Bair._CRON_Backup_ByPeriod_Controller
// scheduler job name -> _CRON_Backup_ByPeriod_Controller
// queued job nane -> Bair Backup ByPeriod Controller
// EVERY_TWO_MINUTES:
	// if no last_byperiod_manifest_inprogress file exist or there is no file backup scheduled within the period do nothing
		// else spin Bair._CRON_Backup_ByPeriod_Scheduler by notifying the scheduler -> Bair Backup ByPeriod Scheduler
// Expected execution time -> 30 seconds

import wk_ut,_Control,Bair,std;
EVERY_TWO_MINUTES:='0-59/2 * *	*	*';

ECL:=
'#stored(\'cluster\',\'bair-prod\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'wumonitor := \'Bair Backup ByPeriod Monitor\';\n'
+'#WORKUNIT(\'name\', wumonitor);\n'
+'wunameB := \'Bair Backup ByPeriod*?\';\n'
+'wunameException := [\'Bair Backup ByPeriod Monitor\',\'Bair Backup ByPeriod Controller\',\'Bair Backup ByPeriod Scheduler\'];\n'
+'valid_state := [\'blocked\',\'running\',\'wait\',\'compiling\',\'compiled\',\'submitted\'];\n'
+'dupdwusB := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wunameB))(wuid <> thorlib.wuid() and state in valid_state and job not in wunameException), -wuid);\n'
+'d := dupdwusB;\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'lastVersionFileNameInProgress  := \'~thor_data400::out::bair::backup::last_byperiod_manifest_inprogress\';\n'
+'if(active_workunit = false and EXISTS(Bair.Backup_ByPeriod.getBackupByPeriodReadyToGo()) and FileServices.FileExists(lastVersionFileNameInProgress)=TRUE,NOTIFY(\'Bair Backup ByPeriod Scheduler\',\'*\'));\n'
;
wumonitor := 'Bair Backup ByPeriod Monitor';
dmonitor := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wumonitor))(wuid <> thorlib.wuid()), -wuid);
dwu      := dmonitor[1].wuid;
active_monitor :=  dmonitor[1].state !='completed';

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Backup ByPeriod Controller');
if (active_monitor=FALSE,wk_ut.CreateWuid(ECL,'hthor',Bair._ESP),''):
													WHEN(cron(EVERY_TWO_MINUTES))
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Backup ByPeriod Controller Failure'
													,Bair.email_msg(workunit).NOC_MSG
													));
