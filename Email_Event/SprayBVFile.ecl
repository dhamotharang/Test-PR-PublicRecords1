IMPORT Email_Event, tools, _control;

srcCSVseparator					:=	',';
srcCSVterminator				:=	'\\n,\\r\\n';
srcCSVquote							:=	'"';

EXPORT SprayBVFile(
	STRING		pVersionDate	=	'',
	BOOLEAN		pPromote			= FALSE,
	STRING		pServerIP			  = _Constants.serverIP,
	STRING		pDirectory			= _Constants.Directory,
	STRING		pGroupName			=	_Constants.Groupname,															
	BOOLEAN		pIsTesting			=	FALSE,
	BOOLEAN		pOverwrite			=	TRUE,
	STRING		pNameOutput			=	_Constants.Name + 'Delta Spray Info'
) :=
FUNCTION

	spry_raw:=DATASET([

			{pServerIP																// SourceIP
			,pDirectory															// SourceDirectory
			,'*.csv'						 										// directory_filter
			,0																			// record_size
			,'~thor_data400::raw::email_dataV2::bv::@version@'	// Thor_filename_template
			,[{'~thor_data400::raw::email_dataV2::bv'}]				// dSuperfilenames
			,pGroupName															// fun_Groupname
			,pVersionDate														// FileDate
			,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 														// file_type
			,''																			// sourceRowTagXML
			,8192 																	// sourceMaxRecordSize
			,srcCSVseparator 											  // sourceCsvSeparate
			,srcCSVterminator 									  	// sourceCsvTerminate
			,srcCSVquote 													  // sourceCsvQuote
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
					,'BV Event spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,TRUE 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,FALSE				// pShouldSprayMultipleFilesAs1
				);

END;

