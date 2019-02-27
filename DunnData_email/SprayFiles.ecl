IMPORT tools, _control;

EXPORT SprayFiles(
	STRING	pVersionDate	=	'',
	BOOLEAN	pPromote			= FALSE,
	STRING	pServerIP			= IF(_control.thisenvironment.name='Dataland',
																										_control.IPAddress.bctlpedata12,
																										_control.IPAddress.bctlpedata11),
 STRING		pDirectory		= '/data/hds_180/DunnData_Email/'+pVersionDate,
	STRING	pGroupName		=	_Constants().groupname,															
	BOOLEAN	pIsTesting		=	FALSE,
	BOOLEAN	pOverwrite		=	TRUE,
	STRING	pNameOutput		=	_Constants().Name + ' Spray Info'
) :=
FUNCTION

	spry_raw:=DATASET([

			{pServerIP																// SourceIP
			,pDirectory															// SourceDirectory
			,'*.txt'						 										// directory_filter
			,0																			// record_size
			,DunnData_Email.thor_cluster+'in::email::DunnData_Email::@version@'	// Thor_filename_template
			,[{DunnData_Email.thor_cluster+'in::email::DunnData_Email'}]				// dSuperfilenames
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
					,'Dunn Data Email spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,TRUE 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,TRUE				// pShouldSprayMultipleFilesAs1
				);

END;

