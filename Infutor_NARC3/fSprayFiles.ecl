

IMPORT	VersionControl, tools,	_control,STD;
EXPORT	fSprayFiles(
	STRING			pVersionDate		=	'',
	STRING			pServerIP				= Infutor_NARC3.Constants(pVersionDate).serverIP,	
	STRING			pDirectory			= Infutor_NARC3.Constants(pVersionDate).Directory,
	STRING			pFilename				=	'NARC3_*.txt',
	STRING			pGroupName			=	_Dataset().groupname,
	BOOLEAN		  pIsTesting			=	FALSE,
	BOOLEAN		  pOverwrite			=	TRUE,
	STRING			pNameOutput		=	'Infutor_narc3 Spray Info' 
) :=
FUNCTION

	FilesToSpray := DATASET([

		//	Infutor Narc3 files
		{
			pServerIP, 																//	SourceIP
			pDirectory, 															//	SourceDirectory
			pFilename,																//	directory_filter
			0, 																				//	record_size, for fix length only
			Filenames(pVersionDate).input.consumer.new(pVersionDate),	//	Thor_filename_template
			[ {Filenames(pVersionDate).input.consumer.sprayed}	],	//	dSuperfilenames
			pGroupName, 															//	fun_Groupname
			pVersionDate, 														//	FileDate
			'[0-9]{8}', 															//	date_regex
			'VARIABLE', 															//	file_type
			'', 																			//	sourceRowTagXML
			40000,																		//	sourceMaxRecordSize
			'\t', 																		//	sourceCsvSeparate  ..
			'\\n,\\r\\n', 														//	sourceCsvTerminate ..
			'', 																			//	sourceCsvQuote..
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
				'tarun.patel@lexisnexisrisk.com',				// pEmailNotificationList
				'Infutor_NARCv3 spray ' + pVersionDate,	//	pEmailSubjectDataset
				pNameOutput, 						//	pOutputName
				TRUE, 									//	pShouldClearSuperfileFirst
				FALSE, 									//	pSplitEmails
				FALSE, 									//	pShouldSprayZeroByteFiles
				FALSE										//	pShouldSprayMultipleFilesAs1
			)
		)
	);

END;




