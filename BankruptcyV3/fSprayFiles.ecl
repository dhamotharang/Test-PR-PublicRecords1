IMPORT	BankruptcyV3,	BankruptcyV2,	VersionControl,	tools,	_control,	STD;
EXPORT	fSprayFiles(
	STRING		pVersion			=	(STRING)STD.Date.Today()
	,STRING		pServerIP			=	BankruptcyV2.Constants(pVersion).serverIP
	,STRING		pDirectory		=	BankruptcyV2.Constants(pVersion).Directory
	,STRING		pFilename			=	'BKV3_Log_'+pVersion+'.txt'
	,STRING		pGroupName		=	_Dataset().groupname
	,BOOLEAN	pIsTesting		=	FALSE
	,BOOLEAN	pOverwrite		=	TRUE
	,STRING		pNameOutput		=	'BankruptcyV3 Spray Info'
) :=
FUNCTION

	FilesToSpray := DATASET([

		//	BankruptcyV3
		{
			pServerIP, 																//	SourceIP
			pDirectory, 															//	SourceDirectory
			pFilename,																//	directory_filter
			0, 																				//	record_size
			Filenames(pVersion).input.withdrawnstatus.new(pVersion),	//	Thor_filename_template
			[ {Filenames(pVersion).input.withdrawnstatus.sprayed}	],	//	dSuperfilenames
			pGroupName, 															//	fun_Groupname
			pVersion, 																//	FileDate
			'[0-9]{8}', 															//	date_regex
			'VARIABLE', 															//	file_type
			'', 																			//	sourceRowTagXML
			_Dataset().max_record_size,								//	sourceMaxRecordSize
			',', 																			//	sourceCsvSeparate
			'\\n,\\r\\n', 														//	sourceCsvTerminate
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
				_Dataset().name+' '+pVersion,	//	pEmailSubjectDataset
				pNameOutput, 						//	pOutputName
				TRUE, 									//	pShouldClearSuperfileFirst
				FALSE, 									//	pSplitEmails
				FALSE, 									//	pShouldSprayZeroByteFiles
				FALSE										//	pShouldSprayMultipleFilesAs1
			)
		)
	);

END;
