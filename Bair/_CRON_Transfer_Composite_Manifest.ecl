/*
************************************************************************************
************************************************************************************
*************** SCHEDULE IN BOTH PROD and DR ***************************************
************************************************************************************
************************************************************************************
*/
// Bair._CRON_Transfer_Composite_Manifest
// scheduler job name -> Bair Composite Manifest Transfer Scheduler
// queued job nane -> Bair Composite Manifest Transfer:
// ON_DEMAND:
// Bair Composite Manifest Transfer
// WAITS for a notification of transfer_Composite_manifest

import wk_ut,_Control,Bair,std;
THOR:='hthor';
targetIP    									:= Bair._Constant.copyFromIP;
lastCompositeManifestFileName 			:= 'thor_data400::out::bair::backup::last_Composite_manifest';
lastCompositeManifestFileNameCopied := '~'+lastCompositeManifestFileName;

ECL:=
 '// Bair._CRON_Transfer_Composite_Manifest \n'
+'// scheduler job name -> Bair Composite Manifest Transfer Scheduler \n'
+'// queued job nane -> Bair Composite Manifest Transfer: \n'
+'\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'#stored(\'cluster\',\'bair-qa\');\n'
+'\n'
//+'wuname := \'Bair Composite Manifest Transfer: ' + pVersion + '\';\n'
+'wuname := \'Bair Composite Manifest Transfer\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'nothor(STD.File.copy(\''+ targetIP + lastCompositeManifestFileName + '\', \'thor40\' ,\''+ lastCompositeManifestFileNameCopied + '\', NAMED allowoverwrite:=TRUE, NAMED compress:=true));\n'  
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Composite Manifest Transfer Scheduler');
wk_ut.CreateWuid(ECL,THOR,Bair._ESP):
													WHEN('transfer_composite_manifest')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Composite Manifest Transfer Scheduler'
													,Bair.email_msg(workunit).NOC_MSG
													));