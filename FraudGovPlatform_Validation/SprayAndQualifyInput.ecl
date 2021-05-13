import _Control,tools,STD,FraudGovPlatform,FraudGovPlatform_Validation,ut;

EXPORT SprayAndQualifyInput(
	STRING version,
	STRING ip = IF(_control.ThisEnvironment.Name <> 'Prod_Thor', Constants.LandingZoneServer_dev, Constants.LandingZoneServer_prod),
	STRING rootDir = IF(_control.ThisEnvironment.Name <> 'Prod_Thor', Constants.LandingZonePathBase_dev,	Constants.LandingZonePathBase_prod)
) := FUNCTION

ready    := rootDir+'ready/';
done     := rootDir+'done/';
err      := rootDir+'error/';
spraying := rootDir+'spraying/';

dsFileList:=nothor(FileServices.RemoteDirectory(ip, ready, '*.dat')):independent;
dsFileListSorted := sort(dsFileList,modified);

new_rec:=record
	dsFileListSorted;
	string20 customer_id;
	string20 file_type;
end;
Proj_dsFileListSorted := project(dsFileListSorted, transform(new_rec,
	self.customer_id := regexfind('([0-9])\\d+',left.name,0);
	SplitWords := StringLib.SplitWords( StringLib.StringFindReplace(left.name, '.dat',''), '_', true );
	self.file_type := SplitWords[5]; 
	self:=left));
	
J_dsFileListSorted	:= join(Proj_dsFileListSorted, FraudGovPlatform.Files().Flags.CustomerActiveSprays,
		ut.CleanSpacesandUpper(left.customer_id) = ut.CleanSpacesandUpper(right.customer_id) and
		ut.CleanSpacesandUpper(left.file_type) = ut.CleanSpacesandUpper(right.file_type)
	 );


fname := J_dsFileListSorted[1].Name:independent;

// https://confluence.rsi.lexisnexis.com/display/GTG/Naming+Conventions
fn := STD.Str.SplitWords( STD.Str.FindReplace(fname,'.dat',''), '_' );
Customer_Id := fn[1];
Customer_State := fn[2];
Customer_Program := fn[4];
FileType := fn[5];

CustomerSettings := 
	FraudGovPlatform.Files().CustomerSettings( 
			Customer_Id= Customer_Id and
			Customer_State = Customer_State and
			Customer_Program = Customer_Program and
			FileType = FileType);

UpSt:=Customer_State;
UpType := map(
			 STD.Str.Contains( FileType, 'Identity', true )	=> 'IDENTITY'
			,STD.Str.Contains( FileType, 'IdentityBatch', true )	=> 'IDENTITY'
			,STD.Str.Contains( FileType, 'KnownRisk', true )	=> 'KNOWNRISK'
			,STD.Str.Contains( FileType, 'SafeList', true )	=> 'SAFELIST'
			,'UNKNOWN');

Customer_Email := CustomerSettings[1].Customer_Email;

MoveReadyToSpraying :=nothor(FileServices.MoveExternalFile(IP,ready+fname,spraying+fname));
MoveReadyToError    :=nothor(FileServices.MoveExternalFile(IP,ready+fname,err+fname));
MoveSprayingToError :=nothor(FileServices.MoveExternalFile(IP,spraying+fname,err+fname));
MoveSprayingToDone  :=nothor(FileServices.MoveExternalFile(IP,spraying+fname,done+fname));

FileFound:=exists(dsFileListSorted);
ReportFileFound:=if(FileFound
				,output('Found File To Spray',named('Contributory_Found_File_To_Spray'))
				,output('No File To Spray',named('Contributory_No_File_To_Spray')));

IsEmptyFile:=dsFileListSorted[1].size = 0;

