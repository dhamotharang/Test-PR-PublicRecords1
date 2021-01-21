IMPORT _Control,tools,STD,FraudGovPlatform, ut;

EXPORT SprayAndQualifyDEDI(
	STRING pVersion,
	STRING ip	= IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		_control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10),
	STRING pDEDIRootDir = IF (_control.ThisEnvironment.Name <> 'Prod_Thor', FraudGovPlatform_Validation.Constants.DEDILandingZonePathBase_dev, FraudGovPlatform_Validation.Constants.DEDILandingZonePathBase_prod)
) := FUNCTION

	DateSearch := pVersion[1..8];

	dsFileList:=NOTHOR(FileServices.RemoteDirectory(ip, pDEDIRootDir + DateSearch, '*'+DateSearch+'.csv')):INDEPENDENT;
	dsFileListSorted := SORT(dsFileList,modified);
	fname_temp	:=dsFileListSorted[1].Name:independent;
	fname	:= fname_temp;

	UpSt:='';
	UpType := 'DEDI';

	FileFound:=EXISTS(dsFileListSorted);
	ReportFileFound:=IF(FileFound
						,OUTPUT('Found File To Spray',NAMED('DEDI_Found_File_To_Spray'))
						,OUTPUT('No File To Spray',NAMED('DEDI_No_File_To_Spray'))
						);

	IsEmptyFile:=dsFileListSorted[1].size = 0;

	FileSprayed 	:= FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname;
	DEDI_Passed		:= FraudGovPlatform.Filenames().Sprayed._DisposableEmailDomainsPassed;
	DEDI_Rejected	:= FraudGovPlatform.Filenames().Sprayed._DisposableEmailDomainsRejected;

	ClearFiles	:= SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.RemoveSuperFile( DEDI_Passed, FileSprayed , true ),
		STD.File.RemoveSuperFile( DEDI_Rejected, FileSprayed, true ),
		STD.File.FinishSuperFileTransaction()
	);
		

	SprayIt:=SEQUENTIAL(
							OUTPUT('Spraying: '+ ip + pDEDIRootDir  + DateSearch + '/' + fname_temp + ' -> ' + FileSprayed) 
							,NOTHOR(ClearFiles)
							,NOTHOR(FileServices.SprayVariable(
								 IP //sourceIP 
								,pDEDIRootDir  + DateSearch + '/' + fname_temp //sourcepath 
								,//maxrecordsize 
								,'\\,'//srcCSVseparator 
								,'\\n,\\r\\n' //srcCSVterminator 
								,'\"'//srcCSVquote 
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
		
	MoveToPass :=
		SEQUENTIAL(	OUTPUT('File '+fname+' content accepted',NAMED('DEDI_File_content_accepted')),
							fileservices.AddSuperfile(DEDI_Passed,FileSprayed));
															
	MoveToReject := 
		SEQUENTIAL(	OUTPUT('File '+fname+' contains fatal errors.  File will be rejected',NAMED('DEDI_File_content_rejected')),
							fileservices.AddSuperfile(DEDI_Rejected,FileSprayed));	

	ReportEmptyFile := 
		SEQUENTIAL (	OUTPUT('File '+ip+pDEDIRootDir + DateSearch +'/'+ fname_temp+' empty',NAMED('DEDI_File_empty')),
							Send_Email(st:=UpSt,fn:=FileSprayed,ut:=UpType).FileEmptyErrorAlert);
	outputwork
			:=
				IF(fname=''
						,OUTPUT('No new contributory files to process')
						,SEQUENTIAL(	ReportFileFound,
											IF(FileFound,
														IF (	IsEmptyFile,
																SEQUENTIAL( ReportEmptyFile, MoveToReject),
																SEQUENTIAL(	SprayIt, MoveToPass	)),
														Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FileErrorAlert
											)
						)
				):FAILURE(Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FraudGov_Input_Prep_failure)
				 ;

	RETURN outputwork;
END;	