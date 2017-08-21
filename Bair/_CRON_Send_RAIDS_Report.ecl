// Bair._CRON_Send_RAIDS_Report
// scheduler job nane -> Bair Raids Report Scheduler
// queued job nane -> Bair Raids Report Email
// EVERY_TWO_MINUTES or ON_NOTIFY: Bair Raids Report Scheduler
	// Build RAIDS Report and email it
// Expected execution time -> 30 seconds

import ut,wk_ut,_Control;
THOR:='thor40';
ON_NOTIFY:='Bair Raids Report Scheduler';
EVERY_TWO_MINUTES:='0-59/2 * *	*	*';

ECL:=
 '//Bair._CRON_Send_RAIDS_Report\n'
+'//scheduler job nane -> Bair Raids Report Scheduler\n'
+'//queued job nane -> Bair Raids Report Email\n'
+'//EVERY_TWO_MINUTES or ON_NOTIFY: Bair Raids Report Scheduler\n'
+'// Build RAIDS Report and email it\n'
+'// Expected execution time -> 30 seconds\n'
+'\n'
+'#stored(\'cluster\',\'bair-qa\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'\n'
+'raidsStatsBuiltSF := \'~thor_data400::in::prepped::statsreport::built\';\n'
+'raidsStatsSentSF  := \'~thor_data400::in::prepped::statsreport::sent\';\n'
+'raidsStatsBuilt := DATASET(raidsStatsBuiltSF, Bair.raidsReport_Layout.raidsReportRec, THOR);\n'
+'raidsStatsSent  := DATASET(raidsStatsSentSF, Bair.raidsReport_Layout.rFilesSent, THOR);\n'
+'sentFileTable := SET (raidsStatsSent,filename);\n'
+'\n'
+'BOOLEAN existFilesToSend := COUNT(raidsStatsBuilt(raidsStatsBuilt.filename IN sentFileTable)) < COUNT(raidsStatsBuilt);\n'
+'\n'
+'wuname := \'Bair Raids Report Email\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'\n'
+'valid_state := [\'blocked\',\'running\',\'wait\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit = false and existFilesToSend = true, Bair.raidsReport.raidsReport_Email());\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Raids Report Scheduler');
wk_ut.CreateWuid(ECL,THOR,Bair._ESP):
													WHEN(ON_NOTIFY)
													// WHEN(cron(EVERY_TWO_MINUTES))
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Raids Report Scheduler Failure'
													,Bair.email_msg(workunit).NOC_MSG
													));