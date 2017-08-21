/*
************************************************************************************
************************************************************************************
*************** SCHEDULE IN DR *****************************************************
************************************************************************************
************************************************************************************
*/
// Bair._CRON_Backup_Base_Scheduler
// scheduler job nane -> Bair Backup Base Scheduler
// queued job nane -> Bair Backup Composite Scheduler
// ON_NOTIFY: Bair Backup Composite Scheduler
	// Copy last delta files built
// Expected execution time -> 10-15 minutes Delta

import wk_ut,_Control,Bair,std;
THOR:='hthor';
lastBuiltFileNameInProcess := '~thor_data400::out::bair::backup::last_Composite_manifest_inprogress';
versionToBackupD := dataset(lastBuiltFileNameInProcess,Bair._Constant.manifest_layout, THOR,OPT);
pVersion  := STD.Str.RemoveSuffix(versionToBackupD[1].version,' ');

ECL:=
'#stored(\'cluster\',\'bair-dr\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'

+'wuname := \'Bair Backup Composite - '+pVersion+'\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'Bair.Backup_Composite.CopyUpdateCompositeDR();\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Backup Composite Scheduler');
wk_ut.CreateWuid(ECL,THOR,Bair._ESP):
													WHEN('Bair Backup Composite Scheduler')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Backup Composite Scheduler'
													,Bair.email_msg(workunit).NOC_MSG
													));