import Bair, ut,wk_ut;

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

callMonitor:= wk_ut.CreateWuid(ECL,'hthor','10.240.160.19');

wumonitor 				:= 'Bair Backup ByPeriod Monitor';
dmonitor 					:= sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wumonitor))(wuid <> thorlib.wuid()), -wuid);
dwu      					:= dmonitor[1].wuid;
active_monitor 		:= dmonitor[1].state !='completed';
dontCallMonitor		:= 'Monitor in Progress';
dsubmitted		 		:= sort(nothor(WorkunitServices.WorkunitList('', NAMED username:='fincarnacao', NAMED state:='submitted'))(wuid <> thorlib.wuid()), -wuid);
pendingSubmitted 	:= Count(dsubmitted) > 2;

CRONController 		:= if (active_monitor = TRUE or pendingSubmitted = TRUE, dontCallMonitor, callMonitor);

CRONController;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Backup ByPeriod Controller');
CRONController: when(cron('0-59/2 * *	*	*'))
														,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com;debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;'
																		,'Bair Backup ByPeriod Controller'
																		,'Bair Backup ByPeriod Controller failure\n'
																		+'Bair Backup ByPeriod Controller \n'
																		+'See '+workunit+'\n\n'
																		+FAILMESSAGE
																		));	