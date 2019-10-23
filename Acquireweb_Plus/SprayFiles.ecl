IMPORT tools, _control, STD;

EXPORT SprayFiles(
	STRING		pVersionDate	=	'',
	BOOLEAN		pPromote			= FALSE,
	// STRING		pServerIP			= _control.IPAddress.bctlpedata11,
	STRING		pServerIP			= IF(_control.thisenvironment.name='Dataland',
																										_control.IPAddress.bctlpedata12,
																										_control.IPAddress.bctlpedata11),
	STRING		pDirectory		= '/data/hds_2/data/'+pVersionDate+'/processed/',
	STRING		pGroupName		=	STD.System.Thorlib.Group ( ),															
	BOOLEAN		pIsTesting		=	FALSE,
	BOOLEAN		pOverwrite		=	TRUE,
	STRING		pNameOutput		=	_Constants().Name + ' Spray Info'
) :=
FUNCTION

	spry_raw:=DATASET([

			{pServerIP																// SourceIP
			,pDirectory															// SourceDirectory
			,'*B2BData_*.txt'		 						// directory_filter
			,0																			// record_size
			,'~thor::in::Acquireweb::@version@::b2bdata'	// Thor_filename_template
			,[{'~thor::in::Acquireweb::business'}]				// dSuperfilenames
			,pGroupName															// fun_Groupname
			,pVersionDate														// FileDate
			,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 														// file_type
			,''																			// sourceRowTagXML
			,_Constants().max_record_size 					// sourceMaxRecordSize
			,'|'																		// sourceCsvSeparate
			,'\\n,\\r\\n' 													// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,TRUE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE 																	// ShouldSprayMultipleFilesAs1
			},
			
			{pServerIP																// SourceIP
			,pDirectory															// SourceDirectory
			,'*B2CIPData_*.txt'		 										// directory_filter
			,0																			// record_size
			,'~thor::in::Acquireweb::@version@::b2cipdata'	// Thor_filename_template
			,[{'~thor::in::Acquireweb::ipaddress'}]				// dSuperfilenames
			,pGroupName															// fun_Groupname
			,pVersionDate														// FileDate
			,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 														// file_type
			,''																			// sourceRowTagXML
			,_Constants().max_record_size 					// sourceMaxRecordSize
			,'|'																		// sourceCsvSeparate
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
					,'AcquireWeb Business spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,TRUE 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,TRUE					// pShouldSprayMultipleFilesAs1
				);

END;