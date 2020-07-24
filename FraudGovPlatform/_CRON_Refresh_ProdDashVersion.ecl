import _Control,STD,FraudGovPlatform_Validation;

Every_Nine_Minutes:='*/9 * * * *';

ThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		FraudGovPlatform_Validation.Constants.hthor_Dev,	FraudGovPlatform_Validation.Constants.hthor_Prod);

ECL :=
 'import ut,FraudGovPlatform;\n'
+'wuname := \'FraudGov Prod Dashboards Version Refresh\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Analytics\n'
+' 	 ,\'FraudGov Prod Dashboards Version Refresh\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'compiled\',\'submitted\',\'running\',\'wait\',\'compiling\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'RefreshDash := FraudGovPlatform.Files().Flags.RefreshProdDashVersion[1].refreshversion;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,Sequential(FraudGovPlatform.GenerateProdDashVersion\n'
+'		,if(~RefreshDash,email(\'RIN Production Dashboards Refresh Completed \')))\n'
+'	);\n'
;
#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov Prod Dashboards Version Refresh Schedule');

RunJob := FraudGovPlatform.Files().Flags.RefreshProdDashVersion[1].refreshversion;
Run_ECL := if(RunJob=true,ECL, 'output(\'Refresh Prod Dashboards Version Skipped\');\n' );

_Control.fSubmitNewWorkunit(Run_ECL,ThorName):WHEN(CRON(Every_Nine_Minutes))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
			,'FraudGov Prod Dashboards Version Refresh Schedule failure'
			,FraudGovPlatform_Validation.Constants.NOC_MSG
			));