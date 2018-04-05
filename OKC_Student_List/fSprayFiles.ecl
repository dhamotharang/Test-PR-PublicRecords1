import versioncontrol, tools, _control, OKC_Student_List;

// OKC Drop zone - \\Tapeload02b\direct_from_okc\StudentDirectory
// Landing zone file location - \\Tapeload02b\K\metadata\education\student_directory_data
EXPORT fSprayFiles( 
	STRING		pVersionDate		=	'',
	STRING		pServerIP				= Constants().serverIP,
	STRING		pDirectory			= Constants().Directory,
	STRING		pFilename				=	'*',
	STRING		pGroupName			=	_Dataset().groupname,
	BOOLEAN		pIsTesting			=	FALSE,
	BOOLEAN		pOverwrite			=	TRUE,
	STRING		pNameOutput			=	'OKC_Student_List Spray Input Files'
) :=
FUNCTION
FilesToSpray := DATASET([

		//	SBFE
		{
			pServerIP, 																//	SourceIP
			pDirectory+pVersionDate,//+'/',							//	SourceDirectory
			//pFilename,																//	directory_filter
			'StudentDir-Student-'+pFilename+'.txt',
			0, 																				//	record_size
			OKC_Student_List.Filenames(pVersionDate).input.Student.new(pVersionDate),	//	Thor_filename_template
			[ {OKC_Student_List.Filenames(pVersionDate).input.Student.sprayed	}	],		//	dSuperfilenames
			pGroupName, 															//	fun_Groupname
			pVersionDate, 														//	FileDate
			'[0-9]{8}', 															//	date_regex
			'VARIABLE', 															//	file_type
			'', 																			//	sourceRowTagXML
			tools.Constants('OKC_Student_List').max_record_size,	//	sourceMaxRecordSize
			'|', 																		//	sourceCsvSeparate
			'\\n,\\r\\n', 														//	sourceCsvTerminate
			'', 																			//	sourceCsvQuote
			TRUE, 																		//	compress
			pOverwrite, 															//	shouldoverwrite
			FALSE, 																		//	ShouldSprayZeroByteFiles
			FALSE  																		//	ShouldSprayMultipleFilesAs1
		},
		{
			pServerIP, 																//	SourceIP
			pDirectory+pVersionDate,//+'/',							//	SourceDirectory
			//pFilename,																//	directory_filter
			'StudentDir-Address-'+pFilename+'.txt',
			0, 																				//	record_size
			OKC_Student_List.Filenames(pVersionDate).input.Address.new(pVersionDate),	//	Thor_filename_template
			[ {OKC_Student_List.Filenames(pVersionDate).input.Address.sprayed	}	],		//	dSuperfilenames
			pGroupName, 															//	fun_Groupname
			pVersionDate, 														//	FileDate
			'[0-9]{8}', 															//	date_regex
			'VARIABLE', 															//	file_type
			'', 																			//	sourceRowTagXML
			tools.Constants('OKC_Student_List').max_record_size,	//	sourceMaxRecordSize
			'|', 																		//	sourceCsvSeparate
			'\\n,\\r\\n', 														//	sourceCsvTerminate
			'', 																			//	sourceCsvQuote
			TRUE, 																		//	compress
			pOverwrite, 															//	shouldoverwrite
			FALSE, 																		//	ShouldSprayZeroByteFiles
			FALSE  																		//	ShouldSprayMultipleFilesAs1
		},
		{
			pServerIP, 																//	SourceIP
			pDirectory+pVersionDate,//+'/',							//	SourceDirectory
			//pFilename,																//	directory_filter
			'StudentDir-Phone-'+pFilename+'.txt',
			0, 																				//	record_size
			OKC_Student_List.Filenames(pVersionDate).input.Phone.new(pVersionDate),	//	Thor_filename_template
			[ {OKC_Student_List.Filenames(pVersionDate).input.Phone.sprayed	}	],		//	dSuperfilenames
			pGroupName, 															//	fun_Groupname
			pVersionDate, 														//	FileDate
			'[0-9]{8}', 															//	date_regex
			'VARIABLE', 															//	file_type
			'', 																			//	sourceRowTagXML
			tools.Constants('OKC_Student_List').max_record_size,	//	sourceMaxRecordSize
			'|', 																		//	sourceCsvSeparate
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
				'OKC_Student_List ' + pVersionDate,	//	pEmailSubjectDataset
				pNameOutput, 						//	pOutputName
				TRUE, 									//	pShouldClearSuperfileFirst
				FALSE, 									//	pSplitEmails
				FALSE, 									//	pShouldSprayZeroByteFiles
				FALSE										//	pShouldSprayMultipleFilesAs1
			)
			
		)
	);

END;