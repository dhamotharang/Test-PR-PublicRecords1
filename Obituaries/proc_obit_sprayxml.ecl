import VersionControl,_Control, tools;

EXPORT proc_obit_sprayxml(

	 STRING		pVersionDate
	,boolean	pIsTesting	= FALSE
	,BOOLEAN	pOverwrite	= TRUE
	,string		pServer			= _Control.IPAddress.bctlpedata10
	,string		pDir				= '/data/hds_4/death_master/in/obituary/'
	,string		pGroupName	= _Constants().groupname
	,STRING		pNameOutput	= _Constants().Name  + ' Spray Info'
) :=
function

	spry_raw:=DATASET([

		 {pServer																// SourceIP
		 ,pDir																	// SourceDirectory
		 ,'memorial_lexis_nexis*xml'						// directory_filter
		 //,'lexis_nexis_historics*.xml'
		 ,0																			// record_size
		 ,'~thor_data400::in::tributes_obits_@version@_xml'	// Thor_filename_template
		 ,[{'~thor_data400::in::tributes_dmaster_raw'}]						// dSuperfilenames
		 ,pGroupName														// fun_Groupname
		 ,pVersionDate													// FileDate
		 ,'[0-9]{8}' 														// date_regex
		 ,'XML'																	// file_type
		 ,'obituary'														// sourceRowTagXML
		 ,21000															    // sourceMaxRecordSize
		 ,''								 										// sourceCsvSeparate
		 ,''								 										// sourceCsvTerminate
		 ,''						 												// sourceCsvQuote
		 ,TRUE 																// compress
		 ,pOverwrite 														// shouldoverwrite
		 ,FALSE																	// ShouldSprayZeroByteFiles
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
					,'Tributes spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,TRUE 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,FALSE				// pShouldSprayMultipleFilesAs1
				);

END;
