import _Control,tools,STD,FraudGovPlatform;

EXPORT SprayAndQualifyInput(string version,string ip,string rootDir, string destinationGroup) := function

ready    := rootDir+'ready/';
done     := rootDir+'done/';
err      := rootDir+'error/';
spraying := rootDir+'spraying/';

dsFileList:=nothor(FileServices.RemoteDirectory(ip, ready, '*.dat')):independent;
dsFileListSorted := sort(dsFileList,modified);
fname:=dsFileListSorted[1].Name:independent;
UpSt:=stringlib.stringtouppercase(fname[1..2]);
UpType := map(
						 STD.Str.Contains( fname, 'IdentityData'	, true	) => 'IDENTITYDATA'
						,STD.Str.Contains( fname, 'KnownFraud'		, true	)	=> 'KNOWNFRAUD'
						,'UNKNOWN'
				 );

MoveReadyToSpraying :=nothor(FileServices.MoveExternalFile(IP,ready+fname,spraying+fname));
MoveReadyToError    :=nothor(FileServices.MoveExternalFile(IP,ready+fname,err+fname));
MoveSprayingToError :=nothor(FileServices.MoveExternalFile(IP,spraying+fname,err+fname));
MoveSprayingToDone  :=nothor(FileServices.MoveExternalFile(IP,spraying+fname,done+fname));

FileFound:=exists(dsFileListSorted);
ReportFileFound:=if(FileFound
					,output('Found File To Spray',named('Found_File_To_Spray'))
					,output('No File To Spray',named('No_File_To_Spray'))
					);

IsEmptyFile:=dsFileListSorted[1].size = 0;

FileSprayed 					:= FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname;
IdentityData_Passed 	:= FraudGovPlatform.Filenames().Sprayed._IdentityDataPassed;
KnownFraud_Passed			:= FraudGovPlatform.Filenames().Sprayed._KnownFraudPassed;
IdentityData_Rejected	:= FraudGovPlatform.Filenames().Sprayed._IdentityDataRejected;
KnownFraud_Rejected		:= FraudGovPlatform.Filenames().Sprayed._KnownFraudRejected;	

SprayIt:=sequential(
						output('Spraying: '+ ip + spraying + fname + ' -> ' + FileSprayed) 
						,nothor(FileServices.SprayVariable(
							 IP //sourceIP 
							,spraying + fname //sourcepath 
							,//maxrecordsize 
							,//srcCSVseparator 
							,'~<EOL>~,\n'//srcCSVterminator 
							,//srcCSVquote 
							,destinationGroup //destinationgroup
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
ValidateDelimiter :=Mod_stats.ValidateDelimiter(fname).ValidationResults;
InvalidDelimiterFound 		:=exists(ValidateDelimiter(err='F1'));

// Validate number of Columns
ValidateColumns 	:=Mod_stats.ValidateNumberOfColumns(fname).ValidationResults;
InvalidNumberOfColumnsFound :=exists(ValidateColumns(err='F2'));

// ValidateInputFields
																										
treshld_  		:=	Mod_Sets.threshld;							
FileStats			:=	Mod_Stats.ValidateInputFields(fname).ValidationResults;
RecWithErrors := 	Mod_Stats.ValidateInputFields(fname).RecordsRejected;

ExcessiveInvalidRecordsFound:=exists(FileStats(err[1]='E',RecWithErrors/RecordsTotal>treshld_));

					
MoveToPass:=sequential(
										 output('File '+fname+' content accepted',named('File_content_accepted'))
										,MoveSprayingToDone
										,map(
													 UpType = 'IDENTITYDATA' 	=> fileservices.AddSuperfile(IdentityData_Passed,FileSprayed)
													,UpType = 'KNOWNFRAUD'		=> fileservices.AddSuperfile(KnownFraud_Passed,FileSprayed)
										 )
										,Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FileValidationReport
						);
															
MoveToReject:=sequential(
											 output('File '+fname+' contains fatal errors.  File will be rejected',named('File_content_rejected'))
											,MoveSprayingToError
											,map(
														 UpType = 'IDENTITYDATA' 	=> fileservices.AddSuperfile(IdentityData_Rejected,FileSprayed) 
														,UpType = 'KNOWNFRAUD'		=> fileservices.AddSuperfile(KnownFraud_Rejected,FileSprayed))
											 );											
							
ReportExcessiveInvalidRecords := 	sequential (
										  MoveToReject
										 ,Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FileValidationReport
								);

ReportInvalidDelimiter := sequential (
				 MoveToReject
				,Send_Email(st:=UpSt,fn:=fname,ut:=UpType).InvalidDelimiterError
		);

ReportInvalidNumberOfColumns := sequential (				
				 MoveToReject
				,Send_Email(st:=UpSt,fn:=fname,ut:=UpType).InvalidNumberOfColumns
		);

ReportEmptyFile := sequential (
				 output('File '+ip+ready+fname+' empty',named('File_empty'))
				,MoveReadyToError
				,Send_Email(st:=UpSt,fn:=FileSprayed,ut:=UpType).FileEmptyErrorAlert
		);
outputwork
			:=
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
																								InvalidDelimiterFound 				=> ReportInvalidDelimiter,
																								InvalidNumberOfColumnsFound 	=> ReportInvalidNumberOfColumns,
																								ExcessiveInvalidRecordsFound 	=> ReportExcessiveInvalidRecords,
																								MoveToPass
																							)																																																
																	 )		 
														)
														,Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FileErrorAlert
											)
						)
				):failure(Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FraudGov_Input_Prep_failure)
				 ;

	return outputwork;

end;