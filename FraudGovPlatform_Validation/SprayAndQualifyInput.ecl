import _Control,tools,STD,FraudGovPlatform;

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

fname := dsFileListSorted[1].Name:independent;

// https://confluence.rsi.lexisnexis.com/display/GTG/Naming+Conventions
fn := STD.Str.SplitWords( STD.Str.FindReplace(fname,'.dat',''), '_' );
Customer_Account_Number := fn[1];
Customer_State := fn[2];
Customer_Program := fn[4];
FileType := fn[5];

CustomerSettings := 
	FraudGovPlatform.Files().CustomerSettings( 
			Customer_Account_Number= Customer_Account_Number and
			Customer_State = Customer_State and
			Customer_Program = Customer_Program and
			FileType = FileType);

UpSt:=Customer_State;
UpType := map(
			 STD.Str.Contains( FileType, 'Identity', true )	=> 'IDENTITY'
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
		,UpType = 'KNOWNRISK' => fileservices.AddSuperfile(KnownFraud_Passed,FileSprayed)
		,UpType = 'SAFELIST' => fileservices.AddSuperfile(Safelist_Passed,FileSprayed)
	 )
	,Send_Email(st:=UpSt,fn:=fname,ut:=UpType,ce:=Customer_Email).FileValidationReport(mod_sets.validDelimiter, mod_sets.validTerminators));
															
MoveToReject:=sequential(
	 output('File '+fname+' contains fatal errors.  File will be rejected',named('Contributory_File_content_rejected'))
	,MoveSprayingToError
	,map(
		 UpType = 'IDENTITY' => fileservices.AddSuperfile(IdentityData_Rejected,FileSprayed) 
		,UpType = 'KNOWNRISK' => fileservices.AddSuperfile(KnownFraud_Rejected,FileSprayed)
		,UpType = 'SAFELIST' => fileservices.AddSuperfile(Safelist_Rejected,FileSprayed)
	 ));

ReportExcessiveInvalidRecords := 
	sequential (
		MoveToReject
		,Send_Email(st:=UpSt,fn:=fname,ut:=UpType,ce:=Customer_Email).FileValidationReport(mod_sets.validDelimiter, mod_sets.validTerminators));

ReportInvalidDelimiter := 
	sequential (
		 MoveToReject
		,Send_Email(st:=UpSt,fn:=fname,ut:=UpType,ce:=Customer_Email).InvalidDelimiterError(mod_sets.validDelimiter, mod_sets.validTerminators));

ReportInvalidNumberOfColumns := 
	sequential (				
		 MoveToReject
		,Send_Email(st:=UpSt,fn:=fname,ut:=UpType,ce:=Customer_Email).InvalidNumberOfColumns(mod_sets.validDelimiter, mod_sets.validTerminators));

ReportEmptyFile := 
	sequential (
		 output('File '+ip+ready+fname+' empty',named('Contributory_File_empty'))
		,MoveReadyToError
		,Send_Email(st:=UpSt,fn:=FileSprayed,ut:=UpType,ce:=Customer_Email).FileEmptyErrorAlert
		);
		
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
							MoveToPass)))
						,Send_Email(st:=UpSt,fn:=fname,ut:=UpType,ce:=Customer_Email).FileErrorAlert))
	):failure(Send_Email(st:=UpSt,fn:=fname,ut:=UpType,ce:=Customer_Email).FraudGov_Input_Prep_failure);

	return outputwork;

end;