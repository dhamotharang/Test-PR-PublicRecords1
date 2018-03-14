﻿import _Control;

every_day := '0 5 * * *';

ThorName := if(_Control.ThisEnvironment.Name='Dataland','thor50_dev02','thor400_30');
lECL1 :=
 'import ut;\n'
+'wuname := \'FraudGov InquiryLogs Input Prep\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   \'oscar.barrientos@lexisnexis.com\'\n'
+' 	 ,\'FraudGov InquiryLogs Input Prep\'\n'
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
+'		,sequential(FraudGovPlatform_Validation.SprayAndQualifyInquiryLogs(version))\n'
+'	);\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov InqLog Input Prep Schedule');

_Control.fSubmitNewWorkunit(lECL1, ThorName ) : WHEN(CRON(every_day));