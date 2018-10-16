import _Control,FraudGovPlatform_Validation;
EVERY_DAY_AT_5PM := '30 17 * * *';
IP:=IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10);

lECL1 :=
 'import ut;\n'
+'#CONSTANT	(\'Platform\',\'FraudGov\');\n'
+'#STORED(\'_Validate_Year_Range_Low\',1900);\n'
+'#STORED(\'_Validate_Year_Range_High\',2018);\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'version:=ut.GetDate : independent;\n'
+'wuname := \'FraudGov Build Base \' + version;\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   \'oscar.barrientos@lexisnexis.com\'\n'
+' 	 ,\'FraudGov Build Base Schedule\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'running\',\'wait\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,FraudGovPlatform.Build_All(version).Build_Base_Files\n'
+'	);\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov Build Base Schedule');

output(lECL1)
			: WHEN(CRON(EVERY_DAY_AT_5PM))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
																			,'FraudGov Build Base Schedule failure'
																			,FraudGovPlatform_Validation.Constants.NOC_MSG
																			));