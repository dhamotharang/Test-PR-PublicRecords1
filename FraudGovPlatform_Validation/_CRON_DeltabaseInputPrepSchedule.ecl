import _Control;

every_day := '0 5 * * *';
IP:=IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10);
RootDir := Constants.DeltaLandingZonePathBase;

ThorName := if(_Control.ThisEnvironment.Name='Dataland','thor400_dev','thor400_30');

lECL1 :=
 'import ut;\n'
+'#CONSTANT	(\'Platform\',\'FraudGov\');\n'
+'wuname := \'FraudGov Deltabase Input Prep\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   \'oscar.barrientos@lexisnexis.com\'\n'
+' 	 ,\'FraudGov Deltabase Input Prep\'\n'
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
+'		,sequential(FraudGovPlatform_Validation.SprayAndQualifyDeltabase(version,\''+IP+'\',\''+RootDir+'\',\''+ThorName+'\'))\n'
+'	);\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov Deltabase Input Prep Schedule');

d:=FileServices.RemoteDirectory(IP, RootDir+'ready/', '*.dat');
// if(exists(d),_Control.fSubmitNewWorkunit(lECL1, ThorName ),'NO FILES TO SPRAY' )
if(exists(d), output(lECL1) ,output('NO FILES TO SPRAY'))
			: WHEN(CRON(every_day))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
																			,'FraudGov Deltabase Input Prep SCHEDULE failure'
																			,Constants.NOC_MSG
																			));