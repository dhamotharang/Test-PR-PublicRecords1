import VersionControl,_Control, tools, STD, PRTE2;

srcCSVseparator					:=	'\\t';
srcCSVterminator				:=	'\\n,\\r\\n';
srcCSVquote							:=	'"';


EXPORT proc_spray_liensV2(

	 STRING		pVersionDate	= ''
	,boolean	pIsTesting	= FALSE
	,BOOLEAN	pOverwrite	= TRUE
	,string		pServer			= prte2._Constants().sServerIP
	,string		pDir				= prte2._Constants().sDirectory
	,string		pGroupName	= tools.fun_Clustername_DFU()
	,STRING		pNameOutput	=  'LiensV2 PRTE Spray Info'
) :=
function
	spray_raw:=DATASET([

		 {pServer																// SourceIP
		 ,pDir																	// SourceDirectory
		 ,'*liensv2__main*.txt'										// directory_filter
		 ,0																			// record_size
		 ,'~prte::in::liensV2::@version@::main'	// Thor_filename_template
		 ,[{'~prte::in::liensV2::main'}]					// dSuperfilenames
		 ,pGroupName														// fun_Groupname
		 ,pVersionDate													// FileDate
		 ,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 													// file_type
			,'' 																	// sourceRowTagXML
			,8129														 		// sourceMaxRecordSize
			,srcCSVseparator 											// sourceCsvSeparate
			,srcCSVterminator 										// sourceCsvTerminate
			,srcCSVquote 													// sourceCsvQuote
			,TRUE 																// compress
			,pOverwrite 													// shouldoverwrite
			,FALSE 																// ShouldSprayZeroByteFiles
			,FALSE  															// ShouldSprayMultipleFilesAs1
		},
		
		{pServer																// SourceIP
		 ,pDir																	// SourceDirectory
		 ,'*liensv2__party*.txt'									// directory_filter
		 ,0																			// record_size
		 ,'~prte::in::liensV2::@version@::party'	// Thor_filename_template
		 ,[{'~prte::in::liensV2::party'}]					// dSuperfilenames
		 ,pGroupName														// fun_Groupname
		 ,pVersionDate													// FileDate
		 ,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 													// file_type
			,'' 																	// sourceRowTagXML
			,8129														 		// sourceMaxRecordSize
			,srcCSVseparator 											// sourceCsvSeparate
			,srcCSVterminator 										// sourceCsvTerminate
			,srcCSVquote 													// sourceCsvQuote
			,TRUE 																// compress
			,pOverwrite 													// shouldoverwrite
			,FALSE 																// ShouldSprayZeroByteFiles
			,FALSE  															// ShouldSprayMultipleFilesAs1
		},
		
		{pServer																// SourceIP
		 ,pDir																	// SourceDirectory
		 ,'*liensv2_status*.txt'										// directory_filter
		 ,0																			// record_size
		 ,'~prte::in::liensV2::@version@::status'	// Thor_filename_template
		 ,[{'~prte::in::liensV2::status'}]					// dSuperfilenames
		 ,pGroupName														// fun_Groupname
		 ,pVersionDate													// FileDate
		 ,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 													// file_type
			,'' 																	// sourceRowTagXML
			,8129														 		// sourceMaxRecordSize
			,srcCSVseparator 											// sourceCsvSeparate
			,srcCSVterminator 										// sourceCsvTerminate
			,srcCSVquote 													// sourceCsvQuote
			,TRUE 																// compress
			,pOverwrite 													// shouldoverwrite
			,FALSE 																// ShouldSprayZeroByteFiles
			,FALSE  															// ShouldSprayMultipleFilesAs1
		}
				], tools.Layout_Sprays.Info);
	
RETURN tools.fun_Spray
				( 
					spray_raw			// pSprayInformation
					, 						// pSprayInfoSuperfile
					,							// pSprayInfoLogicalfile
					,pOverwrite 	// pOverwrite
					,							// pReplicate
					,TRUE					// pAddCounter
					,pIsTesting		// pIsTesting
					,'shannon.skumanich@lexisnexis.com'				// pEmailNotificationList
					,'LiensV2 PRTE spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,TRUE 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,FALSE				// pShouldSprayMultipleFilesAs1
				);

END;