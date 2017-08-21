import Bair, ut,wk_ut;

raidsStatsBuiltSF := '~thor_data400::in::prepped::statsreport::built';
raidsStatsSentSF  := '~thor_data400::in::prepped::statsreport::sent';
raidsStatsBuilt   := DATASET(raidsStatsBuiltSF, Bair.raidsReport_Layout.raidsReportRec, THOR);
raidsStatsSent    := DATASET(raidsStatsSentSF, Bair.raidsReport_Layout.rFilesSent, THOR);
sentFileTable     := SET (raidsStatsSent,filename);
existFilesToSend := if(COUNT(raidsStatsBuilt(raidsStatsBuilt.filename IN sentFileTable)) < COUNT(raidsStatsBuilt),'true','false');

ECL:=
'#stored(\'cluster\',\'bair-qa\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'wuname := \'Bair Raids Report Email\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'valid_state := [\'blocked\',\'running\',\'wait\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit = false and \'' + existFilesToSend + '\' = \'true\', Bair.raidsReport.raidsReport_Email());\n'
;
sthor := if(existFilesToSend='true','thor40','hthor');
 
#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Raids Report Scheduler');
wk_ut.CreateWuid(ECL,sthor,Bair._Constant.cronIP) : when('Bair Raids Report Scheduler')
														,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com;debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;Sesha.Nookala@lexisnexis.com;'
																		,'Bair Raids Report Scheduler'
																		,'Raids Report Scheduler failure\n'
																		+'Raids Report Scheduler \n'
																		+'See '+workunit+'\n\n'
																		+FAILMESSAGE
																		));						
