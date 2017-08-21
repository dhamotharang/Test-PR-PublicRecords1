// Bair._CRON_Import_Controller
// scheduler job nane -> Bair Importer Controller
// queued job nane -> Monitor Bair Importer
// Monitors EVERY_MINUTE and runs twice for a net of EVERY_TWENTYEIGHT_SECONDS:
	// if no importer submitted, compiling, blocked, or running then start a new one
	// if importer in queue running longer than 2 hour, notify developers
	// reports every 10K geocder calls
// Expected execution time -> 30 seconds

import wk_ut,_Control;
EVERY_THREE_MINUTES:='*/3 * * * *';
EVERY_MINUTE:='*/2 * * * *';

ECL:= 
 '//Bair._CRON_Import_Controller\n'
+'//scheduler job nane -> Bair Importer Controller\n'
+'//queued job nane -> Monitor Bair Importer\n'
+'// Monitors EVERY_MINUTE and runs twice for a net of EVERY_TWENTYEIGHT_SECONDS:\n'
+'// if no importer submitted, compiling, blocked, or running then start a new one\n'
+'// if importer in queue running longer than 2 hour, notify developers\n'
+'// reports every 10K geocder calls\n'
+'\n'
+'// Expected execution time -> 20 seconds\n'
+'\n'
+'#WORKUNIT(\'name\', \'Monitor Bair Importer\')\n'
+'file_list	:=FileServices.RemoteDirectory(Bair._Constant.bair_batchlz, \'/data/batchimport/ready/\', \'MANIFEST*\'):independent;\n'
+'file_list_f := file_list(regexfind(\'^MANIFEST_([0-9_]+)$\',name));\n'
+'manifest_count := count(file_list_f);\n'

+'fwuname := \'Bair Importer - Importing*\';\n'
+'valid_state := [\'\',\'unknown\',\'submitted\', \'compiling\', \'compiled\',\'blocked\',\'running\',\'wait\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=fwuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;\n'// and job not in wunameException), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'\n'
+'dummy:=\'\';\n'
+'noGo:=sequential(dummy);\n'
+'IF(active_workunit = false\n'
+'  ,sequential(\n'
+'				 output(d)\n'
+'				,if(manifest_count > 0,NOTIFY(\'bair_batchimporter\',\'*\'),NOTIFY(\'bair_importer\',\'*\'))\n'
+'				,bair_batchimporter.Monitor.FindTimeIssues().EmailNotification\n'
+'				,bair_batchimporter.monitor.CheckGeoMaxCalls().EmailNotification\n'
+'				)\n'
+'  ,noGo);'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Importer Controller');
wk_ut.CreateWuid(ECL,'hthor',Bair._ESP):
													 WHEN(cron(EVERY_MINUTE))
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Importer Controller Failure'
													,Bair.email_msg(workunit).NOC_MSG
													));						