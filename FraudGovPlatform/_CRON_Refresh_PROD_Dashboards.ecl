import _Control,STD,FraudGovPlatform_Validation;

every_hour := '0 0-23 * * *';

ThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		FraudGovPlatform_Validation.Constants.ThorName_Dev,	FraudGovPlatform_Validation.Constants.ThorName_Prod);

ECL :=
 'import ut;\n'
+'wuname := \'FraudGov Prod Dashboards Refresh\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Alert\n'
+' 	 ,\'FraudGov Prod Dashboards Refresh\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'compiled\',\'submitted\',\'running\',\'wait\',\'compiling\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,FraudGovPlatform.GenerateProdDashboards\n'
+'	);\n'
;
#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov Prod Dashboards Refresh Schedule');

_Control.fSubmitNewWorkunit(ECL,ThorName):WHEN(CRON(every_hour))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
			,'FraudGov Prod Dashboards Refresh Schedule failure'
			,FraudGovPlatform_Validation.Constants.NOC_MSG
			));