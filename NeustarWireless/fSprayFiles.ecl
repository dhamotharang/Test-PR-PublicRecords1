IMPORT	VersionControl,	tools,	_control;
EXPORT	fSprayFiles(
	STRING		pVersionDate,
	STRING		pServerIP				= Constants().serverIP,
	STRING		pDirectory			= Constants().Directory,
	STRING		pFilename				=	Constants(pVersionDate).FileToSpray,
	STRING		pGroupName			=	Constants().ThorGroup,
	BOOLEAN		pIsTesting			=	FALSE,
	BOOLEAN		pOverwrite			=	TRUE,
	STRING		pNameOutput			=	_Dataset().Name + ' Spray Info',
	UNSIGNED8 pMaxRecordSize  = tools.Constants(_Dataset().Name).max_record_size
) :=
FUNCTION

	FilesToSpray := DATASET([
		{
			pServerIP, 																//	SourceIP
			pDirectory, 															//	SourceDirectory
			pFilename,																//	directory_filter
			0, 																				//	record_size
			NeustarWireless.Files.Names.Raw_In + '::@version@',		//	Thor_filename_template
			[{NeustarWireless.Files.Names.Raw_In}],		//	dSuperfilenames
			pGroupName, 															//	fun_Groupname
			pVersionDate, 														//	FileDate
			'[0-9]{8}', 															//	date_regex
			'VARIABLE', 															//	file_type
			'', 																			//	sourceRowTagXML
			pMaxRecordSize,														//	sourceMaxRecordSize
			'|', 																			//	sourceCsvSeparate
			'\\n', 																		//	sourceCsvTerminate
			'', 																			//	sourceCsvQuote
			TRUE, 																		//	compress
			pOverwrite, 															//	shouldoverwrite
			FALSE, 																		//	ShouldSprayZeroByteFiles
			FALSE  																		//	ShouldSprayMultipleFilesAs1
		}
		], VersionControl.Layout_Sprays.Info);
		
	RETURN IF(	pDirectory != '',
		SEQUENTIAL
		(
			VersionControl.fSprayInputFiles
			( 
				FilesToSpray,						//	pSprayInformation
				, 											//	pSprayInfoSuperfile
				,												//	pSprayInfoLogicalfile
				pOverwrite, 						//	pOverwrite
				,												//	pReplicate
				TRUE,										//	pAddCounter
				pIsTesting,							//	pIsTesting
				,												//	pEmailNotificationList
				_Dataset().Name,				//  pEmailSubjectDataset
				pNameOutput, 						//	pOutputName
				TRUE, 									//	pShouldClearSuperfileFirst
				FALSE, 									//	pSplitEmails
				FALSE, 									//	pShouldSprayZeroByteFiles
				FALSE										//	pShouldSprayMultipleFilesAs1
			)
		)
	);

END;
