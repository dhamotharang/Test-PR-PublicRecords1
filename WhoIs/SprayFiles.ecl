IMPORT tools, _control, STD;

EXPORT SprayFiles(
	STRING	pVersionDate	=	(STRING)STD.Date.Today(),
  STRING	pServerIP			= Constants(pVersionDate).serverIP,																									
  STRING	pDirectory		= Constants(pVersionDate).Directory + pVersionDate + '/',		
	STRING  pFilename     = '*.csv',	
	STRING	pGroupName		=	_Dataset().pGroupname,
	BOOLEAN	pIsTesting		=	FALSE,
	BOOLEAN	pOverwrite		=	TRUE,
	STRING	pNameOutput		=	'WhoIs Spray Info'
) :=
FUNCTION

	spry_raw:=DATASET([

			{pServerIP																// SourceIP
			,pDirectory															// SourceDirectory
			,pFilename					 										// directory_filter
			,0																			// record_size
			,WhoIs.thor_cluster+'in::email::WhoIs_Data::@version@'	// Thor_filename_template
			,[{WhoIs.thor_cluster+'in::email::WhoIs_Data'}]				// dSuperfilenames
			,pGroupName															// fun_Groupname
			,pVersionDate														// FileDate
			,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 														// file_type
			,''																			// sourceRowTagXML
			,_Dataset().pMaxRecordSize    					// sourceMaxRecordSize
			,','																		// sourceCsvSeparate
			,'\\n,\\r\\n' 													// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,TRUE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,TRUE 																	// ShouldSprayMultipleFilesAs1
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
					,'WhoIs Data spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,TRUE 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,TRUE				// pShouldSprayMultipleFilesAs1
				);

END;

