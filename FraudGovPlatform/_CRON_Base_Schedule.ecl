import _Control,FraudGovPlatform_Validation;
EVERY_DAY_AT_1AM := '0 5 * * 1-5';

IP:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10);
ThorName:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor',FraudGovPlatform_Validation.Constants.ThorName_Dev,	FraudGovPlatform_Validation.Constants.ThorName_Prod);

lECL1 :=
 'import ut;\n'
+'version:=ut.GetDate : independent;\n'
+'#CONSTANT	(\'Platform\',\'FraudGov\');\n'
+'#CONSTANT(\'RunKelDemo\',false);\n' 
+'#STORED(\'_Validate_Year_Range_Low\',1900);\n'
+'#STORED(\'_Validate_Year_Range_High\',version[1..4]);\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#OPTION(\'defaultSkewError\', 1);\n'
+'wuname := \'FraudGov Data Build\';\n'
+'#WORKUNIT(\'protect\', true);\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Alert\n'
+' 	 ,\'FraudGov Data Build\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'compiled\',\'submitted\',\'running\',\'wait\',\'compiling\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,FraudGovPlatform.Build_All(version).All\n'
+'	);\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov Build Base Schedule');

SkipJob := FraudGovPlatform.Files().Flags.SkipModules[1].SkipBuild;
Run_ECL := if(SkipJob=false,lECL1, 'output(\'Build Skipped\');\n' );
_Control.fSubmitNewWorkunit(Run_ECL,ThorName)
			:WHEN(CRON(EVERY_DAY_AT_1AM))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').BocaOps
																			,'FraudGov Build Base Schedule failure'
																			,FraudGovPlatform_Validation.Constants.NOC_MSG
																			));