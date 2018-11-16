import _Control;

EVERY_DAY_AT_5AM := '0 10 * * *';
IP				:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		_control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10);
RootDir		:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		Constants.MBSLandingZonePathBase_dev,	Constants.MBSLandingZonePathBase_prod);
ThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		Constants.ThorName_Dev,	Constants.ThorName_Prod);
lECL1 :=
 'import ut;\n'
+'#CONSTANT	(\'Platform\',\'FraudGov\');\n'
+'wuname := \'FraudGov MBS Input Prep\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   \'oscar.barrientos@lexisnexis.com\'\n'
+' 	 ,\'FraudGov MBS Input Prep\'\n'
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
+'		,sequential(FraudGovPlatform.Build_All(version).Spray_MBS)\n'
+'	);\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov MBS Input Prep Schedule');

d:=FileServices.RemoteDirectory(IP, RootDir+'ready/', '*.dat');
if(exists(d),_Control.fSubmitNewWorkunit(lECL1, ThorName ),'NO FILES TO SPRAY' )
			: WHEN(CRON(EVERY_DAY_AT_5AM))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
																			,'FraudGov MBS Input Prep Schedule failure'
																			,Constants.NOC_MSG
																			));
																			
																
