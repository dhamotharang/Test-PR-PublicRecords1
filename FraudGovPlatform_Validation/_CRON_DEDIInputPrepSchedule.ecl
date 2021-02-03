import FraudGovPlatform,ut,_Control;

EVERY_DAY_AT_10AM := '0 14 * * *';

IP:=IF (_control.ThisEnvironment.Name<> 'Prod_Thor',_control.IPAddress.bctlpedata12,_control.IPAddress.bctlpedata10);
RootDir:=IF (_control.ThisEnvironment.Name<> 'Prod_Thor',Constants.DEDILandingZonePathBase_dev,Constants.DEDILandingZonePathBase_prod);
ThorName:=IF(_control.ThisEnvironment.Name<> 'Prod_Thor',Constants.ThorName_Dev,Constants.ThorName_Prod);

version:=ut.GetDate : independent;

lECL1 :=
 'import FraudGovPlatform_Validation,Scrubs_FraudGov,ut;\n'
 +'#CONSTANT	(\'Platform\',\'FraudGov\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'wuname := \'FraudGov DEDI Input Prep\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Alert\n'
+' 	 ,\'FraudGov DEDI Input Prep\'\n'
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
+'		,sequential(FraudGovPlatform_Validation.SprayAndQualifyDEDI(\''+version+'\')\n'
+'		,Scrubs_FraudGov.MAC_Scrubs_Report(\''+version+'\',\'Scrubs_FraudGov\',\'DEDI\', Scrubs_FraudGov.DEDI_In_DEDI, FraudGovPlatform_Validation.Mailing_List().Alert))\n'
+'	):failure(email(\'FraudGov DEDI Input Prep Failed\'));\n'
;
#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov DEDI Input Prep Schedule');

d:=FileServices.RemoteDirectory(IP, RootDir+version+'/', '*.dat');
SkipJob := FraudGovPlatform.Files().Flags.SkipModules[1].SkipDEDI;
Run_ECL := if(SkipJob=false,lECL1, 'output(\'Spray DEDI Skipped\');\n' );
if(exists(d),_Control.fSubmitNewWorkunit(Run_ECL, ThorName ),'NO FILES TO SPRAY' )
			: WHEN(CRON(EVERY_DAY_AT_10AM))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
																			,'FraudGov DEDI Input Prep Schedule failure'
																			,Constants.NOC_MSG
																			));