FileSprayed := FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname;
IdentityData_Passed := FraudGovPlatform.Filenames().Sprayed._IdentityDataPassed;
KnownFraud_Passed := FraudGovPlatform.Filenames().Sprayed._KnownFraudPassed;
Safelist_Passed := FraudGovPlatform.Filenames().Sprayed._SafelistPassed;
IdentityData_Rejected := FraudGovPlatform.Filenames().Sprayed._IdentityDataRejected;
KnownFraud_Rejected := FraudGovPlatform.Filenames().Sprayed._KnownFraudRejected;	
Safelist_Rejected := FraudGovPlatform.Filenames().Sprayed._SafelistRejected;

SprayIt:=sequential(
			output('Spraying: '+ ip + spraying + fname + ' -> ' + FileSprayed) 
			,nothor(FileServices.SprayVariable(
				 IP //sourceIP 
				,spraying + fname //sourcepath 
				,5000000000//maxrecordsize 
				,//srcCSVseparator 
				,'\n'//srcCSVterminator 
				,//srcCSVquote 
				,thorlib.group() //destinationgroup
				,FileSprayed //destinationlogicalname 
				, //timeout 
				,//espserverIPport 
				,//maxConnections 
				,true //allowoverwrite 
				,true //replicate 
				,true //compress 
				))
			);	
								
// Validate delimiters
ValidateDelimiter :=Mod_stats.ValidateDelimiter(fname,mod_sets.validDelimiter, mod_sets.validTerminators).ValidationResults;
InvalidDelimiterFound :=exists(ValidateDelimiter(err='F1'));

// Validate number of Columns
ValidateColumns :=Mod_stats.ValidateNumberOfColumns(fname,mod_sets.validDelimiter, mod_sets.validTerminators).ValidationResults;
InvalidNumberOfColumnsFound :=exists(ValidateColumns(err='F2'));

// ValidateInputFields
treshld_ := Mod_Sets.threshld;							
FileStats := Mod_Stats.ValidateInputFields(fname,mod_sets.validDelimiter, mod_sets.validTerminators).ValidationResults;
RecWithErrors := Mod_Stats.ValidateInputFields(fname,mod_sets.validDelimiter, mod_sets.validTerminators).RecordsRejected;

ExcessiveInvalidRecordsFound:= exists(FileStats(err[1]='E',RecWithErrors/RecordsTotal>treshld_));
					
MoveToPass:=sequential(
	 output('File '+fname+' content accepted',named('Contributory_File_content_accepted'))
	,MoveSprayingToDone
	,map(
		 UpType = 'IDENTITY' => fileservices.AddSuperfile(IdentityData_Passed,FileSprayed)
		,UpType = 'IDENTITYBATCH' => fileservices.AddSuperfile(IdentityData_Passed,FileSprayed)
		,UpType = 'KNOWNRISK' => fileservices.AddSuperfile(KnownFraud_Passed,FileSprayed)
		,UpType = 'SAFELIST' => fileservices.AddSuperfile(Safelist_Passed,FileSprayed)
	 )
	,Send_Email(st:=UpSt,fn:=fname,ut:=UpType,ce:=Customer_Email).FileValidationReport(mod_sets.validDelimiter, mod_sets.validTerminators));
															
MoveToReject:=sequential(
	 output('File '+fname+' contains fatal errors.  File will be rejected',named('Contributory_File_content_rejected'))
	,MoveSprayingToError
	,map(
		 UpType = 'IDENTITY' => fileservices.AddSuperfile(IdentityData_Rejected,FileSprayed) 
		,UpType = 'IDENTITYBATCH' => fileservices.AddSuperfile(IdentityData_Rejected,FileSprayed) 
		,UpType = 'KNOWNRISK' => fileservices.AddSuperfile(KnownFraud_Rejected,FileSprayed)
		,UpType = 'SAFELIST' => fileservices.AddSuperfile(Safelist_Rejected,FileSprayed)
	 ));

ReportExcessiveInvalidRecords := 
	sequential (
		MoveToReject
		,Send_Email(st:=UpSt,fn:=fname,ut:=UpType,ce:=Customer_Email,pIsError:=true).FileValidationReport(mod_sets.validDelimiter, mod_sets.validTerminators));

