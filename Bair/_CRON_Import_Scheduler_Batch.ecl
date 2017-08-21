// Bair._CRON_Import_Scheduler_Batch
// scheduler job name -> Bair Importer Scheduler_Batch
// queued job name -> Bair Importer - Importing Batch yyyyMMdd_HHmmss_999999999
//								 -> Bair Importer Listening | Sentinel=Available
//								 -> Bair Importer Listening | Sentinel=Blocked
// ON_NOTIFY: bair_batchimporter
	// Get Files ready from Manifest
	// Spray the UTF8 Files from LZ
	// Build Input Files
// Expected execution time -> variable, it depends of the file	
	
import ut,wk_ut,Bair,_control,STD,bair_importer;
#WORKUNIT('name', 'Bair Importer Scheduler Batch');
sentinel := (boolean)bair_importer.Sentinel_Flag.fn_GetBairSentinelFlag():INDEPENDENT;
xcount := sum(dataset(bair_importer._Constants.bair_geocoding_log,bair_importer.layouts.Bair_Geocoding_Log,thor,opt),counts):INDEPENDENT; 

file_list	:=FileServices.RemoteDirectory(Bair._Constant.bair_batchlz, '/data/batchimport/ready/', 'MANIFEST*'):independent;	
file_list_f := file_list(regexfind('^MANIFEST_([0-9_]+)$',name));
pBuildVersion := regexfind('([a-z_A-Z]+)_([0-9_]+)',file_list_f[1].name,2):independent;			

ECL0:=  
'//CRON BAIR IMPORTER\n'
+'// Bair_importer._CRON_Import_Scheduler_Batch'
+'// scheduler job name -> Bair Importer Scheduler_Batch'
+'// queued job name -> Bair Importer - Importing Batch yyyyMMdd_HHmmss_999999999'
+'//								 -> Bair Importer Listening | Sentinel=Available'
+'//								 -> Bair Importer Listening | Sentinel=Blocked'
+'// ON_NOTIFY: bair_batchimporter'
+'// Get Files ready from Manifest'
+'// Spray the UTF8 Files from LZ'
+'// Build Input Files'
+'\n'
+'// Expected execution time -> variable, it depends of the file'	
+'\n'
;
wuname := 'Bair Importer - Importing*';
valid_state := ['','unknown','submitted', 'compiling','compiled','blocked','running','wait'];
d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;
d_wu := d[1].wuid;
active_workunit :=  exists(d);

ECL:= if(count(file_list_f)>0 and active_workunit = false
	,ECL0
+'#workunit(\'priority\',\'high\');\n'
+'#option(\'maxCsvRowSizeMb\', 1000);\n'
+'#stored(\'cluster\',\'bair-prod\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'

+'wuname := \'Bair Importer - Importing*\';\n'
+'valid_state := [\'submitted\', \'compiling\',\'blocked\',\'running\',\'wait\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);\n'// and job not in wunameException), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'dummy:=\'\';\n'
+'noGo:=sequential(dummy);\n'
+'#WORKUNIT(\'name\', \'Bair Importer - Importing Batch ' + pBuildVersion + '\')\n'
+'IF(active_workunit = false\n'
+'  ,sequential(\n'
+'				 output(d)\n'
+'	       ,Bair_BatchImporter.Build_all()\n'
+'	       ,notify(\'Bair Build All Scheduler\',\'*\')\n'
+'				)\n'
+'	,noGo\n'
+'	);\n'
,ECL0
	
+'wuname := \'Bair Importer Listening | Sentinel=' + if(sentinel,'Blocked','Available') + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
);

THOR := if (count(file_list_f)>0,'thor40','hthor');

#WORKUNIT('protect',true);
wk_ut.CreateWuid(ECL,THOR,Bair._ESP) : when('bair_batchimporter')
														, FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
																		,'*** ALERT **** Bair Importer Scheduler Failure'
																		,Bair.email_msg(workunit).NOC_MSG
																	));
