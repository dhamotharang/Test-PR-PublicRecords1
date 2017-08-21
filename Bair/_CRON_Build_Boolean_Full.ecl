// Bair._CRON_Build_Boolean_Full
// scheduler job nane -> Bair Boolean Full Build Scheduler
// queued job nane -> Bair BOOLEAN Full Build and Deploy:
// ON_DEMAND:
	// Build Boolean keys full

import wk_ut,_Control;
THOR:='thor40';

CurFull 		:= dataset(bair.Superfile_List(false).BuiltVers, bair.layouts.rBuiltVers, flat);
version 		:= CurFull[1].ver;

ECL:=
 '//Bair._CRON_Build_Boolean_Full\n'
+'//scheduler job nane -> Bair Boolean Full Build Scheduler\n'
+'//queued job nane -> Bair BOOLEAN Full Build and Deploy:\n'
+'\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'#stored(\'cluster\',\'bair-qa\');\n'
+'\n'
+'wuname := \'Bair BOOLEAN Full Build and Deploy: ' + version + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'seq := sequential(bair_boolean.proc_build_boolean_keys(\'' + version + '\', false),\n'
+'									notify(\'bld_and_deploy_compositekeys_full\',\'*\'),\n'
+'									Bair.post_BuiltVers(\'' + version + '\').BooleanFull,\n'
+'									Bair.proc_pkgDelpoy(\'bair-qa\',\'' + version + '\', false, false).BooleanKeys,\n'
+'									Bair.proc_pkgDelpoy(\'bair-prod\',\'' + version + '\', true, false).BooleanKeys,\n'
+'									Bair.Post_LastFullPkgType(true).all,\n'
+'								 )\n'
+'								 : success(Bair.Send_Email(\'' + version + '\', false, false).BooleanBuildSuccess)\n'
+'								  ,failure(Bair.send_email(\'' + version + '\', false, false).BooleanBuildFailure)\n'
+'								;\n'
+'seq;\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Boolean Full Build Scheduler');
wk_ut.CreateWuid(ECL,THOR,Bair._ESP):
													WHEN('bld_and_deploy_booleankeys_full')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Boolean Full Build Schedule Failure'
													,Bair.email_msg(workunit).NOC_MSG
													));