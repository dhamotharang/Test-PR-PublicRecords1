/*2016-06-30T22:38:27Z (Oscar Barrientos)

*/
// Bair_importer._CRON_Import_Scheduler
// scheduler job name -> Bair Importer Scheduler
// queued job name -> Bair Importer - Importing yyyyMMdd_HHmmssfff
//								 -> Bair Importer Listening | Sentinel=Available
//								 -> Bair Importer Listening | Sentinel=Blocked
// ON_NOTIFY: bair_importer
	// Get Files ready from Orbit
	// Spray the XML Files from LZ
	// Build Input Files
// Expected execution time -> variable, it depends of the file	
	
import ut,wk_ut,Bair,_control,STD,bair_importer;
#WORKUNIT('name', 'Bair Importer Scheduler');
sentinel := (boolean)bair_importer.Sentinel_Flag.fn_GetBairSentinelFlag():INDEPENDENT;
xcount := sum(dataset(bair_importer._Constants.bair_geocoding_log,bair_importer.layouts.Bair_Geocoding_Log,thor,opt),counts):INDEPENDENT; 

NextPrepBuildReadyToGo := if (sentinel=false and xcount < bair_importer._Constants.max_geocoding_calls,bair.Orbit_Update.FindNextPrepBuildReadyToGo('')):INDEPENDENT;

pFileType := NextPrepBuildReadyToGo[1].filetype;
pBuildName := NextPrepBuildReadyToGo[1].buildname;
pBuildVersion := NextPrepBuildReadyToGo[1].buildversion;
pLandingZone := NextPrepBuildReadyToGo[1].landingzone;
pFileExtension := NextPrepBuildReadyToGo[1].fileextension;
pAgency := NextPrepBuildReadyToGo[1].agency;
pPreppedAgencyBuildVersion := NextPrepBuildReadyToGo[1].preppedagencybuildversion;
pReprocess := NextPrepBuildReadyToGo[1].ReProcessFlag;
pReceivingId := NextPrepBuildReadyToGo[1].receivingid;
//pReprocess := 'Reprocess';
pDaliServer  	:= Bair._Constant.bair_batchlz;
pThorServer		:= 'thor40';
			
ECL0:=  
'//CRON BAIR IMPORTER\n'
+'// Bair_importer._CRON_Import_Scheduler'
+'// scheduler job name -> Bair Importer Scheduler'
+'// queued job name -> Bair Importer - Importing yyyyMMdd_HHmmssfff'
+'//								 -> Bair Importer Listening | Sentinel=Available'
+'//								 -> Bair Importer Listening | Sentinel=Blocked'
+'// ON_NOTIFY: bair_importer'
+'// Get Files ready from Orbit'
+'// Spray the XML Files from LZ'
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

ECL:= if(count(NextPrepBuildReadyToGo)>0 and active_workunit = false
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
+'#WORKUNIT(\'name\', \'Bair Importer - Importing ' + pBuildName + ' ' + pBuildVersion + '\')\n'
+'IF(active_workunit = false\n'
+'  ,sequential(\n'
+'				 output(d)\n'
+'	       ,Bair_importer.Build_All(\''+pFileType+'\',\''+pBuildName+'\',\''+pBuildVersion+'\',\''+pLandingZone+'\',\''+pFileExtension+'\',\''+pAgency+'\',\''+pPreppedAgencyBuildVersion+'\',\''+pReprocess+'\',\''+pReceivingId+'\')\n'
+'	       ,notify(\'Bair Build All Scheduler\',\'*\')\n'
+'				)\n'
+'	,noGo\n'
+'	);\n'
,ECL0
	
+'wuname := \'Bair Importer Listening | Sentinel=' + if(sentinel,'Blocked','Available') + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
);

THOR := if (count(NextPrepBuildReadyToGo)>0,'thor40','hthor');

#WORKUNIT('protect',true);
wk_ut.CreateWuid(ECL,THOR,Bair._ESP) : when('bair_importer')
														, FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
																		,'*** ALERT **** Bair Importer Scheduler Failure'
																		,Bair.email_msg(workunit).NOC_MSG
																	));
