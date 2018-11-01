import _Control,STD;

every_hour_8to5pm := '0 12-21 * * *';

IP				:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		_control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10);
RootDir		:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		Constants.LandingZonePathBase_dev,	Constants.LandingZonePathBase_prod);
ThorName	:=		IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		Constants.ThorName_Dev,	Constants.ThorName_Prod);

LzFilePath :=FraudGovPlatform_Validation.Constants.LandingZoneFilePathRgx;

dsFileList:=nothor(FileServices.RemoteDirectory(ip, RootDir,'*.dat',true))(regexfind(LzFilePath,name,nocase)):global(few);
dsFileListSorted := sort(dsFileList,modified);
pfile:=STD.STR.SplitWords(dsFileListSorted[1].Name,'/');
FileDir:=RootDir + pfile[1] +'/';

ECL :=
 'import ut;\n'
+'wuname := \'FraudGov Input Prep\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   \'oscar.barrrientos@lexisnexis.com\'\n'
+' 	 ,\'FraudGov Input Prep\'\n'
+' 	 ,msg\n'
+' 	 +\'Build wuid \'+workunit\n'
+' 	 );\n\n'
+'valid_state := [\'blocked\',\'compiled\',\'submitted\',\'running\',\'wait\',\'compiling\'];\n';
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

if(count(nothor(FileServices.RemoteDirectory(ip, RootDir,'*.dat',true))(regexfind(LzFilePath,name,nocase)))>0,
	_Control.fSubmitNewWorkunit(ECL,ThorName),
	'NO FILES TO SPRAY') 
:WHEN(CRON(every_hour_8to5pm))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
			,'FraudGov Input Prep Schedule failure'
			,FraudGovPlatform_Validation.Constants.NOC_MSG
			));