IMPORT tools, _control;

EXPORT fSprayStateFiles(
	STRING		pVersionDate		=	'',
	BOOLEAN		pPromote				= FALSE,
	STRING		pServerIP				= IF(_control.thisenvironment.name='Dataland',
																_control.IPAddress.bctlpedata12,
																_control.IPAddress.bctlpedata10),
  STRING		pDirectory			= IF(_control.thisenvironment.name='Dataland',
																'/data/hds_4/death_master/in/state_deaths/_',
																'/data/hds_4/death_master/in/state_deaths/'),
	STRING		pGroupName			=	_Constants().groupname,															
	BOOLEAN		pIsTesting			=	FALSE,
	BOOLEAN		pOverwrite			=	TRUE,
	STRING		pNameOutput			=	_Constants().Name + ' Spray Info'
) :=
function

	FilesToSpray := DATASET([

		//	CALIFORNIA
		{
			pServerIP, 															// SourceIP
			pDirectory+'ca', 												// SourceDirectory
			'*csv',																	// directory_filter
			0, 																			// record_size
			Filenames('CA').input.Template, 				// Thor_filename_template
			[ {Filenames('CA').input.sprayed	}	], 	// dSuperfilenames
			pGroupName, 														// fun_Groupname
			pVersionDate, 													// FileDate
			'[0-9]{8}', 														// date_regex
			'VARIABLE', 														// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size, 					// sourceMaxRecordSize
			',', 																		// sourceCsvSeparate
			'\\n,\\r\\n', 													// sourceCsvTerminate
			'"', 																		// sourceCsvQuote
			FALSE, 																	// compress
			pOverwrite, 														// shouldoverwrite
			FALSE, 																	// ShouldSprayZeroByteFiles
			FALSE  																	// ShouldSprayMultipleFilesAs1
		},
		//	CONNECTICUT
		{
			pServerIP, 															// SourceIP
			pDirectory+'ct', 												// SourceDirectory
			'*csv', 																// directory_filter
			0, 																			// record_size
			Filenames('CT').input.Template, 				// Thor_filename_template
			[ {Filenames('CT').input.sprayed	}	], 	// dSuperfilenames
			pGroupName, 														// fun_Groupname
			pVersionDate, 													// FileDate
			'[0-9]{8}', 														// date_regex
			'VARIABLE', 														// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size, 					// sourceMaxRecordSize
			',', 																		// sourceCsvSeparate
			'\\n,\\r\\n', 													// sourceCsvTerminate
			'"', 																		// sourceCsvQuote
			FALSE, 																	// compress
			pOverwrite, 														// shouldoverwrite
			FALSE, 																	// ShouldSprayZeroByteFiles
			FALSE  																	// ShouldSprayMultipleFilesAs1
		},
		//	FLORIDA
		{
			pServerIP, 															// SourceIP
			pDirectory+'fl', 												// SourceDirectory
			'*', 																		// directory_filter
			1208, 																	// record_size
			Filenames('FL').input.Template, 				// Thor_filename_template
			[ {Filenames('FL').input.sprayed	}	],	// dSuperfilenames
			pGroupName, 														// fun_Groupname
			pVersionDate, 													// FileDate
			'[0-9]{8}', 														// date_regex
			'FIXED', 																// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size,			 			// sourceMaxRecordSize
			'', 																		// sourceCsvSeparate
			'', 																		// sourceCsvTerminate
			'', 																		// sourceCsvQuote
			FALSE, 																	// compress
			pOverwrite, 														// shouldoverwrite
			FALSE, 																	// ShouldSprayZeroByteFiles
			FALSE  																	// ShouldSprayMultipleFilesAs1
		},
		//	GEORGIA
		{
			pServerIP, 															// SourceIP
			pDirectory+'ga', 												// SourceDirectory
			'*',																		// directory_filter
			0, 																			// record_size
			Filenames('GA').input.Template, 				// Thor_filename_template
			[ {Filenames('GA').input.sprayed	}	],	// dSuperfilenames
			pGroupName, 														// fun_Groupname
			pVersionDate, 													// FileDate
			'[0-9]{8}', 														// date_regex
			'VARIABLE', 														// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size,			 			// sourceMaxRecordSize
			'\t', 																	// sourceCsvSeparate
			'\\n,\\r\\n', 													// sourceCsvTerminate
			'"', 																		// sourceCsvQuote
			FALSE, 																	// compress
			pOverwrite, 														// shouldoverwrite
			FALSE, 																	// ShouldSprayZeroByteFiles
			FALSE  																	// ShouldSprayMultipleFilesAs1
		},
		//	KENTUCKY
		{
			pServerIP, 															// SourceIP
			pDirectory+'ky', 												// SourceDirectory
			'*csv', 																// directory_filter
			0, 																			// record_size
			Filenames('KY').input.Template, 				// Thor_filename_template
			[ {Filenames('KY').input.sprayed	}	],	// dSuperfilenames
			pGroupName, 														// fun_Groupname
			pVersionDate, 													// FileDate
			'[0-9]{8}', 														// date_regex
			'VARIABLE', 														// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size,			 			// sourceMaxRecordSize
			',', 																		// sourceCsvSeparate
			'\\n,\\r\\n', 													// sourceCsvTerminate
			'', 																		// sourceCsvQuote
			FALSE, 																	// compress
			pOverwrite, 														// shouldoverwrite
			FALSE, 																	// ShouldSprayZeroByteFiles
			FALSE  																	// ShouldSprayMultipleFilesAs1
		},
		//	MASSACHUSETTS
		{
			pServerIP, 															// SourceIP
			pDirectory+'ma', 												// SourceDirectory
			'*', 																		// directory_filter
			0, 																			// record_size
			Filenames('MA').input.Template, 				// Thor_filename_template
			[ {Filenames('MA').input.sprayed	}	],	// dSuperfilenames
			pGroupName, 														// fun_Groupname
			pVersionDate,														// FileDate
			'[0-9]{8}', 														// date_regex
			'VARIABLE', 														// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size,			 			// sourceMaxRecordSize
			'|', 																		// sourceCsvSeparate
			'\\n,\\r\\n', 													// sourceCsvTerminate
			'"', 																		// sourceCsvQuote
			FALSE, 																	// compress
			pOverwrite, 														// shouldoverwrite
			FALSE, 																	// ShouldSprayZeroByteFiles
			FALSE  																	// ShouldSprayMultipleFilesAs1
		},
		//	MICHIGAN
		{
			pServerIP, 															// SourceIP
			pDirectory+'mi', 												// SourceDirectory
			'*txt', 																// directory_filter
			145, 																		// record_size
			Filenames('MI').input.Template, 				// Thor_filename_template
			[ {Filenames('MI').input.sprayed	}	],	// dSuperfilenames
			pGroupName, 														// fun_Groupname
			pVersionDate, 													// FileDate
			'[0-9]{8}', 														// date_regex
			'FIXED', 																// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size,			 			// sourceMaxRecordSize
			'', 																		// sourceCsvSeparate
			'', 																		// sourceCsvTerminate
			'', 																		// sourceCsvQuote
			FALSE, 																	// compress
			pOverwrite, 														// shouldoverwrite
			FALSE, 																	// ShouldSprayZeroByteFiles
			FALSE  																	// ShouldSprayMultipleFilesAs1
		},
		//	MINNESOTA
		{
			pServerIP, 															// SourceIP
			pDirectory+'mn', 												// SourceDirectory
			'*', 																		// directory_filter
			802, 																		// record_size
			Filenames('MN').input.Template, 				// Thor_filename_template
			[ {Filenames('MN').input.sprayed	}	],	// dSuperfilenames
			pGroupName, 														// fun_Groupname
			pVersionDate, 													// FileDate
			'[0-9]{8}', 														// date_regex
			'FIXED', 																// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size,			 			// sourceMaxRecordSize
			'', 																		// sourceCsvSeparate
			'', 																		// sourceCsvTerminate
			'', 																		// sourceCsvQuote
			FALSE, 																	// compress
			pOverwrite, 														// shouldoverwrite
			FALSE, 																	// ShouldSprayZeroByteFiles
			FALSE  																	// ShouldSprayMultipleFilesAs1
		},
		//	MONTANA
		{
			pServerIP, 															// SourceIP
			pDirectory+'mt', 												// SourceDirectory
			'*TXT', 																// directory_filter
			0, 																			// record_size
			Filenames('MT').input.Template, 				// Thor_filename_template
			[ {Filenames('MT').input.sprayed	}	],	// dSuperfilenames
			pGroupName, 														// fun_Groupname
			pVersionDate,														// FileDate
			'[0-9]{8}', 														// date_regex
			'VARIABLE', 														// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size,			 			// sourceMaxRecordSize
			'|', 																		// sourceCsvSeparate
			'\\n,\\r\\n', 													// sourceCsvTerminate
			'"', 																		// sourceCsvQuote
			FALSE, 																	// compress
			pOverwrite, 														// shouldoverwrite
			FALSE, 																	// ShouldSprayZeroByteFiles
			FALSE  																	// ShouldSprayMultipleFilesAs1
		},
		//	NEVADA
		{
			pServerIP, 															// SourceIP
			pDirectory+'nv', 												// SourceDirectory
			'*csv', 																// directory_filter
			0, 																			// record_size
			Filenames('NV').input.Template, 				// Thor_filename_template
			[ {Filenames('NV').input.sprayed	}	], 	// dSuperfilenames		
			pGroupName, 														// fun_Groupname
			pVersionDate, 													// FileDate
			'[0-9]{8}', 														// date_regex
			'VARIABLE', 														// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size, 					// sourceMaxRecordSize
			',', 																		// sourceCsvSeparate
			'\\n,\\r\\n', 													// sourceCsvTerminate
			'"', 																		// sourceCsvQuote
			FALSE, 																	// compress
			pOverwrite, 														// shouldoverwrite
			FALSE, 																	// ShouldSprayZeroByteFiles
			FALSE  																	// ShouldSprayMultipleFilesAs1
		},
		//	NORTH CAROLINA
		{
			pServerIP, 															// SourceIP
			pDirectory+'nc', 												// SourceDirectory
			'*', 																		// directory_filter
			1452, 																	// record_size
			Filenames('NC').input.Template, 				// Thor_filename_template
			[ {Filenames('NC').input.sprayed	}	],	// dSuperfilenames
			pGroupName, 														// fun_Groupname
			pVersionDate, 													// FileDate
			'[0-9]{8}', 														// date_regex
			'FIXED', 																// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size,			 			// sourceMaxRecordSize
			'', 																		// sourceCsvSeparate
			'', 																		// sourceCsvTerminate
			'', 																		// sourceCsvQuote
			FALSE, 																	// compress
			pOverwrite, 														// shouldoverwrite
			FALSE, 																	// ShouldSprayZeroByteFiles
			FALSE  																	// ShouldSprayMultipleFilesAs1
		},
		//	OHIO
		{
			pServerIP, 															// SourceIP
			pDirectory+'oh', 												// SourceDirectory
			'*csv', 																// directory_filter
			0, 																			// record_size
			Filenames('OH').input.Template, 				// Thor_filename_template
			[ {Filenames('OH').input.sprayed	}	], 	// dSuperfilenames
			pGroupName, 														// fun_Groupname
			pVersionDate, 													// FileDate
			'[0-9]{8}', 														// date_regex
			'VARIABLE', 														// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size, 					// sourceMaxRecordSize
			',', 																		// sourceCsvSeparate
			'\\n,\\r\\n', 													// sourceCsvTerminate
			'"', 																		// sourceCsvQuote
			FALSE, 																	// compress
			pOverwrite, 														// shouldoverwrite
			FALSE, 																	// ShouldSprayZeroByteFiles
			FALSE  																	// ShouldSprayMultipleFilesAs1
		},
		//	VIRGINIA
		{
			pServerIP, 															// SourceIP
			pDirectory+'va', 												// SourceDirectory
			'*txt', 																// directory_filter
			0, 																			// record_size
			Filenames('VA').input.Template, 				// Thor_filename_template
			[ {Filenames('VA').input.sprayed	}	], 	// dSuperfilenames
			pGroupName, 														// fun_Groupname
			pVersionDate, 													// FileDate
			'[0-9]{8}', 														// date_regex
			'VARIABLE', 														// file_type
			'', 																		// sourceRowTagXML
			_Constants().max_record_size, 					// sourceMaxRecordSize
			'\\t', 																	// sourceCsvSeparate
			'\\n,\\r\\n', 													// sourceCsvTerminate
			'"', 																		// sourceCsvQuote
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
				FileServices.AddSuperFile(Filenames('CA').input.sprayed+'_history',Filenames('CA').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames('CA').input.sprayed),
				FileServices.AddSuperFile(Filenames('CT').input.sprayed+'_history',Filenames('CT').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames('CT').input.sprayed),
				FileServices.AddSuperFile(Filenames('FL').input.sprayed+'_history',Filenames('FL').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames('FL').input.sprayed),
				FileServices.AddSuperFile(Filenames('GA').input.sprayed+'_history',Filenames('GA').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames('GA').input.sprayed),
				FileServices.AddSuperFile(Filenames('KY').input.sprayed+'_history',Filenames('KY').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames('KY').input.sprayed),
				FileServices.AddSuperFile(Filenames('MA').input.sprayed+'_history',Filenames('MA').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames('MA').input.sprayed),
				FileServices.AddSuperFile(Filenames('MI').input.sprayed+'_history',Filenames('MI').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames('MI').input.sprayed),
				FileServices.AddSuperFile(Filenames('MN').input.sprayed+'_history',Filenames('MN').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames('MN').input.sprayed),
				FileServices.AddSuperFile(Filenames('MT').input.sprayed+'_history',Filenames('MT').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames('MT').input.sprayed),
				FileServices.AddSuperFile(Filenames('NV').input.sprayed+'_history',Filenames('NV').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames('NV').input.sprayed),
				FileServices.AddSuperFile(Filenames('NC').input.sprayed+'_history',Filenames('NC').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames('NC').input.sprayed),
				FileServices.AddSuperFile(Filenames('OH').input.sprayed+'_history',Filenames('OH').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames('OH').input.sprayed),
				FileServices.AddSuperFile(Filenames('VA').input.sprayed+'_history',Filenames('VA').input.sprayed,,TRUE),
				FileServices.ClearSuperFile(Death_Master.Filenames('VA').input.sprayed),
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
