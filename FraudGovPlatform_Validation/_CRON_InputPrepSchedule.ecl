import FraudGovPlatform,_Control,STD,ut;

every_hour := '0 * * * *';

IP:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor',Constants.LandingZoneServer_dev,Constants.LandingZoneServer_prod);
RootDir:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor',Constants.LandingZonePathBase_dev,Constants.LandingZonePathBase_prod);
ThorName:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor',Constants.ThorName_Dev,Constants.ThorName_Prod);

LzFilePath :=FraudGovPlatform_Validation.Constants.LandingZoneFilePathRgx;

dsFileList:=nothor(FileServices.RemoteDirectory(ip, RootDir,'*.dat',true))(regexfind(LzFilePath,name,nocase)):global(few);
dsFileListSorted := sort(dsFileList,modified);

new_rec:=record
	dsFileListSorted;
	string20 customer_id;
	string20 file_type;
end;

Proj_dsFileListSorted := project(dsFileListSorted, transform(new_rec,
	self.customer_id := regexfind('([0-9])\\d+',left.name,0);
	self.file_type := regexfind('IDENTITY|KNOWNRISK|SAFELIST',left.name,0,nocase);
	self:=left));
	
J_dsFileListSorted	:= join(Proj_dsFileListSorted, FraudGovPlatform.Files().Flags.CustomerActiveSprays,
		ut.CleanSpacesandUpper(left.customer_id) = ut.CleanSpacesandUpper(right.customer_id) and
		ut.CleanSpacesandUpper(left.file_type) = ut.CleanSpacesandUpper(right.file_type)
	 );
	 
pfile:=STD.STR.SplitWords(J_dsFileListSorted[1].Name,'/');
FileDir:=RootDir + pfile[1] +'/';

lECL1 :=
 'import ut;\n'
+'wuname := \'FraudGov Input Prep\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'email(string msg):=fileservices.sendemail(\n'
+'   FraudGovPlatform_Validation.Mailing_List().Alert\n'
+' 	 ,\'FraudGov Input Prep\'\n'
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
+'		,sequential(FraudGovPlatform_Validation.SprayAndQualifyInput(version,\''+IP+'\',\''+FileDir+'\'))\n'
+'	);\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'FraudGov Input Prep Schedule');

SkipJob := FraudGovPlatform.Files().Flags.SkipModules[1].SkipContributions;
Run_ECL := if(SkipJob=false,lECL1, 'output(\'Spray Contributions Skipped\');\n' );

if(count(nothor(FileServices.RemoteDirectory(ip, RootDir,'*.dat',true))(regexfind(LzFilePath,name,nocase)))>0,
	_Control.fSubmitNewWorkunit(Run_ECL,ThorName),
	'NO FILES TO SPRAY') 
:WHEN(CRON(every_hour))
			,FAILURE(fileservices.sendemail(FraudGovPlatform_Validation.Mailing_List('','').Alert
			,'FraudGov Input Prep Schedule failure'
			,FraudGovPlatform_Validation.Constants.NOC_MSG
			));