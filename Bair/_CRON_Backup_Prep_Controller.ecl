/*
************************************************************************************
************************************************************************************
*************** SCHEDULE IN BOTH PROD and DR ***************************************
************************************************************************************
************************************************************************************
*/
// Bair._CRON_Backup_Prep_Controller
// scheduler job name -> _CRON_Backup_Prep_Controller
// queued job nane -> Bair Backup Prep Controller
// EVERY_TWO_MINUTES:
	// if no last_base_manifest_inprogress file exist do nothing
		// else spin Bair._CRON_Backup_Prep_Scheduler by notifying the scheduler -> Bair Backup Prep Scheduler
// Expected execution time -> 30 seconds

import wk_ut,_Control,Bair,std;
EVERY_TWO_MINUTES:='0-59/2 * *	*	*';

ECL:=
'#stored(\'cluster\',\'bair-prod\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'wumonitor := \'Bair Backup Prep Monitor\';\n'
+'#WORKUNIT(\'name\', wumonitor);\n'
+'wunameB := \'Bair Backup Prep*?\';\n'
+'wunameException := [\'Bair Backup Prep Monitor\',\'Bair Backup Prep Controller\',\'Bair Backup Prep Scheduler\'];\n'
+'valid_state := [\'blocked\',\'running\',\'wait\',\'compiling\',\'compiled\',\'submitted\'];\n'
+'dupdwusB := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wunameB))(wuid <> thorlib.wuid() and state in valid_state and job not in wunameException), -wuid);\n'
+'d := dupdwusB;\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'lastVersionFileName  := \'thor_data400::out::bair::backup::last_prep_manifest_w*\';\n'
+'lastVersionFile:=SORT(STD.File.LogicalFileList(lastVersionFileName),name)[1]:INDEPENDENT;\n'
+'lastVersionFileNameInProgress  := \'~thor_data400::out::bair::backup::last_prep_manifest_inprogress\';\n'
+'run_backup :=Sequential(STD.File.RenameLogicalFile(\'~\'+lastVersionFile.name,lastVersionFileNameInProgress),\n'
+'                        NOTIFY(\'Bair Backup Prep Scheduler\',\'*\'));\n'           
+'if(active_workunit = false and lastVersionFile.name!=\'\' and FileServices.FileExists(lastVersionFileNameInProgress)=FALSE,run_backup);\n'
;
wumonitor := 'Bair Backup Prep Monitor';
dmonitor := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wumonitor))(wuid <> thorlib.wuid()), -wuid);
dwu      := dmonitor[1].wuid;
active_monitor :=  dmonitor[1].state !='completed';

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Backup Prep Controller');
if (active_monitor=FALSE,wk_ut.CreateWuid(ECL,'hthor',Bair._ESP),''):
													WHEN(cron(EVERY_TWO_MINUTES))
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Backup Prep Controller Failure'
													,Bair.email_msg(workunit).NOC_MSG
													));
