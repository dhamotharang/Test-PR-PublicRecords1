// Bair._CRON_Build_Payloads
// scheduler job nane -> Bair Build All Scheduler
// queued job nane -> Bair DELTA Build All
// ON_NOTIFY: Bair Build All Scheduler
	// Build payload delta
// Expected execution time -> 3-5 minutes Delta

import ut,wk_ut,std;

BldChkPt				:= dataset(Bair.Superfile_List(true).BldChkPt, {unsigned1 pos}, flat, opt);
ChkPtPos				:= BldChkPt[1].pos;
rec_lastBld	:= if(ChkPtPos < 12, true, false);

reprocess 		:= if(rec_lastBld,'true','false');

PrevDelta 		:= dataset(bair.Superfile_List(true).BuiltVers, bair.layouts.rBuiltVers, flat);
PrevBldVer 	:= PrevDelta[1].ver;
PrevBldName := PrevDelta[1].buildName;

bair_build_name_version   := Bair.Manage_Builds.BairBuildReadyToGo():independent;
bair_build_name           := STD.STr.SplitWords(bair_build_name_version,' ')[1];
bair_build_version        := STD.STr.SplitWords(bair_build_name_version,' ')[2];
run_bair_build    								:= if(bair_build_version !='','true','false');

agency_build_name_version := Bair.Manage_Builds.AgencyBuildReadyToGo():independent;
agency_build_name         := STD.STr.SplitWords(agency_build_name_version,' ')[1];
agency_build_version      := STD.STr.SplitWords(agency_build_name_version,' ')[2];
agency_build_to_run       := if(run_bair_build = 'false' and agency_build_name_version !='','true','false');

valid_state 	:= ['blocked','running','wait','submitted','compiling','compiled'];
prep_wuname 	:= 'Bair Importer - Importing*?';
build_wuname := 'Bair DELTA Build All*?';
bool_wuname 	:= 'Bair BOOLEAN Delta Build and Deploy*?';

d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=prep_wuname))(wuid <> thorlib.wuid() and state in valid_state)
+         nothor(WorkunitServices.WorkunitList('',NAMED jobname:=build_wuname))(wuid <> thorlib.wuid() and state in valid_state)
+         nothor(WorkunitServices.WorkunitList('',NAMED jobname:=bool_wuname))(wuid <> thorlib.wuid() and state in valid_state)
					, -wuid);
d_wu := d[1].wuid;
active_workunit_prep :=  exists(d);

run_agency_build   := if(agency_build_to_run = 'true' and active_workunit_prep = false,'true','false');
run_recover_build  := if(rec_lastBld = true and active_workunit_prep = false,'true','false');
run_build          := if(run_agency_build ='true' or run_bair_build = 'true' or run_recover_build = 'true', 'true', 'false');

build_name         := if(rec_lastBld
																							,PrevBldName
																							,if(run_bair_build='true',bair_build_name, agency_build_name)
																							);
build_version      := if(rec_lastBld
																							,PrevBldVer
																							,if(run_bair_build='true',bair_build_version, agency_build_version)
																							);
																							
scheduler_type     := if(rec_lastBld
																							,if(regexfind('bair', PrevBldName, nocase),'BAIR','AGENCIES')
																							,if(run_bair_build='true','BAIR','AGENCIES')
																							);

scheduler_title    := if(run_build = 'true', if(rec_lastBld,' AUTO RECOVER','') + ' - ' + scheduler_type + ' ' +  build_version,' - NO BUILD'); 

ECL0:=
 '//Bair._CRON_Build_Payloads\n'
+'//scheduler job nane -> Bair Build All Scheduler\n'
+'//queued job nane -> Bair FULL or DELTA Build All\n'
+'//ON_NOTIFY: Bair Build All Scheduler\n'
+'// Build payload full or delta\n'
+'// Expected execution time -> 3-5 minutes Delta\n'
+'\n'
;

ECL:= 
 ECL0
 + if(run_build='true'
	,'#stored(\'cluster\',\'bair-qa\');\n'
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
	+'IsUpdates 							:= if(regexfind(\'w\',\''+ build_version + '\',nocase) = true, false, true);\n'
	+'wuname := \'Bair \'+if(IsUpdates,\'DELTA\',\'FULL\')+\' Build All\'+\'' + scheduler_title + '\';\n'
	+'#WORKUNIT(\'name\', wuname);\n'
	+'\n'
	+'Sequential(\n'
	+'           Bair_importer.Sentinel_Flag.fn_SetBairSentinelFlag(TRUE,tVersion,TRUE)\n'
	+'    			   ,Bair.Build_All(\''+build_name+'\',\''+build_version+'\', pUseProd,IsUpdates,'+reprocess+');\n'
	+'          );\n'
//ELSE
	,'wuname := \''+if(active_workunit_prep,'DELTA blocked by active importer','No DELTAS to build')+'\';\n'
	+'#WORKUNIT(\'name\', wuname);\n'
	);

sthor := if(run_build='true','thor40','hthor');
#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Build All Scheduler');
wk_ut.CreateWuid(ECL,sthor,Bair._ESP):
													WHEN('Bair Build All Scheduler')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Build All Scheduler Failure'
													,Bair.email_msg(workunit).NOC_MSG
													));