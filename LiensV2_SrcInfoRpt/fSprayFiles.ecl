IMPORT	LiensV2_SrcInfoRpt,	VersionControl,	tools,	_control,	STD;
EXPORT	fSprayFiles(
	STRING		pVersion			=	(STRING)STD.Date.Today()
	,STRING		pServerIP			=	Constants(pVersion).serverIP
	,STRING		pDirectory		=	Constants(pVersion).Directory
	,STRING		pFilename			=	'RiskView*csv'
	,STRING		pGroupName		=	_Dataset().groupname
	,BOOLEAN	pIsTesting		=	FALSE
	,BOOLEAN	pOverwrite		=	TRUE
	,STRING		pNameOutput		=	'LiensV2 Source Information Report Spray Info'
) :=
FUNCTION

	FilesToSpray := DATASET([

		//	Liens V2 Source Information Report
		{
			pServerIP, 																//	SourceIP
			pDirectory, 															//	SourceDirectory
			pFilename,																//	directory_filter
			0, 																				//	record_size
			Filenames(pVersion).input.srcinforpt.new(pVersion),		//	Thor_filename_template
			[ {Filenames(pVersion).input.srcinforpt.sprayed}	],	//	dSuperfilenames
			pGroupName, 															//	fun_Groupname
			pVersion, 																//	FileDate
			'[0-9]{8}', 															//	date_regex
			'VARIABLE', 															//	file_type
			'', 																			//	sourceRowTagXML
			_Dataset().max_record_size,								//	sourceMaxRecordSize
			',', 																			//	sourceCsvSeparate
			'\\n,\\r\\n', 														//	sourceCsvTerminate
			'\"', 																		//	sourceCsvQuote
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
				'LiensV2 Source Information Report ' + pVersion,	//	pEmailSubjectDataset
				pNameOutput, 						//	pOutputName
				TRUE, 									//	pShouldClearSuperfileFirst
				FALSE, 									//	pSplitEmails
				FALSE, 									//	pShouldSprayZeroByteFiles
				FALSE										//	pShouldSprayMultipleFilesAs1
			)
		)
	);

END;
