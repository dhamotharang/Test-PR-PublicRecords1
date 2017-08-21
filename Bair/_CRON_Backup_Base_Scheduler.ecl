/*
************************************************************************************
************************************************************************************
*************** SCHEDULE IN BOTH PROD and DR ***************************************
************************************************************************************
************************************************************************************
*/
// Bair._CRON_Backup_Base_Scheduler
// scheduler job nane -> Bair Backup Base Scheduler
// queued job nane -> Bair Backup Base Scheduler
// ON_NOTIFY: Bair Backup Base Scheduler
	// Copy last delta files built
// Expected execution time -> 10-15 minutes Delta

import wk_ut,_Control,Bair,std;
THOR:='hthor';
lastBuiltFileNameInProcess := '~thor_data400::out::bair::backup::last_base_manifest_inprogress';
versionToBackupD := dataset(lastBuiltFileNameInProcess,Bair._Constant.manifest_layout, THOR,OPT);
pVersion  := STD.Str.RemoveSuffix(versionToBackupD[1].version,' ');

ECL:=
'#stored(\'cluster\',\'bair-dr\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'

+'wuname := \'Bair Backup Base - '+pVersion+'\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'Bair.Backup_base.CopyUpdateBaseDR();\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Backup Base Scheduler');
wk_ut.CreateWuid(ECL,THOR,Bair._ESP):
													WHEN('Bair Backup Base Scheduler')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Backup Base Scheduler'
													,Bair.email_msg(workunit).NOC_MSG
													));