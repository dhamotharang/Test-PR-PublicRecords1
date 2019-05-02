﻿import versioncontrol, tools, _control, OKC_Student_List;

// OKC Drop zone - \\Tapeload02b\direct_from_okc\StudentDirectory
// Landing zone file location - \\Tapeload02b\K\metadata\education\student_directory_data
EXPORT fSpray_CollateralAnalytics( 
	STRING		pVersionDate		=	'',
	STRING		pServerIP				= Constants().serverIP,
	STRING		pDirectory			= Constants().Directory,
	STRING		pFilename				=	'*',
	STRING		pGroupName			=	_Dataset().groupname,
	BOOLEAN		pIsTesting			=	FALSE,
	BOOLEAN		pOverwrite			=	TRUE,
	STRING		pNameOutput			=	'Collateral Analytics Spray Input Files'
) :=
FUNCTION
FilesToSpray := DATASET([

		//	
		{
			pServerIP, 																//	SourceIP
			pDirectory,//+'/',							//	SourceDirectory
			//pFilename,																//	directory_filter
			'CA_MLS_INSURANCE_'+pVersionDate+'.txt',
			0, 																				//	record_size
			CollateralAnalytics.Filenames(pVersionDate).input.new(pVersionDate),	//	Thor_filename_template
			[ {CollateralAnalytics.Filenames(pVersionDate).input.sprayed	}	],		//	dSuperfilenames
			pGroupName, 															//	fun_Groupname
			pVersionDate, 														//	FileDate
			'[0-9]{8}', 															//	date_regex
			'VARIABLE', 															//	file_type
			'', 																			//	sourceRowTagXML
			tools.Constants('CollateralAnalytics').max_record_size,	//	sourceMaxRecordSize
			'\t', 																		//	sourceCsvSeparate
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
				'CollateralAnalytics ' + pVersionDate,	//	pEmailSubjectDataset
				pNameOutput, 						//	pOutputName
				TRUE, 									//	pShouldClearSuperfileFirst
				FALSE, 									//	pSplitEmails
				FALSE, 									//	pShouldSprayZeroByteFiles
				FALSE										//	pShouldSprayMultipleFilesAs1
			)
			
		)
	);

END;