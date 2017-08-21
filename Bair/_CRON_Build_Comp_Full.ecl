// Bair._CRON_Build_Comp_Full
// scheduler job nane -> Bair Composite Full Build Scheduler
// queued job nane -> Bair COMPOSITE Full Build and Deploy:
// ON_NOTIFY: bld_and_deploy_compositekeys_full
	// Build Composite keys full

import wk_ut,_Control;
THOR:='thor40';

CurFull := dataset(bair.Superfile_List(false).BuiltVers, bair.layouts.rBuiltVers, flat);
version := CurFull[1].ver;

ECL:=
 '//Bair._CRON_Build_Comp_Full\n'
+'//scheduler job nane -> Bair Composite Full Build Scheduler\n'
+'//queued job nane -> Bair COMPOSITE Full Build and Deploy:\n'
+'//ON_NOTIFY: bld_and_deploy_compositekeys_full\n'
+'// Build Composite keys full\n'
+'\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#stored(\'build_type\', false);\n'
+'#stored(\'cluster\',\'bair-qa\');\n'
+'\n'
+'wuname := \'Bair COMPOSITE Full Build and Deploy: ' + version + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'seq := sequential(Bair_composite.Build_All(\'' + version + '\',false, false),\n'
+'									Bair.post_BuiltVers(\'' + version + '\').NonBooleanFull,\n'
+'									Bair.proc_pkgDelpoy(\'bair-qa\',\'' + version + '\', false, false).NonBooleanKeys,\n'
+'									Bair.proc_pkgDelpoy(\'bair-prod\',\'' + version + '\', true, false).NonBooleanKeys,\n'
+'									Bair.Post_LastFullPkgType(false).all,\n'
+'								 )'
+'								 : success(Bair.Send_Email(\'' + version + '\', false, false).CompositeBuildSuccess)\n'
+'								  ,failure(Bair.send_email(\'' + version + '\', false, false).CompositeBuildFailure)\n'
+'								;\n'
+'seq;\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Composite Full Build Scheduler');
wk_ut.CreateWuid(ECL,THOR,Bair._ESP):
													WHEN('bld_and_deploy_compositekeys_full')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Composite Full Build Schedule Failure'
													,Bair.email_msg(workunit).NOC_MSG
													));