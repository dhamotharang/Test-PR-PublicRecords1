// Bair._CRON_Build_Comp_Delta
// scheduler job nane -> Bair Composite Delta Build Scheduler
// queued job nane -> Bair COMPOSITE Delta Build and Deploy:
// ON_NOTIFY: bld_and_deploy_compositekeys_delta
	// Build Composite keys delta
// Expected execution time -> 30-45 minutes

import wk_ut,_Control;
THOR:='thor40';

CurDelta 		:= dataset(bair.Superfile_List(true).BuiltVers, bair.layouts.rBuiltVers, flat);
version 		:= CurDelta[1].ver;
buildName 	:= CurDelta[1].buildName;

valid_state := ['blocked','running','wait','submitted','compiling','compiled'];
comp_wuname := 'Bair COMPOSITE Delta Build and Deploy*?';
d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=comp_wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);
active_workunit_comp :=  exists(d);

run_build := If(active_workunit_comp=false,'true','false');

ECL:=
 '//Bair._CRON_Build_Comp_Delta\n'
+'//scheduler job nane -> Bair Composite Delta Build Scheduler\n'
+'//queued job nane -> Bair COMPOSITE Delta Build and Deploy:\n'
+'//ON_NOTIFY: bld_and_deploy_compositekeys_delta\n'
+'// Build Composite keys delta\n'
+'// Expected execution time -> 30-45 minutes\n'
+'\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'#stored(\'build_type\', true);\n'
+'#stored(\'cluster\',\'bair-qa\');\n'
+'\n'
+'wuname := \'Bair COMPOSITE Delta Build and Deploy: ' + version + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'seq := if (\'' + run_build + '\' = \'true\', \n'
+'							sequential(Bair_composite.Build_All(\'' + version + '\',false, true),\n'
+'													Bair.proc_pkgDelpoy(\'bair-qa\',\'' + version + '\', false, true).NonBooleanKeys,\n'
+'													Bair.proc_pkgDelpoy(\'bair-prod\',\'' + version + '\', true, true).NonBooleanKeys,\n'
+'													Bair.Orbit_Update.pushLastBuildManifest (\'' + buildName + '\',\' \', \'' + version + '\', \'composite\')\n'
+'								 				),\n'
+'							output(\'nothing\')\n'
+'							): success(Bair.Send_Email(\'' + version + '\', false, true).CompositeBuildSuccess)\n'
+'							  ,failure(Bair.send_email(\'' + version + '\', true, true).CompositeBuildFailure);\n'
+'seq;\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Composite Delta Build Scheduler');
wk_ut.CreateWuid(ECL,THOR,Bair._ESP):
													WHEN('bld_and_deploy_compositekeys_delta')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Composite Delta Build Schedule Failure'
													,Bair.email_msg(workunit).NOC_MSG
													));