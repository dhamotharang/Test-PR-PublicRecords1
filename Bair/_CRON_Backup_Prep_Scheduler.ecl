/*
************************************************************************************
************************************************************************************
*************** SCHEDULE IN BOTH PROD and DR ***************************************
************************************************************************************
************************************************************************************
*/
// Bair._CRON_Backup_Prep_Scheduler
// scheduler job nane -> Bair Backup Prep Scheduler
// queued job nane -> Bair Backup Prep Scheduler
// ON_NOTIFY: Bair Backup Prep Scheduler
	// Copy last prepped files built
// Expected execution time -> 1-2 minutes

import wk_ut,_Control,Bair,std;
THOR:='hthor';
lastBuiltFileNameInProcess := '~thor_data400::out::bair::backup::last_prep_manifest_inprogress';
versionToBackupD := dataset(lastBuiltFileNameInProcess,Bair._Constant.manifest_layout, THOR,OPT);
pVersion  := STD.Str.RemoveSuffix(versionToBackupD[1].version,' ');

ECL:=
'#stored(\'cluster\',\'bair-dr\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'

+'wuname := \'Bair Backup Prep - '+pVersion+'\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'Bair.Backup_Prep.CopyUpdatePrepDR();\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Backup Prep Scheduler');
wk_ut.CreateWuid(ECL,THOR,Bair._ESP):
													WHEN('Bair Backup Prep Scheduler')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Backup Prep Scheduler'
													,Bair.email_msg(workunit).NOC_MSG
													));