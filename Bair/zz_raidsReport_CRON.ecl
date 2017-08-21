import Bair, ut,wk_ut;

ECL:=
'#stored(\'cluster\',\'bair-qa\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'

+'raidsStatsBuiltSF := \'~thor_data400::in::prepped::statsreport::built\';\n'
+'raidsStatsSentSF  := \'~thor_data400::in::prepped::statsreport::sent\';\n'
+'raidsStatsBuilt := DATASET(raidsStatsBuiltSF, Bair.raidsReport_Layout.raidsReportRec, THOR);\n'
+'raidsStatsSent  := DATASET(raidsStatsSentSF, Bair.raidsReport_Layout.rFilesSent, THOR);\n'
+'sentFileTable := SET (raidsStatsSent,filename);\n'

+'BOOLEAN existFilesToSend := COUNT(raidsStatsBuilt(raidsStatsBuilt.filename IN sentFileTable)) < COUNT(raidsStatsBuilt);\n'

+'wuname := \'Bair Raids Report Email\';\n'
+'#WORKUNIT(\'name\', wuname);\n'

+'valid_state := [\'blocked\',\'running\',\'wait\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit = false and existFilesToSend = true, Bair.raidsReport.raidsReport_Email());\n'
;
 
#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Raids Report Scheduler');
wk_ut.CreateWuid(ECL,'thor40','10.240.32.16') : when(cron('0-59/2 * *	*	*'))
														,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com'
																		,'Bair Raids Report Scheduler'
																		,'Raids Report email failure\n'
																		+'Raids Report email \n'
																		+'See '+workunit+'\n\n'
																		+FAILMESSAGE
																		));						
