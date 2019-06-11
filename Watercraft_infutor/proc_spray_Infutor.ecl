import VersionControl,_Control, tools;

srcCSVseparator					:=	'\t';
srcCSVterminator				:=	'\\n,\\r\\n';
srcCSVquote							:=	'"';

EXPORT proc_spray_Infutor(

	 STRING		pVersionDate	= ''
	,boolean	pIsTesting	= FALSE
	,BOOLEAN	pOverwrite	= TRUE
	,string		pServer			= _Control.IPAddress.bctlpedata11
	,string		pDir				= '/data/super_credit/watercraft/infolink/infutor/in/' + pVersionDate + '/'
	,string		pGroupName	= _Constants().groupname
	,STRING		pNameOutput	= _Constants().Name  + ' Spray Info'
) :=
function

	spry_raw:=DATASET([

		 {pServer																// SourceIP
		 ,pDir																	// SourceDirectory
		 ,'*txt'																// directory_filter
		 ,0																			// record_size
		 ,'~thor_data400::in::watercraft::infutor_raw::@version@'	// Thor_filename_template
		 ,[{'~thor_data400::in::watercraft::infutor'}]						// dSuperfilenames
		 ,pGroupName														// fun_Groupname
		 ,pVersionDate													// FileDate
		 ,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 													// file_type
			,'' 																	// sourceRowTagXML
			,_Constants().max_record_size			 		// sourceMaxRecordSize
			,srcCSVseparator 											// sourceCsvSeparate
			,srcCSVterminator 										// sourceCsvTerminate
			,srcCSVquote 													// sourceCsvQuote
			,FALSE 																// compress
			,pOverwrite 													// shouldoverwrite
			,FALSE 																// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		}
	], tools.Layout_Sprays.Info);
	
RETURN IF(pDir != '',
					SEQUENTIAL(
				//FileServices.ClearSuperFile('~thor_data400::in::watercraft::infutor'),
					tools.fun_Spray
					( 
					spry_raw			// pSprayInformation
					, 						// pSprayInfoSuperfile
					,							// pSprayInfoLogicalfile
					,pOverwrite 	// pOverwrite
					,							// pReplicate
					,TRUE					// pAddCounter
					,pIsTesting		// pIsTesting
					,'Sudhir.Kasavajjala@lexisnexisrisk.com; Michael.Gould@lexisnexisrisk.com'			// pEmailNotificationList
					,'Infutor Watercraft spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,FALSE 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,FALSE				// pShouldSprayMultipleFilesAs1
					))
				);
END;
