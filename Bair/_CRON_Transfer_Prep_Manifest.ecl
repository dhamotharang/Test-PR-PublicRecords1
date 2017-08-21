/*
************************************************************************************
************************************************************************************
*************** SCHEDULE IN BOTH PROD and DR ***************************************
************************************************************************************
************************************************************************************
*/
// Bair._CRON_Transfer_Prep_Manifest
// scheduler job name -> Bair Prep Manifest Transfer Scheduler
// queued job nane -> Bair Prep Manifest Transfer:
// ON_DEMAND:
// Bair Prep Manifest Transfer
// WAITS for a notification of transfer_prep_manifest

import wk_ut,_Control,Bair,std;
THOR:='hthor';
listFromIP := Bair._Constant.listFromIP;

targetIP    									:= Bair._Constant.copyFromIP;
//lastPrepManifestFileName      := regexreplace('~',SORT(STD.File.LogicalFileList( '*last_prep_manifest*',NAMED foreigndali:=_Control.IPAddress.bair_prod_dali )[1],-name);[1].name,''):INDEPENDENT;
lastPrepManifestFileName      := SORT(STD.File.LogicalFileList( '*last_prep_manifest_w*',NAMED foreigndali:=listFromIP),-name)[1].name:INDEPENDENT;
lastPrepManifestFileNameCopied := '~'+lastPrepManifestFileName;
// prep_file_piece_cnt           := COUNT(STD.STR.SplitWords(lastPrepManifestFileName,'::'));
// prep_file                     := STD.STR.SplitWords(lastPrepManifestFileName,'::')[prep_file_piece_cnt];
// pVersion                      := STD.STR.SplitWords(prep_file,'_')[4]+'_'+STD.STR.SplitWords(prep_file,'_')[5];

ECL:=
 '// Bair._CRON_Transfer_Prep_Manifest \n'
+'// scheduler job name -> Bair Prep Manifest Transfer Scheduler \n'
+'// queued job nane -> Bair Prep Manifest Transfer: \n'
+'\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'#stored(\'cluster\',\'bair-qa\');\n'
+'\n'
+'wuname := \'Bair Prep Manifest Transfer\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'nothor(STD.File.copy(\''+ targetIP + lastPrepManifestFileName + '\', \'thor40\' ,\''+ lastPrepManifestFileNameCopied + '\', NAMED allowoverwrite:=TRUE, NAMED compress:=true));\n'  
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Prep Manifest Transfer Scheduler');
wk_ut.CreateWuid(ECL,THOR,Bair._ESP):
													WHEN('transfer_prep_manifest')
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Prep Manifest Transfer Scheduler'
													,Bair.email_msg(workunit).NOC_MSG
													));