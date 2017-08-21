IMPORT tools, _control;

srcCSVseparator					:=	'|';
srcCSVterminator				:=	'\\n,\\r\\n';
srcCSVquote							:=	'';

EXPORT spray_V12_epostal(
	 STRING		pVersionDate
	,boolean	pIsTesting	= FALSE
	,BOOLEAN	pOverwrite	= TRUE
	,string		pServer			= _Control.IPAddress.bctlpedata11
	,STRING		pDirectory		= '/data/hds_180/V12/data/'+pVersionDate
	,STRING		pGroupName		= _Constants().groupname														
	,STRING		pNameOutput		= _Constants().Name + ' Spray Info'
) :=
function

	spry_raw:=DATASET([

			{pServer																// SourceIP
			,pDirectory															// SourceDirectory
			,'*postal_emails_*txt'						 	// directory_filter
			,0																			// record_size
			,'~thor_data400::in::email::v12_epostal::@version@'	// Thor_filename_template
			,[{'~thor_data400::in::email::v12_epostal'}]				// dSuperfilenames
			,pGroupName															// fun_Groupname
			,pVersionDate														// FileDate
			,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 														// file_type
			,''																			// sourceRowTagXML
			,_Constants().max_record_size 					// sourceMaxRecordSize
			,srcCSVseparator 												// sourceCsvSeparate
			,srcCSVterminator 											// sourceCsvTerminate
			,srcCSVquote 														// sourceCsvQuote
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
					,'shannon.lucero@lexisnexis.com'				// pEmailNotificationList
					,'V12 epostal spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,TRUE 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,FALSE				// pShouldSprayMultipleFilesAs1
				);

END;
