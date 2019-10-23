// Bair._CRON_Build_Boolean_Delta
// scheduler job nane -> Bair Boolean Delta Build Scheduler
// queued job nane -> Bair BOOLEAN Delta Build and Deploy:
// ON_DEMAND:
	// Build Boolean keys delta

import wk_ut,_Control;
THOR:='thor40';

CurDelta 		:= dataset(bair.Superfile_List(true).BuiltVers, bair.layouts.rBuiltVers, flat);
version 		:= CurDelta[1].ver;
buildName 	:= CurDelta[1].buildName;

ECL:=
 '//Bair._CRON_Build_Boolean_Delta\n'
+'//scheduler job nane -> Bair Boolean Delta Build Scheduler\n'
+'//queued job nane -> Bair BOOLEAN Delta Build and Deploy:\n'
+'\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'#stored(\'cluster\',\'bair-qa\');\n'
+'\n'
+'wuname := \'Bair BOOLEAN Delta Build and Deploy: ' + version + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'seq := sequential(Bair.Manage_Builds.BuildManifest (\'' + buildName + '\',\'' + version + '\', \'Built\'),\n'
+'									bair_boolean.proc_build_boolean_keys(\'' + version + '\', true),\n'
+'									Bair.proc_pkgDelpoy(\'bair-qa\',\'' + version + '\', false, true).BooleanKeys,\n'
+'									Bair.proc_pkgDelpoy(\'bair-prod\',\'' + version + '\', true, true).BooleanKeys,\n'								  
+'								 )\n'
+'								 : success(Bair.Send_Email(\'' + version + '\', false, true).BooleanBuildSuccess)\n'
+'								  ,failure(Bair.send_email(\'' + version + '\', false, true).BooleanBuildFailure)\n'
+'								;\n'
+'seq;\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Boolean Delta Build Scheduler');
wk_ut.CreateWuid(ECL,THOR,Bair._ESP):
													WHEN('bld_and_deploy_booleankeys_delta')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Boolean Delta Build Schedule Failure'
													,Bair.email_msg(workunit).NOC_MSG
													));