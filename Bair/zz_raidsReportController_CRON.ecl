import Bair, ut,wk_ut,std;

ECL:=
'#stored(\'cluster\',\'bair-qa\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#option(\'hdCompressorType\', \'NONE\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'

+'wumonitor := \'Bair Raids Report Monitor\';\n'
+'#WORKUNIT(\'name\', wumonitor);\n'
+'wuname := \'Bair Raids Report Email\';\n'
+'valid_state := [\'blocked\',\'running\',\'wait\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'raidsStatsBuiltSF := \'~thor_data400::in::prepped::statsreport::built\';\n'
+'existstats := STD.File.GetSuperFileSubCount(raidsStatsBuiltSF)>0;\n'
+'if(active_workunit = false and existstats, NOTIFY(\'Bair Raids Report Scheduler\',\'*\'));\n'
;
callMonitor := wk_ut.CreateWuid(ECL,'hthor',Bair._Constant.cronIP);

wumonitor := 'Bair Raids Report Monitor';
dmonitor  := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wumonitor))(wuid <> thorlib.wuid()), -wuid);
dwu       := dmonitor[1].wuid;
active_monitor :=  dmonitor[1].state !='completed';
dsubmonitor		 := sort(nothor(WorkunitServices.WorkunitList('', NAMED username:='fincarnacao', NAMED state:='submitted'))(wuid <> thorlib.wuid()), -wuid);
pendingSubmitted := Count(dsubmonitor) > 2;

dontCallMonitor:= 'Monitor in Progress';

CRONController := if (active_monitor=TRUE or pendingSubmitted=TRUE, dontCallMonitor, callMonitor);
CRONController;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Raids Report Controller');
CRONController:  when(cron('0-59/2 * *	*	*'))
														,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com;debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;Sesha.Nookala@lexisnexis.com;'
																		,'Bair Raids Report Controller'
																		,'Raids Report Controller failure\n'
																		+'Raids Report Controller \n'
																		+'See '+workunit+'\n\n'
																		+FAILMESSAGE
																		));	