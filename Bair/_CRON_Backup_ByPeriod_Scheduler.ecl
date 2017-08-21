/*
************************************************************************************
************************************************************************************
*************** SCHEDULE IN BOTH PROD and DR ***************************************
************************************************************************************
************************************************************************************
*/
// Bair._CRON_Backup_ByPeriod_Scheduler
// scheduler job nane -> Bair Backup ByPeriod Scheduler
// queued job nane -> Bair Backup ByPeriod Scheduler
// ON_NOTIFY: Bair Backup ByPeriod Scheduler
	// Copy last prepped files built
// Expected execution time -> 1-2 minutes

import wk_ut,_Control,Bair,std;
THOR:='hthor';
period_manifest_fileName    := '~thor_data400::out::bair::backup::last_byperiod_manifest_inprogress';
manifestList         	 			:= dataset(period_manifest_filename, Bair._Constant.manifest_layout, thor) : GLOBAL(FEW);
pVersion  									:= STD.Str.RemoveSuffix(manifestList[1].version,' ');

ECL:=
'#stored(\'cluster\',\'bair-dr\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'

+'wuname := \'Bair Backup ByPeriod - '+pVersion+'\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'Bair.Backup_ByPeriod.CopyUpdateByPeriodDR();\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Backup ByPeriod Scheduler');
wk_ut.CreateWuid(ECL,THOR,Bair._ESP):
													WHEN('Bair Backup ByPeriod Scheduler')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Backup ByPeriod Scheduler'
													,Bair.email_msg(workunit).NOC_MSG
													));