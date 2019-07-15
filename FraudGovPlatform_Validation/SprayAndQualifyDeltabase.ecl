﻿import _Control,tools,STD,FraudGovPlatform,ut;

EXPORT SprayAndQualifyDeltabase(
	STRING pVersion,
	STRING ip	= IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		_control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10),
	STRING pDeltabaseRootDir = IF (_control.ThisEnvironment.Name <> 'Prod_Thor', FraudGovPlatform_Validation.Constants.DeltaLandingZonePathBase_dev, FraudGovPlatform_Validation.Constants.DeltaLandingZonePathBase_prod)
) := FUNCTION

DateSearch := pVersion[1..8];

dsFileList:=NOTHOR(FileServices.RemoteDirectory(ip, pDeltabaseRootDir + DateSearch, 'delta_identity.txt')):INDEPENDENT;
dsFileListSorted := SORT(dsFileList,modified);
fname_temp	:=dsFileListSorted[1].Name:independent;
fname	:='delta_'+DateSearch+'.txt';

UpSt:=stringlib.stringtouppercase(fname[1..2]);
UpType := 'Deltabase';

FileFound:=EXISTS(dsFileListSorted);
ReportFileFound:=IF(FileFound
					,OUTPUT('Found File To Spray',NAMED('Deltabase_Found_File_To_Spray'))
					,OUTPUT('No File To Spray',NAMED('Deltabase_No_File_To_Spray'))
					);

IsEmptyFile:=dsFileListSorted[1].size = 0;

FileSprayed 				:= FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname;
Deltabase_Passed		:= FraudGovPlatform.Filenames().Sprayed._DeltabasePassed;
Deltabase_Rejected	:= FraudGovPlatform.Filenames().Sprayed._DeltabaseRejected;

ClearFiles	:= SEQUENTIAL(
	STD.File.StartSuperFileTransaction(),
	STD.File.RemoveSuperFile( Deltabase_Passed, FileSprayed , true ),
	STD.File.RemoveSuperFile( Deltabase_Rejected, FileSprayed, true ),
	STD.File.FinishSuperFileTransaction()
);
	
	


SprayIt:=SEQUENTIAL(
						OUTPUT('Spraying: '+ ip + pDeltabaseRootDir + DateSearch + '/' + fname_temp + ' -> ' + FileSprayed) 
						,NOTHOR(ClearFiles)
						,NOTHOR(FileServices.SprayVariable(
							 IP //sourceIP 
							,pDeltabaseRootDir + DateSearch + '/' + fname_temp //sourcepath 
							,//maxrecordsize 
							,//srcCSVseparator 
							,'|\n,\n'//srcCSVterminator 
							,//srcCSVquote 
							,thorlib.group() //destinationgroup
							,FileSprayed //destinationlogicalname 
							, //timeout 
							,//espserverIPport 
							,//maxConnections 
							,TRUE //allowoverwrite 
							,TRUE //replicate 
							,TRUE //compress 
							))
						);	
								
// Validate delimiters
ValidateDelimiter := Mod_stats.ValidateDelimiter(fname,mod_sets.validDelimiterDeltabase, mod_sets.validTerminatorsDeltabase).ValidationResults;
InvalidDelimiterFound := EXISTS(ValidateDelimiter(err='F1'));

// Validate number of Columns
ValidateColumns := Mod_stats.ValidateNumberOfColumns(fname,mod_sets.validDelimiterDeltabase, mod_sets.validTerminatorsDeltabase).ValidationResults;
InvalidNumberOfColumnsFound :=EXISTS(ValidateColumns(err='F2'));

// ValidateInputFields																								
treshld_ := Mod_Sets.threshld;							
FileStats := Mod_Stats.ValidateInputFields(fname,mod_sets.validDelimiterDeltabase, mod_sets.validTerminatorsDeltabase).ValidationResults;
RecWithErrors := 	Mod_Stats.ValidateInputFields(fname,mod_sets.validDelimiterDeltabase, mod_sets.validTerminatorsDeltabase).RecordsRejected;

//ValidateInputWithMbs
ValidateInputMbs	:=	Mod_Stats.ValidateInputWithMBS(fname,mod_sets.validDelimiterDeltabase, mod_sets.validTerminatorsDeltabase).ValidationResults;

ExcessiveInvalidRecordsFound := EXISTS(FileStats(err[1]='E',RecWithErrors/RecordsTotal>treshld_));
InvalidMbsRecordsFound := EXISTS(ValidateInputMbs);
					
MoveToPass :=
		SEQUENTIAL(	OUTPUT('File '+fname+' content accepted',NAMED('Deltabase_File_content_accepted')),
							fileservices.AddSuperfile(Deltabase_Passed,FileSprayed),
							Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FileValidationReport(mod_sets.validDelimiterDeltabase, mod_sets.validTerminatorsDeltabase));
															
MoveToReject := 
		SEQUENTIAL(	OUTPUT('File '+fname+' contains fatal errors.  File will be rejected',NAMED('Deltabase_File_content_rejected')),
							fileservices.AddSuperfile(Deltabase_Rejected,FileSprayed));	
											 					
ReportExcessiveInvalidRecords := 	
		SEQUENTIAL ( MoveToReject,
							Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FileValidationReport(mod_sets.validDelimiterDeltabase, mod_sets.validTerminatorsDeltabase));

ReportInvalidMbsRecords := 	
		SEQUENTIAL(	MoveToPass,
							Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FileValidationMbsReport(mod_sets.validDelimiterDeltabase, mod_sets.validTerminatorsDeltabase));
															
ReportInvalidDelimiter := 
		SEQUENTIAL (	MoveToReject,
							Send_Email(st:=UpSt,fn:=fname,ut:=UpType).InvalidDelimiterError(mod_sets.validDelimiterDeltabase, mod_sets.validTerminatorsDeltabase));

ReportInvalidNumberOfColumns := 
		SEQUENTIAL (	MoveToReject,
							Send_Email(st:=UpSt,fn:=fname,ut:=UpType).InvalidNumberOfColumns(mod_sets.validDelimiterDeltabase, mod_sets.validTerminatorsDeltabase));

ReportEmptyFile := 
		SEQUENTIAL (	OUTPUT('File '+ip+pDeltabaseRootDir + DateSearch +'/'+ fname_temp+' empty',NAMED('Deltabase_File_empty')),
							Send_Email(st:=UpSt,fn:=FileSprayed,ut:=UpType).FileEmptyErrorAlert);
outputwork
			:=
				IF(fname=''
						,OUTPUT('No new contributory files to process')
						,SEQUENTIAL(	ReportFileFound,
											IF(FileFound,
														IF (	IsEmptyFile,
																ReportEmptyFile,
																SEQUENTIAL(	SprayIt,
																					MAP(	InvalidDelimiterFound 				=> ReportInvalidDelimiter,
																							InvalidNumberOfColumnsFound 	=> ReportInvalidNumberOfColumns,
																							ExcessiveInvalidRecordsFound 	=> ReportExcessiveInvalidRecords,
																							InvalidMbsRecordsFound				=> ReportInvalidMbsRecords,
																							MoveToPass	))),
														Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FileErrorAlert
											)
						)
				):FAILURE(Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FraudGov_Input_Prep_failure)
				 ;

	RETURN outputwork;

END;