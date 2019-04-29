IMPORT tools, _control;

EXPORT SprayBVFile(
	STRING		pVersionDate	=	'',
	BOOLEAN		pPromote			= FALSE,
	STRING		pServerIP			= IF(_control.thisenvironment.name='Dataland',
																										_control.IPAddress.bctlpedata12,
																										_control.IPAddress.bctlpedata11),
	STRING		pDirectory			= '/data/data_999/email/delta_gateway/'+pVersionDate,
	STRING		pGroupName			=	_Constants().groupname,															
	BOOLEAN		pIsTesting			=	FALSE,
	BOOLEAN		pOverwrite			=	TRUE,
	STRING		pNameOutput			=	_Constants().Name + ' Spray Info'
) :=
FUNCTION

	spry_raw:=DATASET([

			{pServerIP																// SourceIP
			,pDirectory															// SourceDirectory
			,'*.txt'						 										// directory_filter
			,0																			// record_size
			,'~thor_data400::in::email_dataV2::bv_email_event::@version@'	// Thor_filename_template
			,[{'~thor_data400::in::email_dataV2::bv_email_event'}]				// dSuperfilenames
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
					,'BV Event spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,TRUE 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,FALSE				// pShouldSprayMultipleFilesAs1
				);

END;

