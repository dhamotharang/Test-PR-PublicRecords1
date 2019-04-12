import _Control, NAC;

EVERY_DAY_AT_6AM := '0 11 * * *';
ThorName	:=		IF(_control.ThisEnvironment.Name		<> 'Prod_Thor',		Constants.ThorName_Dev,	Constants.ThorName_Prod);

lECL1 :=
 'import ut;\n'
+'wuname := \'FraudGov NAC Input Prep\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Alert\n'
+' 	 ,\'FraudGov NAC Input Prep\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'compiled\',\'submitted\',\'running\',\'wait\',\'compiling\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'version:=ut.GetDate : independent;\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,FraudGovPlatform.Build_All(version).Run_NAC\n'
+'	);\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov NAC Input Prep Schedule');

_Control.fSubmitNewWorkunit(lECL1, ThorName ) : WHEN(CRON(EVERY_DAY_AT_6AM));