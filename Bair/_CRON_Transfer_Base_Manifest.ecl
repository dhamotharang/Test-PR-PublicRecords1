/*
************************************************************************************
************************************************************************************
*************** SCHEDULE IN BOTH PROD and DR ***************************************
************************************************************************************
************************************************************************************
*/
// Bair._CRON_Transfer_Base_Manifest
// scheduler job name -> Bair Base Manifest Transfer Scheduler
// queued job nane -> Bair Base Manifest Transfer:
// ON_DEMAND:
// Bair Base Manifest Transfer
// WAITS for a notification of transfer_base_manifest

import wk_ut,_Control,Bair,std;
THOR:='hthor';
targetIP    									:= Bair._Constant.copyFromIP;
lastBaseManifestFileName 			:= 'thor_data400::out::bair::backup::last_base_manifest';
lastBaseManifestFileNameCopied := '~'+lastBaseManifestFileName;

ECL:=
 '// Bair._CRON_Transfer_Base_Manifest \n'
+'// scheduler job name -> Bair Base Manifest Transfer Scheduler \n'
+'// queued job nane -> Bair Base Manifest Transfer: \n'
+'\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'#stored(\'cluster\',\'bair-qa\');\n'
+'\n'
//+'wuname := \'Bair Base Manifest Transfer: ' + pVersion + '\';\n'
+'wuname := \'Bair Base Manifest Transfer\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'nothor(STD.File.copy(\''+ targetIP + lastBaseManifestFileName + '\', \'thor40\' ,\''+ lastBaseManifestFileNameCopied + '\', NAMED allowoverwrite:=TRUE, NAMED compress:=true));\n'  
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Base Manifest Transfer Scheduler');
wk_ut.CreateWuid(ECL,THOR,Bair._ESP):
													WHEN('transfer_base_manifest')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Base Manifest Transfer Scheduler'
													,Bair.email_msg(workunit).NOC_MSG
													));