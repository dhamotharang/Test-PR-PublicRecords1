import _Control,STD;

every_10_min := '*/10 8-17 * * *';
IP:= FraudGovPlatform_Validation.Constants.LandingZoneServer;
RootDir := FraudGovPlatform_Validation.Constants.LandingZonePathBase;
LzFilePath :=FraudGovPlatform_Validation.Constants.LandingZoneFilePathRgx;
ThorName := if(_Control.ThisEnvironment.Name='Dataland','thor400_dev','thor400_30');

dsFileList:=nothor(FileServices.RemoteDirectory(ip, RootDir,'*.dat',true))(regexfind(LzFilePath,name,nocase)):global(few);
dsFileListSorted := sort(dsFileList,modified);
pfile:=STD.STR.SplitWords(dsFileListSorted[1].Name,'/');
FileDir:=RootDir + pfile[1] +'/';

ECL :=
 'import ut;\n'
+'wuname := \'FraudGov Contributory Input Prep\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   \'sesha.nookala@lexisnexis.com\'\n'
+' 	 ,\'FraudGov Input Prep\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'submitted\', \'compiling\',\'blocked\',\'running\',\'wait\'];\n'
+'d := sort(nothor(WorkunitServices.WorkunitList(\'\',,,wuname,\'\'))(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'version:=ut.GetDate : independent;\n'
+'if(active_workunit\n'
+'		,email(\'**** WARNING - Workunit \'+d_wu+\' in Wait, Queued, or Running *******\')\n'
+'		,sequential(FraudGovPlatform_Validation.SprayAndQualifyInput(version,\''+IP+'\',\''+FileDir+'\'))\n'
+'	);\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov Input Prep Schedule');

if(count(nothor(FileServices.RemoteDirectory(ip, RootDir,'*.dat',true))(regexfind(LzFilePath,name,nocase)))>0,_Control.fSubmitNewWorkunit(ECL,ThorName),'NO FILES TO SPRAY') :WHEN(CRON(every_10_min))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
																			,'FraudGov Input Prep SCHEDULE failure'
																			,FraudGovPlatform_Validation.Constants.NOC_MSG
																			));