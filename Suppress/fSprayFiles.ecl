IMPORT	VersionControl,	tools,	_control;
EXPORT	fSprayFiles := MODULE

	EXPORT OptOutSrc(
								STRING			pVersionDate			=	'',
								STRING			pServerIP				=	$.Constants.serverIP,
								STRING			pDirectory				=	$.Constants.OptOut().Directory,
								STRING			pFilename				=	$.Constants.OptOut().FileToSpray,
								STRING			pGroupName				=	$.Constants.OptOut().GroupName,
								BOOLEAN			pIsTesting				=	FALSE,
								BOOLEAN			pOverwrite				=	TRUE,
								STRING			pNameOutput				=	'Suppress OptOut Spray Info',
								UNSIGNED8 pMaxRecordSize  = tools.Constants('SuppressOptOut').max_record_size
							) := FUNCTION

		FilesToSpray := DATASET([

			//	CCPA Suppresion Opt Out Input File
			{
				pServerIP, 												//	SourceIP
				pDirectory+'/',											//	SourceDirectory
				pFilename,												//	directory_filter
				0, 														//	record_size, for fix length only
				$.Filenames(pVersionDate).OptOut.input.new(pVersionDate),//	Thor_filename_template
				[{$.Filenames(pVersionDate).OptOut.input.sprayed}],		//	dSuperfilenames
				pGroupName, 											//	fun_Groupname
				pVersionDate, 											//	FileDate
				'[0-9]{8}', 											//	date_regex
				'VARIABLE', 											//	file_type
				'', 													//	sourceRowTagXML
				pMaxRecordSize,											//	sourceMaxRecordSize
				'|', 													//	sourceCsvSeparate
				'\\n,\\r\\n', 											//	sourceCsvTerminate
				'', 													//	sourceCsvQuote
				TRUE, 													//	compress
				pOverwrite, 											//	shouldoverwrite
				FALSE, 													//	ShouldSprayZeroByteFiles
				FALSE  													//	ShouldSprayMultipleFilesAs1
			}
			], VersionControl.Layout_Sprays.Info);
			
		RETURN IF(	pDirectory != '',
			SEQUENTIAL
			(
				VersionControl.fSprayInputFiles
				( 
					FilesToSpray,						//	pSprayInformation
					, 									//	pSprayInfoSuperfile
					,									//	pSprayInfoLogicalfile
					pOverwrite, 						//	pOverwrite
					,									//	pReplicate
					TRUE,								//	pAddCounter
					pIsTesting,							//	pIsTesting
					,									//	pEmailNotificationList
					'SuppressOptOut ' + pVersionDate,	//	pEmailSubjectDataset
					pNameOutput, 						//	pOutputName
					TRUE, 								//	pShouldClearSuperfileFirst
					FALSE, 								//	pSplitEmails
					FALSE, 								//	pShouldSprayZeroByteFiles
					FALSE								//	pShouldSprayMultipleFilesAs1
				)
			)
		);

	END;

	EXPORT Exemptions := MODULE
		EXPORT STRING thorCluster			:= 'thor::';
		EXPORT STRING name 					:= 'new_suppression::Exemptions'; 
		EXPORT STRING lGlobalSidPRTemplate	:=	'~' + thorCluster + 'in::'	 +	'Exemptions_pr' +	'::@version@::data';
		EXPORT STRING lGlobalSidHCTemplate	:=	'~' + thorCluster + 'in::'	 +	'Exemptions_hc' +	'::@version@::data';
		EXPORT STRING lGlobalSidInsTemplate	:=	'~' + thorCluster + 'in::'	 +	'Exemptions_ins' +	'::@version@::data';
		EXPORT STRING lBaseTemplate			:=	'~' + thorCluster + 'base::' +	name 		 +	'::data';

		EXPORT	Input_PR					:=	versioncontrol.mInputFilenameVersions(lGlobalSidPRTemplate);
		EXPORT	Input_HC					:=	versioncontrol.mInputFilenameVersions(lGlobalSidHCTemplate);
		EXPORT	Input_Ins					:=	versioncontrol.mInputFilenameVersions(lGlobalSidInsTemplate);
		EXPORT	Base						:=	'~' + thorCluster + 'base::' +	name;
	END;

	EXPORT Exemptions_File(
								STRING		pVersionDate			=	'',
								STRING		pServerIP				=	$.Constants.serverIP,
								STRING		pDirectory				=	$.Constants.Exemptions().Directory,
								STRING		pFilename				=	$.Constants.Exemptions().FileToSpray_PR,
								STRING		pDestPath				=	$.FileNames().Exemptions.lGlobalSidPRTemplate,
								STRING		pGroupName				=	tools.fun_Groupname('36'),
								BOOLEAN		pIsTesting				=	FALSE,
								BOOLEAN		pOverwrite				=	TRUE,
								STRING		pNameOutput				=	'Global SID Spray Info',
								UNSIGNED8	pMaxRecordSize  		= tools.Constants('SuppressOptOut').max_record_size
							) := FUNCTION

		FilesToSpray := DATASET([

			{
				pServerIP, 												//	SourceIP
				pDirectory+'/',											//	SourceDirectory
				pFilename,												//	directory_filter
				0, 														//	record_size, for fix length only
				versioncontrol.mInputFilenameVersions(pDestPath).new(pVersionDate),//	Thor_filename_template
				[{versioncontrol.mInputFilenameVersions(pDestPath).sprayed}],//	dSuperfilenames
				pGroupName, 											//	fun_Groupname
				pVersionDate, 											//	FileDate
				'[0-9]{8}', 											//	date_regex
				'VARIABLE', 											//	file_type
				'', 													//	sourceRowTagXML
				pMaxRecordSize,											//	sourceMaxRecordSize
				',', 													//	sourceCsvSeparate
				'\\n,\\r\\n', 											//	sourceCsvTerminate
				'', 													//	sourceCsvQuote
				TRUE, 													//	compress
				pOverwrite, 											//	shouldoverwrite
				FALSE, 													//	ShouldSprayZeroByteFiles
				FALSE  													//	ShouldSprayMultipleFilesAs1
			}
			], VersionControl.Layout_Sprays.Info);
			
		RETURN IF(	pDirectory != '',
			SEQUENTIAL
			(
				VersionControl.fSprayInputFiles
				( 
					FilesToSpray,						//	pSprayInformation
					, 									//	pSprayInfoSuperfile
					,									//	pSprayInfoLogicalfile
					pOverwrite, 						//	pOverwrite
					,									//	pReplicate
					TRUE,								//	pAddCounter
					pIsTesting,							//	pIsTesting
					,									//	pEmailNotificationList
					'SuppressOptOut ' + pVersionDate,	//	pEmailSubjectDataset
					pNameOutput, 						//	pOutputName
					TRUE, 								//	pShouldClearSuperfileFirst
					FALSE, 								//	pSplitEmails
					FALSE, 								//	pShouldSprayZeroByteFiles
					FALSE								//	pShouldSprayMultipleFilesAs1
				)
			)
		);

	END;

END;		
