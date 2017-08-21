IMPORT tools, _control;

state	:= 'DeathMaster_Delete';

srcCSVseparator					:=	',';
srcCSVterminator				:=	'\\n,\\r\\n';
srcCSVquote							:=	'"';
srcRecordSize						:= 	109;

EXPORT Spray_DeathMasterDelete(
	STRING		pVersionDate	= '',
	STRING		pServerIP			= _control.IPAddress.edata12,
	STRING		pDirectory		= '/hds_4/death_master/keys',
	STRING		pFilename			= 'death_master.deletes.d00',
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
			srcRecordSize, 													// record_size
			Filenames(state).input.Template, 				// Thor_filename_template
			[ {Filenames(state).input.sprayed	}	], 	// dSuperfilenames
			pGroupName, 														// fun_Groupname
			pVersionDate, 													// FileDate
			'[0-9]{8}', 														// date_regex
			'FIXED', 																// file_type
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
		
// Code is written such that if this is the first time it is run and the Superfile, Father and Delete don't
// exist, they will be created and the code will not fail.
	RETURN IF(	pDirectory != '',
			SEQUENTIAL
			(
				FileServices.StartSuperFileTransaction(),
				IF (FileServices.SuperFileExists(Filenames(state).input.sprayed+'_father'),
						FileServices.AddSuperFile(Filenames(state).input.sprayed+'_delete',Filenames(state).input.sprayed+'_father',,TRUE),
						FileServices.CreateSuperFile(Filenames(state).input.sprayed+'_father')),
				FileServices.ClearSuperFile(Filenames(state).input.sprayed+'_father'),
				IF (FileServices.SuperFileExists(Filenames(state).input.sprayed),
						FileServices.AddSuperFile(Filenames(state).input.sprayed+'_father',Filenames(state).input.sprayed,,TRUE),
						FileServices.CreateSuperFile(Filenames(state).input.sprayed)),
				FileServices.ClearSuperFile(Filenames(state).input.sprayed),
				FileServices.FinishSuperFileTransaction(),
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
				), 
				IF (FileServices.SuperFileExists(Filenames(state).input.sprayed+'_delete'),
						FileServices.ClearSuperFile(Filenames(state).input.sprayed+'_delete',TRUE),
						FileServices.CreateSuperFile(Filenames(state).input.sprayed+'_delete'))
			)
	);

END;
