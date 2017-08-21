import Bair, ut,wk_ut;

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
+'lastVersionFileName  := \'thor_data400::out::bair::backup::last_prep_manifest_sent*\';\n'
+'lastVersionFile:=SORT(STD.File.LogicalFileList(lastVersionFileName),name)[1]:INDEPENDENT;\n'
+'lastVersionFileNameInProgress  := \'~thor_data400::out::bair::backup::last_prep_manifest_inprogress\';\n'
+'run_backup :=Sequential(STD.File.RenameLogicalFile(\'~\'+lastVersionFile.name,lastVersionFileNameInProgress),\n'
+'                        NOTIFY(\'Bair Backup Prep Scheduler\',\'*\'));\n'           
+'if(active_workunit = false and lastVersionFile.name!=\'\' and FileServices.FileExists(lastVersionFileNameInProgress)=FALSE,run_backup);\n'
;

callMonitor:= wk_ut.CreateWuid(ECL,'hthor','10.240.160.19');

wumonitor 				:= 'Bair Backup Prep Monitor';
dmonitor 					:= sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wumonitor))(wuid <> thorlib.wuid()), -wuid);
dwu      					:= dmonitor[1].wuid;
active_monitor 		:= dmonitor[1].state !='completed';
dontCallMonitor		:= 'Monitor in Progress';
dsubmitted		 		:= sort(nothor(WorkunitServices.WorkunitList('', NAMED username:='fincarnacao', NAMED state:='submitted'))(wuid <> thorlib.wuid()), -wuid);
pendingSubmitted 	:= Count(dsubmitted) > 2;

CRONController 		:= if (active_monitor = TRUE or pendingSubmitted = TRUE, dontCallMonitor, callMonitor);

CRONController;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Backup Prep Controller');
CRONController: when(cron('0-59/2 * *	*	*'))
														,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com;debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;'
																		,'Bair Backup Prep Controller'
																		,'Bair Backup Prep Controller failure\n'
																		+'Bair Backup Prep Controller \n'
																		+'See '+workunit+'\n\n'
																		+FAILMESSAGE
																		));	