ReportInvalidDelimiter := 
	sequential (
		 MoveToReject
		,Send_Email(st:=UpSt,fn:=fname,ut:=UpType,ce:=Customer_Email,pIsError:=true).InvalidDelimiterError(mod_sets.validDelimiter, mod_sets.validTerminators));

ReportInvalidNumberOfColumns := 
	sequential (				
		 MoveToReject
		,Send_Email(st:=UpSt,fn:=fname,ut:=UpType,ce:=Customer_Email,pIsError:=true).InvalidNumberOfColumns(mod_sets.validDelimiter, mod_sets.validTerminators));

ReportEmptyFile := 
	sequential (
		 output('File '+ip+ready+fname+' empty',named('Contributory_File_empty'))
		,MoveReadyToError
		,Send_Email(st:=UpSt,fn:=FileSprayed,ut:=UpType,ce:=Customer_Email,pIsError:=true).FileEmptyErrorAlert
		);

ThorName:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor',Constants.ThorName_Dev,Constants.ThorName_Prod);
RootDir2:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor',Constants.LandingZonePathBase_dev,Constants.LandingZonePathBase_prod);

LzFilePath :=FraudGovPlatform_Validation.Constants.LandingZoneFilePathRgx;

dsFileList2:= nothor(	FileServices.RemoteDirectory(ip, RootDir2,'*.dat',true))(regexfind(	LzFilePath,	name,nocase)):global(few);
dsFileListSorted2 := sort(dsFileList2,modified);

new_rec2:=record
	dsFileListSorted2;
	string20 customer_id;
	string20 file_type;
end;

Proj_dsFileListSorted2 := project(dsFileListSorted2, transform(new_rec2,
	self.customer_id := regexfind('([0-9])\\d+',left.name,0);
	self.file_type := regexfind('IDENTITY|IDENTITY|KNOWNRISK|SAFELIST',left.name,0,nocase);
	self:=left));
	
J_dsFileListSorted2	:= join(Proj_dsFileListSorted2, FraudGovPlatform.Files().Flags.CustomerActiveSprays,
		left.customer_id = right.customer_id and
		left.file_type = right.file_type
	 );


pfile2:=STD.STR.SplitWords(J_dsFileListSorted2[1].Name,'/');
FileDir2:=RootDir2 + pfile2[1] +'/';

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
+'		,sequential(FraudGovPlatform_Validation.SprayAndQualifyInput(version,\''+IP+'\',\''+FileDir2+'\'))\n'
+'	);\n'
;

SkipJob := FraudGovPlatform.Files().Flags.SkipModules[1].SkipContributions;
Run_ECL := if(SkipJob=false,lECL1, 'output(\'Spray Contributions Skipped\');\n' );

		
outputwork :=
	if(fname=''
		,output('No new contributory files to process')
		,sequential(
			 ReportFileFound
			,if(FileFound,
					if (IsEmptyFile,
							 ReportEmptyFile
							,sequential(
										 MoveReadyToSpraying
										,SprayIt
										,MAP(	
											InvalidDelimiterFound => ReportInvalidDelimiter,
											InvalidNumberOfColumnsFound => ReportInvalidNumberOfColumns,
											ExcessiveInvalidRecordsFound => ReportExcessiveInvalidRecords,
											MoveToPass )
									 ,output('Next File: ' + ip + ' ' + FileDir2)	
									 ,count(nothor(FileServices.RemoteDirectory(ip, FileDir2,'*.dat',true))(regexfind(LzFilePath,name,nocase)))>0,_Control.fSubmitNewWorkunit(Run_ECL,ThorName)
							)
					)
					,Send_Email(st:=UpSt,fn:=fname,ut:=UpType,ce:=Customer_Email).FileErrorAlert
			)
		)
	):failure(Send_Email(st:=UpSt,fn:=fname,ut:=UpType,ce:=Customer_Email).FraudGov_Input_Prep_failure);

	return outputwork;

end;