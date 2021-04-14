import FraudGovPlatform,FraudGovPlatform_Validation,_Control,ut;

EVERY_DAY_AT_2PM := '0 18 * * *';
IP:=IF(_control.ThisEnvironment.Name<>'Prod_Thor',_control.IPAddress.bctlpedata12,_control.IPAddress.bctlpedata10);
RootDir:=IF(_control.ThisEnvironment.Name<>'Prod_Thor',Constants.MBSLandingZonePathBase_dev,Constants.MBSLandingZonePathBase_prod);
ThorName:=IF(_control.ThisEnvironment.Name<>'Prod_Thor',Constants.ThorName_Dev,Constants.ThorName_Prod);
version:=ut.GetDate : independent;
emailList:=FraudGovPlatform_Validation.Mailing_List().Alert;

lECL1 :=
 'import FraudGovPlatform_Validation,Scrubs_MBS,ut;\n'
+'wuname := \'FraudGov MBS Input Prep\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Alert\n'
+' 	 ,\'FraudGov MBS Input Prep\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'compiled\',\'submitted\',\'running\',\'wait\',\'compiling\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,sequential(FraudGovPlatform_Validation.SprayMBSFiles(\''+version+'\')\n'
+'		,Scrubs_MBS.BuildSCRUBSReport(\''+version+'\'))\n'
+'	);\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov MBS Input Prep Schedule');

SkipJob := FraudGovPlatform.Files().Flags.SkipModules[1].SkipMBS;
Run_ECL := if(SkipJob=false,lECL1, 'output(\'Spray MBS Skipped\');\n' );

d:=FileServices.RemoteDirectory(IP, RootDir+version+'/', '*.dat');
if(exists(d),_Control.fSubmitNewWorkunit(Run_ECL, ThorName ),'NO FILES TO SPRAY' )
			: WHEN(CRON(EVERY_DAY_AT_2PM))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
																			,'FraudGov MBS Input Prep Schedule failure'
																			,Constants.NOC_MSG
																			));
																			
																
