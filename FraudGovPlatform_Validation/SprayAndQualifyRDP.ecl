IMPORT _Control,tools,STD,FraudGovPlatform, ut;

EXPORT SprayAndQualifyRDP(
	STRING pVersion,
	STRING ip	= IF(_control.ThisEnvironment.Name <> 'Prod_Thor',		_control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10),
	STRING pRDPRootDir = IF (_control.ThisEnvironment.Name <> 'Prod_Thor', FraudGovPlatform_Validation.Constants.RDPLandingZonePathBase_dev, FraudGovPlatform_Validation.Constants.RDPLandingZonePathBase_prod)
) := FUNCTION

	DateSearch := pVersion[1..8];

	dsFileList:=NOTHOR(FileServices.RemoteDirectory(ip, pRDPRootDir + DateSearch, '*.dat')):INDEPENDENT;
	dsFileListSorted := SORT(dsFileList,modified);
	fname_temp	:=dsFileListSorted[1].Name:independent;
	fname	:= fname_temp;

	UpSt:='';
	UpType := 'RDP';

	FileFound:=EXISTS(dsFileListSorted);
	ReportFileFound:=IF(FileFound
						,OUTPUT('Found File To Spray',NAMED('RDP_Found_File_To_Spray'))
						,OUTPUT('No File To Spray',NAMED('RDP_No_File_To_Spray'))
						);

	IsEmptyFile:=dsFileListSorted[1].size = 0;

	FileSprayed 	:= FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname;
	RDP_Passed		:= FraudGovPlatform.Filenames().Sprayed._RDPPassed;
	RDP_Rejected	:= FraudGovPlatform.Filenames().Sprayed._RDPRejected;

	ClearFiles	:= SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.RemoveSuperFile( RDP_Passed, FileSprayed , true ),
		STD.File.RemoveSuperFile( RDP_Rejected, FileSprayed, true ),
		STD.File.FinishSuperFileTransaction()
	);
		

	SprayIt:=SEQUENTIAL(
							OUTPUT('Spraying: '+ ip + pRDPRootDir + DateSearch + '/' + fname_temp + ' -> ' + FileSprayed) 
							,NOTHOR(ClearFiles)
							,NOTHOR(FileServices.SprayVariable(
								 IP //sourceIP 
								,pRDPRootDir + DateSearch + '/' + fname_temp //sourcepath 
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
	

	Customer_Settings := FraudGovPlatform.MBS_Mappings(contribution_source = 'RDP' and contribution_gc_id != '');

	billingID_list := SET(Customer_Settings,contribution_billing_id);

		
	MoveToPass :=
		SEQUENTIAL(	OUTPUT('File '+fname+' content accepted',NAMED('Deltabase_File_content_accepted')),
							fileservices.AddSuperfile(RDP_Passed,FileSprayed));
															
	MoveToReject := 
		SEQUENTIAL(	OUTPUT('File '+fname+' contains fatal errors.  File will be rejected',NAMED('Deltabase_File_content_rejected')),
							fileservices.AddSuperfile(RDP_Rejected,FileSprayed));	

	ReportEmptyFile := 
		SEQUENTIAL (	OUTPUT('File '+ip+pRDPRootDir + DateSearch +'/'+ fname_temp+' empty',NAMED('Deltabase_File_empty')),
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