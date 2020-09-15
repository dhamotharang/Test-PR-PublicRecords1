IMPORT tools, _control;

EXPORT SprayFiles(
	STRING	pVersionDate	=	'',
	BOOLEAN	pPromote			= FALSE,
	// STRING	pServerIP			= IF(_control.thisenvironment.name='Dataland',
																										// _control.IPAddress.bctlpedata12,
																										// _control.IPAddress.bctlpedata11),
  STRING	pServerIP			= _control.IPAddress.bctlpedata12,																									
  STRING	pDirectory		= '/data/temp/reederkx/repository/build_library/builds/whois_data/data/processing/'+pVersionDate,
	// STRING	pGroupName		=	_Constants().groupname,							
	STRING	pGroupName		=	'thor400_dev01',
	BOOLEAN	pIsTesting		=	FALSE,
	BOOLEAN	pOverwrite		=	TRUE,
	STRING	pNameOutput		=	_Constants().Name + ' Spray Info'
) :=
FUNCTION

	spry_raw:=DATASET([

			{pServerIP																// SourceIP
			,pDirectory															// SourceDirectory
			,'*.csv'						 										// directory_filter
			,0																			// record_size
			,WhoIs.thor_cluster+'in::email::WhoIs_Data::@version@'	// Thor_filename_template
			,[{WhoIs.thor_cluster+'in::email::WhoIs_Data'}]				// dSuperfilenames
			,pGroupName															// fun_Groupname
			,pVersionDate														// FileDate
			,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 														// file_type
			,''																			// sourceRowTagXML
			,_Constants().max_record_size 					// sourceMaxRecordSize
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

