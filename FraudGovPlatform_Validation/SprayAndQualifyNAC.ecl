IMPORT _Control,tools,STD,NAC,FraudGovPlatform;

EXPORT SprayAndQualifyNAC(
	string pversion,
	string ip = NAC.Constants.LandingZoneServer,
	string rootDir = NAC.Constants.LandingZonePathBase + '/msh/done/', 
	string destinationGroup = if(_Control.ThisEnvironment.Name='Dataland','thor400_dev','thor400_30'))
:= FUNCTION	
	dsFileList:=nothor(FileServices.RemoteDirectory(ip, rootDir, 'FL_MSH_' + pversion[1..8] + '*.dat')):independent;

	dsFileListSorted := sort(dsFileList,modified);
	FileFound:=exists(dsFileListSorted);

	UpSt := '';
	UpType := 'NAC';

	ReportFileFound:=if(FileFound
						,output('Found File To Spray',named('NAC_Found_File_To_Spray'))
						,output('No File To Spray',named('NAC_No_File_To_Spray'))
						);
						
						
	fname	:=dsFileListSorted[1].Name:independent;
	FileSprayed := FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname;
	NAC_Sprayed := FraudGovPlatform.Filenames().Sprayed.NAC;

	IsEmptyFile:=dsFileListSorted[1].size = 0;

	SprayIt:= sequential(
							output('Spraying: '+ ip + rootDir + fname + ' -> ' + FileSprayed) ,
							FileServices.SprayFixed(	
							sourceIP								:=	ip,
							sourcePath							:= rootDir + fname,
							recordSize							:=	sizeof(NAC.Layouts.MSH),
							destinationGroup					:=	destinationGroup,
							destinationLogicalName			:=	FileSprayed,
							compress								:=	true,
							allowoverwrite						:=true),
							fileservices.AddSuperfile(NAC_Sprayed,FileSprayed));	

	ReportEmptyFile := 
			SEQUENTIAL (	OUTPUT('File '+ip+rootDir + pversion +'/'+ fname+' empty',NAMED('NAC_File_empty')),
								Send_Email(st:=UpSt,fn:=FileSprayed,ut:=UpType).FileEmptyErrorAlert);
							
	outputwork
			:=
				if(fname=''
						,output('No new NAC file to process')
						,sequential(
											ReportFileFound
											,if(FileFound,
														if (IsEmptyFile,
																	 ReportEmptyFile
																	,SprayIt		 
														)
														,Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FileErrorAlert
											)
						)
				):failure(Send_Email(st:=UpSt,fn:=fname,ut:=UpType).FraudGov_Input_Prep_failure);

	RETURN outputwork;							
END;