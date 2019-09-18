IMPORT PhoneMart, tools, _control, std;

  DaliIp           := std.system.Thorlib.DaliServer();
  GroupName 			 		:= map(DaliIp = '10.241.12.201:7070' => 'thor400_dev01', // Dataland
																	 DaliIp = '10.241.20.205:7070' => 'thor400_36',   	// Boca Production   
																	 'thor400_36');                              

EXPORT spray_files(
	STRING		pVersionDate		=	''
	,STRING		pServerIP				=	_control.IPAddress.bctlpedata11
	,STRING		pDirectory			= '/data/hds_2/phonemart_ln/'
	,STRING		pGroupName			=	GroupName															
	,BOOLEAN	pIsTesting			=	FALSE
	,BOOLEAN	pOverwrite			=	TRUE
	,STRING		pNameOutput			=	PhoneMart._Constants().Name + ' Spray Info'
) :=
function

	FilesToSpray := DATASET([
		//CMS - Note, this file only must be FTP'd to edata12 as Binary
		{
			pServerIP 												// SourceIP
			,pDirectory+pVersionDate+'/'			// SourceDirectory
			,'PhoneMart1*LN*' 							  // directory_filter
			,35																// record_size
			,'~thor_data400::in::phonemart::cms_' + pVersionDate// Thor_filename_template
			,[ {'~thor_data400::in::phonemart::cms'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,PhoneMart._Constants().max_record_size	// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,TRUE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
	//Individual
		{
			pServerIP 												// SourceIP
			,pDirectory+pVersionDate+'/'			// SourceDirectory
			,'PhoneMart3*LN*' 							  // directory_filter
			,166																// record_size
			,'~thor_data400::in::phonemart::indv_' + pVersionDate // Thor_filename_template
			,[ {'~thor_data400::in::phonemart::indv'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,PhoneMart._Constants().max_record_size	// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,TRUE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		}
	], tools.Layout_Sprays.Info);
	
RETURN IF(pDirectory != '',
					SEQUENTIAL(
						//clear the input files
					  FileServices.StartSuperFileTransaction();
						IF(FileServices.SuperFileExists('~thor_data400::in::phonemart::cms'), 
						   FileServices.ClearSuperFile('~thor_data400::in::phonemart::cms'),
						   FileServices.CreateSuperFile('~thor_data400::in::phonemart::cms'));
						IF(FileServices.SuperFileExists('~thor_data400::in::phonemart::indv'),
						   FileServices.ClearSuperFile('~thor_data400::in::phonemart::indv'),
						   FileServices.CreateSuperFile('~thor_data400::in::phonemart::indv'));
						FileServices.FinishSuperFileTransaction();
						tools.fun_Spray
						( 
						FilesToSpray	// pSprayInformation
						, 						// pSprayInfoSuperfile
						,							// pSprayInfoLogicalfile
						,pOverwrite 	// pOverwrite
						,							// pReplicate
						,TRUE					// pAddCounter
						,pIsTesting		// pIsTesting
						,'cathy.tio@lexisnexis.com'				// pEmailNotificationList
						,'PhoneMartLN spray' + ' ' + pVersionDate	// pEmailSubjectDataset
						,pNameOutput 	// pOutputName
						,TRUE 				// pShouldClearSuperfileFirst
						,FALSE 				// pSplitEmails
						,FALSE 				// pShouldSprayZeroByteFiles
						,FALSE				// pShouldSprayMultipleFilesAs1
						)
					)
				);
END;	
