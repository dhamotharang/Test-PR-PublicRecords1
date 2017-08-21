import VersionControl,_Control, tools;

srcCSVseparator					:=	'|';
srcCSVterminator				:=	'\\n,\\r\\n';
srcCSVquote							:=	'"';


EXPORT proc_spray_obituary(

	 STRING		pVersionDate	= ''
	,boolean	pIsTesting	= FALSE
	,BOOLEAN	pOverwrite	= TRUE
	,string		pServer			= _Control.IPAddress.bctlpedata10
	,string		pDir				= '/data/hds_4/death_master/in/'
	,string		pGroupName	= _Constants().groupname
	,STRING		pNameOutput	=  'ObituaryData Spray Info'
) :=
function

	//ObituaryData.com
	spry_raw:=DATASET([

		 {pServer																// SourceIP
		 ,pDir+'obituary_dotcom'								// SourceDirectory
		 ,'*txt'																// directory_filter
		 ,0																			// record_size
		 ,'~thor_data400::in::obituarydata_raw_@version@'	// Thor_filename_template
		 ,[{'~thor_data400::in::obituarydata_raw'}]						// dSuperfilenames
		 ,pGroupName														// fun_Groupname
		 ,pVersionDate													// FileDate
		 ,'[0-9]{8}' 														// date_regex
			,'VARIABLE' 													// file_type
			,'' 																	// sourceRowTagXML
			,_Constants().max_record_size			 		// sourceMaxRecordSize
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
					,'shannon.lucero@lexisnexis.com'				// pEmailNotificationList
					,'ObituaryData_dotcom spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,TRUE 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,FALSE				// pShouldSprayMultipleFilesAs1
				);

END;
