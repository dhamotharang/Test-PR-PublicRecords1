import ut,_Control;

EVERY_DAY_AT_3AM := '0 8 * * *';
IP				:=		IF (_control.ThisEnvironment.Name	<> 'Prod_Thor',		_control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10);
RootDir 	:=		IF (_control.ThisEnvironment.Name	<> 'Prod_Thor',		Constants.DeltaLandingZonePathBase_dev,Constants.DeltaLandingZonePathBase_prod);
ThorName	:=		IF(_control.ThisEnvironment.Name	<> 'Prod_Thor',		Constants.ThorName_Dev,	Constants.ThorName_Prod);

version:=ut.GetDate : independent;

lECL1 :=
 'import ut;\n'
+'#CONSTANT	(\'Platform\',\'FraudGov\');\n'
+'wuname := \'FraudGov Deltabase Input Prep\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Alert\n'
+' 	 ,\'FraudGov Deltabase Input Prep\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'compiled\',\'submitted\',\'running\',\'wait\',\'compiling\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,FraudGovPlatform.Build_All(\''+version+'\').Run_Deltabase\n'
+'	);\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov Deltabase Input Prep Schedule');

d:=FileServices.RemoteDirectory(IP, RootDir+version+'/', '*.dat');
if(exists(d),_Control.fSubmitNewWorkunit(lECL1, ThorName ),'NO FILES TO SPRAY' )
			: WHEN(CRON(EVERY_DAY_AT_3AM))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
																			,'FraudGov Deltabase Input Prep Schedule failure'
																			,Constants.NOC_MSG
																			));