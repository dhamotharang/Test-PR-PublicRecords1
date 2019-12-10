IMPORT	VersionControl,	tools,	_control;
EXPORT	fSprayFiles(
  STRING		pVersionDate	=	'',
  STRING		pServerIP			= Constants.serverIP,
  STRING		pDirectory		= Constants.Directory,
  STRING		pFilename			=	'*',
  STRING		pGroupName		=	_Dataset().groupname,
  BOOLEAN		pIsTesting		=	FALSE,
  BOOLEAN		pOverwrite		=	TRUE,
  STRING		pNameOutput		=	'GateWayCollectionLogs Spray Info'
) :=
FUNCTION

  FilesToSpray := DATASET(
  [
  {
    pServerIP,                                        //	SourceIP
    pDirectory,                                       //	SourceDirectory
    '*csv',                                           //	directory_filter
    0,                                                //	record_size
    Filenames(pVersionDate).input.new(pVersionDate),  //	Thor_filename_template
    [ {Filenames(pVersionDate).input.sprayed	}	],		//	dSuperfilenames
    pGroupName,                                       //	fun_Groupname
    pVersionDate,                                     //	FileDate
    '[0-9]{8}',                                       //	date_regex
    'VARIABLE',                                       //	file_type
    '',                                               //	sourceRowTagXML
    tools.Constants('SBFE').max_record_size,          //	sourceMaxRecordSize
    '\t',                                             //	sourceCsvSeparate
    '\\n,\\r\\n',                                     //	sourceCsvTerminate
    '',                                               //	sourceCsvQuote
    TRUE,                                             //	compress
    pOverwrite,                                       //	shouldoverwrite
    FALSE,                                            //	ShouldSprayZeroByteFiles
    FALSE                                             //	ShouldSprayMultipleFilesAs1
  }
  ], VersionControl.Layout_Sprays.Info);
		
	RETURN IF
  (	pDirectory != '',
    SEQUENTIAL(
                VersionControl.fSprayInputFiles
                ( 
                  FilesToSpray,                           //	pSprayInformation
                  ,                                       //	pSprayInfoSuperfile
                  ,                                       //	pSprayInfoLogicalfile
                  pOverwrite,                             //	pOverwrite
                  ,                                       //	pReplicate
                  TRUE,                                   //	pAddCounter
                  pIsTesting,                             //	pIsTesting
                  ,                                       //	pEmailNotificationList
                  'GatewayCollectionLogs' + pVersionDate,	//	pEmailSubjectDataset
                  pNameOutput,                            //	pOutputName
                  TRUE,                                   //	pShouldClearSuperfileFirst
                  FALSE,                                  //	pSplitEmails
                  FALSE,                                  //	pShouldSprayZeroByteFiles
                  FALSE                                   //	pShouldSprayMultipleFilesAs1
                )
              )
  );

END;
