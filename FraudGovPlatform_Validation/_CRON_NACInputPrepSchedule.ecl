﻿import _Control, NAC;

EVERY_DAY_AT_6AM := '0 6 * * *';
IP			:= NAC.Constants.LandingZoneServer;
RootDir	:= NAC.Constants.LandingZonePathBase + '/msh/done/';

ThorName := if(_Control.ThisEnvironment.Name='Dataland','thor400_dev_eclcc','thor400_44_eclcc');

lECL1 :=
 'import ut;\n'
+'wuname := \'FraudGov NAC Input Prep\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   \'oscar.barrientos@lexisnexis.com\'\n'
+' 	 ,\'FraudGov NAC Input Prep\'\n'
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
+'		,sequential(FraudGovPlatform_Validation.SprayAndQualifyNAC(version,\''+IP+'\',\''+RootDir+'\',\''+ThorName+'\'))\n'
+'	);\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov NAC Input Prep Schedule');

d:=FileServices.RemoteDirectory(IP, RootDir+'ready/', '*.dat');

if(exists(d),_Control.fSubmitNewWorkunit(lECL1, ThorName ),'NO FILES TO SPRAY' )
			: WHEN(CRON(EVERY_DAY_AT_6AM))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
																			,'FraudGov NAC Input Prep Schedule failure'
																			,FraudGovPlatform_Validation.Constants.NOC_MSG
																			));