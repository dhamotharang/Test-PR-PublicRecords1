IMPORT Email_Event, tools, _control;

EXPORT SprayBVdeltaFile(
	STRING		pVersionDate	=	'',
	BOOLEAN		pShouldClearSuperfileFirst			= TRUE,
	STRING		pServerIP			  = _Constants.serverIP,
	STRING		pDirectory			= _Constants.Directory_delta + pVersionDate,
	STRING		pGroupName			=	_Constants.Groupname,															
	BOOLEAN		pIsTesting			=	FALSE,
	BOOLEAN		pOverwrite			=	TRUE,
	STRING		pNameOutput			=	_Constants.Name + ' Spray Info'
) :=
FUNCTION

	spry_raw:=DATASET([

			{pServerIP																// SourceIP
			,pDirectory															// SourceDirectory
			,'*.txt'						 										// directory_filter
			,0																			// record_size
			,'~thor_data400::raw::email_dataV2::bv_delta::@version@'	// Thor_filename_template
			,[{'~thor_data400::raw::email_dataV2::bv_delta'}]				// dSuperfilenames
			,pGroupName															// fun_Groupname
			,pVersionDate														// FileDate
			,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 														// file_type
			,''																			// sourceRowTagXML
			,8192 																	// sourceMaxRecordSize
			,'|'																		// sourceCsvSeparate
			,'\\n,\\r\\n' 													// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,TRUE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE 																	// ShouldSprayMultipleFilesAs1
			}
	], tools.Layout_Sprays.Info);
	
RETURN tools.fun_Spray
				( 
					spry_raw			// pSprayInformation
					, 						// pSprayInfoSuperfile
					,							// pSprayInfoLogicalfile
					,pOverwrite 	// pOverwrite
					,							// pReplicate
					,TRUE					// pAddCounter
					,pIsTesting		// pIsTesting
					,							// pEmailNotificationList
					,'BV Delta Event spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,pShouldClearSuperfileFirst 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,FALSE				// pShouldSprayMultipleFilesAs1
				);

END;
