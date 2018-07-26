import OKC_Probate, VersionControl,_Control, tools, STD;

srcCSVseparator					:=	',';
srcCSVterminator				:=	'\\n,\\r\\n';
srcCSVquote							:=	'"';


EXPORT fSprayFiles(

	 STRING		pVersionDate	=	(STRING)STD.Date.Today()
	,string		pServer			=	OKC_Probate.Constants(pVersionDate).serverIP
	,string		pDir				=	OKC_Probate.Constants(pVersionDate).Directory + pVersionDate
	,STRING		pFilename			=	'*csv'
	,string		pGroupName	=	_Dataset().groupname
	,boolean	pIsTesting	= FALSE
	,BOOLEAN	pOverwrite	= TRUE
	,STRING		pNameOutput	=  'OKC Probate Spray Info'
) :=
function

	//okc_probate.com
	spry_raw:=DATASET([

		 {pServer																// SourceIP
		 ,pDir																			// SourceDirectory
		 ,'*csv'																// directory_filter
		 ,0																			// record_size
			,Filenames(pVersionDate).input.raw.new(pVersionDate)	//	Thor_filename_template
			,[ {Filenames(pVersionDate).input.raw.sprayed}	]	//	dSuperfilenames
		 ,pGroupName														// fun_Groupname
		 ,pVersionDate													// FileDate
		 ,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 													// file_type
			,'' 																	// sourceRowTagXML
			,_Dataset().max_record_size	//	sourceMaxRecordSize
			,srcCSVseparator 											// sourceCsvSeparate
			,srcCSVterminator 										// sourceCsvTerminate
			,srcCSVquote 													// sourceCsvQuote
			,TRUE 																// compress
			,pOverwrite 													// shouldoverwrite
			,FALSE 																// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
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
					,												// pEmailNotificationList
					,'okc_probate spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,TRUE 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,FALSE				// pShouldSprayMultipleFilesAs1
				);

END;