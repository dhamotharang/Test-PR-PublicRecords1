// Bair._CRON_Build_Pload_Delta
// scheduler job nane -> Bair Build All Scheduler
// queued job nane -> Bair DELTA Build All
// ON_NOTIFY: Bair Build All Scheduler
	// Build payload delta
// Expected execution time -> 3-5 minutes Delta

import ut,wk_ut,std;

bair_build_name_version   := Bair.Orbit_Update.BairBuildReadyToGo():independent;
bair_build_name           := STD.STr.SplitWords(bair_build_name_version,' ')[1];
bair_build_version        := STD.STr.SplitWords(bair_build_name_version,' ')[2];
bair_reprocess_flag       := STD.STr.SplitWords(bair_build_name_version,' ')[3];

run_bair_build    := if(bair_build_version !='','true','false');

agency_build_name_version := Bair.Orbit_Update.AgencyBuildReadyToGo():independent;
agency_build_name         := STD.STr.SplitWords(agency_build_name_version,' ')[1];
agency_build_version      := STD.STr.SplitWords(agency_build_name_version,' ')[2];
agency_build_to_run       := if(run_bair_build = 'false' and agency_build_name_version !='','true','false');

//valid_state := ['blocked','running','wait'];
valid_state := ['blocked','running','wait','submitted','compiling','compiled'];
prep_wuname := 'Bair Importer - Importing*?';

d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=prep_wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);
d_wu := d[1].wuid;
active_workunit_prep :=  exists(d);

run_agency_build          := if(agency_build_to_run = 'true' and active_workunit_prep = false,'true','false');
run_build                 := if(run_agency_build ='true' or run_bair_build = 'true', 'true', 'false');

build_name         				:= if(run_bair_build='true',bair_build_name, agency_build_name);
build_version       			:= if(run_bair_build='true',bair_build_version, agency_build_version);
scheduler_type            := if(run_bair_build='true','BAIR','AGENCIES');

scheduler_title           := if(run_build = 'true' , ' - ' + scheduler_type + ' ' +  build_version + ' ' + bair_reprocess_flag,' - NO BUILD'); 

ECL:=
 '//Bair._CRON_Build_Pload_Full_or_Delta\n'
+'//scheduler job nane -> Bair Build All Scheduler\n'
+'//queued job nane -> Bair DELTA Build All\n'
+'//ON_NOTIFY: Bair Build All Scheduler\n'
+'// Build payload delta\n'
+'// Expected execution time -> 3-5 minutes Delta\n'
+'\n'
+'#stored(\'cluster\',\'bair-qa\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'\n'
+'STRING pDate 						:= ut.GetDate:INDEPENDENT;\n'
+'STRING pTime 						:= ut.GetTimeStamp():INDEPENDENT;\n'
+'STRING pVersion 				:= pDate + \'_\' + pTime;\n'
+'tVersion := \'t\' + pVersion;\n'
+'\n'
+'pUseProd 	:= false;\n'
+'\n'
+'sentinel_Flag             := if(\'' + agency_build_to_run + '\'=\'true\', Bair_importer.Sentinel_Flag.fn_SetBairSentinelFlag(TRUE,tVersion,TRUE));\n'
+'sentinel_Flag;\n'
+'\n'
+'wuname := \'Bair DELTA Build All\'+\'' + scheduler_title + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'\n'
+'IsUpdates 								:= if(regexfind(\'w\',\''+ build_version + '\',nocase) = true, false, true);\n'
+'building                  := if (\'' + run_build + '\' = \'true\', \n'
+'																	Sequential(Bair.Orbit_Update.SetOrbitForBuildAll(\''+build_name+'\',\''+build_version+'\',\''+bair_reprocess_flag+'\')\n'
+'																						,Bair.Build_All(\''+build_name+'\',\''+build_version+'\', pUseProd,IsUpdates);\n'
+'																						),\n'
+'													        output(\'nothing\')\n'
+'															   );\n'
+'building;\n'
;

sthor := if(run_build='true','thor40','hthor');
#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Build All Scheduler');
wk_ut.CreateWuid(ECL,sthor,Bair._ESP):
													WHEN('Bair Build All Scheduler')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Build All Scheduler Failure'
													,Bair.email_msg(workunit).NOC_MSG
													));