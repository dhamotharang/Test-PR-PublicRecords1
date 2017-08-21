IMPORT tools, _control;

filename								:=	'~thor_data400::in::ssa_deathm_raw';
srcCSVseparator					:=	'';
srcCSVterminator				:=	'';
srcCSVquote							:=	'';
srcRecordSize						:= 	102;

EXPORT Spray_SSADeathmaster(
	STRING		pServerIP			= IF(_control.thisenvironment.name='Dataland',
															_control.IPAddress.bctlpedata12,
															_control.IPAddress.bctlpedata10),
  STRING		pDirectory		= IF(_control.thisenvironment.name='Dataland',
															'/data/hds_4/death_master/in/_ssn_deaths',
															'/data/hds_4/death_master/in/ssn_deaths'),
	STRING		pFilename			= '*.txt',
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
			filename + '_@version@', 								// Thor_filename_template
			[ {filename}	],												// dSuperfilenames
			pGroupName, 														// fun_Groupname
			'',						 													// FileDate
			'[0-9]{8}', 														// date_regex
			'FIXED', 																// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size,			 			// sourceMaxRecordSize
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
		SEQUENTIAL
		(
			FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(filename+'_delete',filename+'_grandfather',,TRUE),
				FileServices.ClearSuperFile(filename+'_grandfather'),
				FileServices.AddSuperFile(filename+'_grandfather',filename+'_father',,TRUE),
				FileServices.ClearSuperFile(filename+'_father'),
				FileServices.AddSuperFile(filename+'_father',filename,,TRUE),
				FileServices.ClearSuperFile(filename),
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
				_Constants().Name,	// pEmailSubjectDataset
				pNameOutput, 	// pOutputName
				TRUE, 				// pShouldClearSuperfileFirst
				FALSE, 				// pSplitEmails
				FALSE, 				// pShouldSprayZeroByteFiles
				FALSE					// pShouldSprayMultipleFilesAs1
			),
			FileServices.ClearSuperFile(filename+'_delete',TRUE)
		)
	);

END;
