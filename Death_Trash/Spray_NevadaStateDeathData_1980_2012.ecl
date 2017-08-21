IMPORT tools, _control;

state	:= 'NV';

srcCSVseparator					:=	',';
srcCSVterminator				:=	'\\n,\\r\\n';
srcCSVquote							:=	'"';

EXPORT Spray_NevadaStateDeathData_1980_2012(
	STRING		pVersionDate	= '',
	BOOLEAN		pPromote			= FALSE,
	STRING		pServerIP			= _control.IPAddress.edata12,
	STRING		pDirectory		= '/hds_4/death_master/in/state_deaths/'+StringLib.StringToLowerCase(state),
	STRING		pFilename			= '*deaths (LexisNexis)*.csv',
	STRING		pGroupName		= _Constants().groupname,															
	BOOLEAN		pIsTesting		= FALSE,
	BOOLEAN		pOverwrite		= TRUE,
	STRING		pNameOutput		= _Constants().Name + ' Spray Info'
) :=
FUNCTION

	FilesToSpray := DATASET(
	[
		{
			pServerIP, 															// SourceIP
			pDirectory, 														// SourceDirectory
			pFilename, 															// directory_filter
			0, 																			// record_size
			Filenames(state+'1980_2012').input.Template, 				// Thor_filename_template
			[ {Filenames(state+'1980_2012').input.sprayed	}	], 	// dSuperfilenames		
			pGroupName, 														// fun_Groupname
			pVersionDate, 																		// FileDate
			'[0-9]{8}', 														// date_regex
			'VARIABLE', 														// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size, 					// sourceMaxRecordSize
			srcCSVseparator, 												// sourceCsvSeparate
			srcCSVterminator, 											// sourceCsvTerminate
			srcCSVquote, 														// sourceCsvQuote
			FALSE, 																	// compress
			pOverwrite, 														// shouldoverwrite
			FALSE, 																	// ShouldSprayZeroByteFiles
			FALSE  																	// ShouldSprayMultipleFilesAs1
		}
	], tools.Layout_Sprays.Info);

	RETURN IF(	pDirectory != '',
		IF (	pPromote,
			SEQUENTIAL
			(
				FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(Filenames(state+'1980_2012').input.sprayed+'_history',Filenames(state+'1980_2012').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames(state+'1980_2012').input.sprayed),
				FileServices.FinishSuperFileTransaction()
			),
			SEQUENTIAL
			(
				tools.fun_Spray
				( 
					FilesToSpray,	// pSprayInformation
					, 						// pSprayInfoSuperfile
					,							// pSprayInfoLogicalfile
					pOverwrite, 	// pOverwrite
					,							// pReplicate
					TRUE,					// pAddCounter
					pIsTesting,		// pIsTesting
					,							// pEmailNotificationList
					_Constants().Name + ' ' + pVersionDate,	// pEmailSubjectDataset
					pNameOutput, 	// pOutputName
					TRUE, 				// pShouldClearSuperfileFirst
					FALSE, 				// pSplitEmails
					FALSE, 				// pShouldSprayZeroByteFiles
					FALSE					// pShouldSprayMultipleFilesAs1
				)
			)
		)
	);

END;
