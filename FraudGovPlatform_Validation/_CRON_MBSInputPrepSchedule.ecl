import _Control;

every_10_min := '*/10 0-23 * * *';
IP:=Constants.LandingZoneServer;
RootDir := Constants.MBSLandingZonePathBase;
ThorName := if(_Control.ThisEnvironment.Name='Dataland','thor400_dev','thor400_30');

lECL1 :=
 'import ut;\n'
+'wuname := \'FraudGov MBS Input Prep\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   \'oscar.barrientos@lexisnexis.com\'\n'
+' 	 ,\'FraudGov Input Prep\'\n'
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
+'		,sequential(FraudShared.SprayMBSFiles(\''+IP+'\',\''+RootDir+'\',pVersion := version))\n'
+'	);\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov Input Prep Schedule');

d:=FileServices.RemoteDirectory(IP, RootDir+'ready/', '*.dat');
if(exists(d), output(lECL1) ,output('NO FILES TO SPRAY'))
			: WHEN(CRON(every_10_min))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
																			,'FraudGov Input Prep SCHEDULE failure'
																			,Constants.NOC_MSG
																			));
																			
																
