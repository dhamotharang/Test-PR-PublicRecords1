import _Control,tools,STD,FraudGovPlatform;

EXPORT SprayAndQualifyInqLog(
	STRING version,
	STRING ip	= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10),
	STRING rootDir = '/data/super_credit/fraudgov/in/deltabase/dev/', 
	STRING destinationGroup = IF(_Control.ThisEnvironment.Name='Dataland','thor400_dev01_2','thor400_44')
) := FUNCTION

dsFileList:=NOTHOR(FileServices.RemoteDirectory(ip, rootDir + version, '*.txt')):INDEPENDENT;
dsFileListSorted := SORT(dsFileList,modified);
fname	:=dsFileListSorted[1].Name:INDEPENDENT;
UpSt:=stringlib.stringtouppercase(fname[1..2]);
UpType := 'INQUIRYLOGS';

FileFound:=EXISTS(dsFileListSorted);
ReportFileFound:=IF(FileFound
					,OUTPUT('Found File To Spray',NAMED('Found_File_To_Spray'))
					,OUTPUT('No File To Spray',NAMED('No_File_To_Spray'))
					);

IsEmptyFile:=dsFileListSorted[1].size = 0;

FileSprayed 					:= FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname;
InquiryLogs_Passed		:= FraudGovPlatform.Filenames().Sprayed._InquiryLogsPassed;
InquiryLogs_Rejected	:= FraudGovPlatform.Filenames().Sprayed._InquiryLogsRejected;

SprayIt:=SEQUENTIAL(
						OUTPUT('Spraying: '+ ip + rootDir + version + '/' + fname + ' -> ' + FileSprayed) 
						,NOTHOR(FileServices.SprayVariable(
							 IP //sourceIP 
							,rootDir + version + '/' + fname //sourcepath 
							,//maxrecordsize 
							,//srcCSVseparator 
							,'|\n,\n'//srcCSVterminator 
							,//srcCSVquote 
							,destinationGroup //destinationgroup
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
ValidateDelimiter := Mod_stats.ValidateDelimiter(fname,mod_sets.validDelimiterInqLog, mod_sets.validTerminatorsInqLog).ValidationResults;
InvalidDelimiterFound := EXISTS(ValidateDelimiter(err='F1'));

// Validate number of Columns
ValidateColumns := Mod_stats.ValidateNumberOfColumns(fname,mod_sets.validDelimiterInqLog, mod_sets.validTerminatorsInqLog).ValidationResults;
InvalidNumberOfColumnsFound :=EXISTS(ValidateColumns(err='F2'));

// ValidateInputFields																								
treshld_ := Mod_Sets.threshld;							
FileStats := Mod_Stats.ValidateInputFields(fname,mod_sets.validDelimiterInqLog, mod_sets.validTerminatorsInqLog).ValidationResults;
RecWithErrors := 	Mod_Stats.ValidateInputFields(fname,mod_sets.validDelimiterInqLog, mod_sets.validTerminatorsInqLog).RecordsRejected;

//ValidateInputWithMbs
ValidateInputMbs	:=	Mod_Stats.ValidateInputWithMBS(fname,mod_sets.validDelimiterInqLog, mod_sets.validTerminatorsInqLog).ValidationResults;

ExcessiveInvalidRecordsFound := EXISTS(FileStats(err[1]='E',RecWithErrors/RecordsTotal>treshld_));
InvalidMbsRecordsFound := TRUE;
					
MoveToPass :=
		SEQUENTIAL(	OUTPUT('File '+fname+' content accepted',NAMED('File_content_accepted')),
							fileservices.AddSuperfile(InquiryLogs_Passed,FileSprayed),
							Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FileValidationReport(mod_sets.validDelimiterInqLog, mod_sets.validTerminatorsInqLog));
															
MoveToReject := 
		SEQUENTIAL(	OUTPUT('File '+fname+' contains fatal errors.  File will be rejected',NAMED('File_content_rejected')),
							fileservices.AddSuperfile(InquiryLogs_Rejected,FileSprayed));	
											 					
ReportExcessiveInvalidRecords := 	
		SEQUENTIAL ( MoveToReject,
							Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FileValidationReport(mod_sets.validDelimiterInqLog, mod_sets.validTerminatorsInqLog));

ReportInvalidMbsRecords := 	
		SEQUENTIAL(	MoveToPass,
							Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FileValidationMbsReport(mod_sets.validDelimiterInqLog, mod_sets.validTerminatorsInqLog));
															
ReportInvalidDelimiter := 
		SEQUENTIAL (	MoveToReject,
							Send_Email(st:=UpSt,fn:=fname,ut:=UpType).InvalidDelimiterError(mod_sets.validDelimiterInqLog, mod_sets.validTerminatorsInqLog));

ReportInvalidNumberOfColumns := 
		SEQUENTIAL (	MoveToReject,
							Send_Email(st:=UpSt,fn:=fname,ut:=UpType).InvalidNumberOfColumns(mod_sets.validDelimiterInqLog, mod_sets.validTerminatorsInqLog));

ReportEmptyFile := 
		SEQUENTIAL (	OUTPUT('File '+ip+rootDir + version +'/'+ fname+' empty',NAMED('File_empty')),
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