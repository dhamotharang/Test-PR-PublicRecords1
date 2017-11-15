every_10_min := '*/10 0-23 * * *';
IP:=NAC.Constants.LandingZoneServer;
RootDir := NAC.Constants.LandingZonePathBaseEx;

lECL1 :=
 'wuname := \'NAC Contributory Input Prep\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   \'jose.bello@lexisnexis.com\'\n'
+' 	 ,\'NAC Input Prep\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'running\',\'wait\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'version:=ut.GetDate : independent;\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,sequential(NAC.BWR_prep_input(version,\''+IP+'\',\''+RootDir+'\'))\n'
+'	);\n'
;

NOC_MSG
	:=
	'** NOC **\n\n'

	+'http://prod_esp:8010/?legacy&inner=../WsWorkunits/WUInfo%3FWuid%3D'+workunit+'\n\n'

	+'Please investigate cause of failure of workunit '+workunit+' linked\n'
	+'above in Boca Prod.  Then please resubmit it to ensure NAC ingest process\n'
	+'is running.\n\n'

	+'If the error message includes mention of "SOAP RPC error" or similar, this has historically\n'
	+'meant one or more Prod Thor ESP services require a bounce.\n\n'

	+'If this failure has occurred during the maintenance window, it is possibly related to network\n'
	+'or other updates/changes. Please resubmit knowing it is possible that it may fail again if\n'
	+'maintenance is ongoing, it may fail again.  In that case, you may delay resubmission temporarily,\n'
	+'but please do not forget.\n\n'

	+'If issues persist/repeat outside the Sunday maintenance window,\n'
	+'please contact tony.kirk@lexisnexis.com and Jose.Bello@lexisnexis.com for assistance.\n'
	;

import _Control;
#WORKUNIT('name', 'NAC Input Prep Schedule');
ThorName:=if(_Control.ThisEnvironment.Name='Dataland','thor50_dev01','thor400_30_sla');

d:=FileServices.RemoteDirectory(IP, RootDir+'ready/', '*.dat');
if(exists(d),_Control.fSubmitNewWorkunit(lECL1, ThorName ),'NO FILES TO SPRAY' )
			: WHEN(CRON(every_10_min))
			,FAILURE(fileservices.sendemail(NAC.Mailing_List('').Dev1
																			,'NAC Input Prep SCHEDULE failure'
																			,NOC_MSG
																			));