IMPORT	VersionControl,	tools,	_control;
EXPORT	fSprayFiles := MODULE

	EXPORT OptOutSrc(
								STRING			pVersionDate			=	'',
								STRING			pServerIP					=	Constants.serverIP,
								STRING			pDirectory				=	Constants.OptOut.Directory,
								STRING			pFilename					=	Constants.OptOut.FileToSpray,
								STRING			pGroupName				=	tools.fun_Groupname('66'),
								BOOLEAN			pIsTesting				=	FALSE,
								BOOLEAN			pOverwrite				=	TRUE,
								STRING			pNameOutput				=	'SuppressOptOut Spray Info',
								UNSIGNED8 pMaxRecordSize  = tools.Constants('SuppressOptOut').max_record_size
							) := FUNCTION

		FilesToSpray := DATASET([

			//	CCPA Suppresion Opt Out Input File
			{
				pServerIP, 																//	SourceIP
				pDirectory+pVersionDate+'/',				//	SourceDirectory
				pFilename,																//	directory_filter
				0, 																				//	record_size, for fix length only
				Filenames(pVersionDate).OptOut.input.new(pVersionDate),	//	Thor_filename_template
				[ {Filenames(pVersionDate).OptOut.input.sprayed	}	],		//	dSuperfilenames
				pGroupName, 															//	fun_Groupname
				pVersionDate, 														//	FileDate
				'[0-9]{8}', 															//	date_regex
				'VARIABLE', 															//	file_type
				'', 																			//	sourceRowTagXML
				pMaxRecordSize,												//	sourceMaxRecordSize
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
					'SuppressOptOut ' + pVersionDate,	//	pEmailSubjectDataset
					pNameOutput, 						//	pOutputName
					TRUE, 									//	pShouldClearSuperfileFirst
					FALSE, 									//	pSplitEmails
					FALSE, 									//	pShouldSprayZeroByteFiles
					FALSE										//	pShouldSprayMultipleFilesAs1
				)
			)
		);

	END;
		
END;		
