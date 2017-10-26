IMPORT versioncontrol, tools, _control, OKC_Student_List;
EXPORT proc_spray_files := MODULE

	//Spray college info reference table provided by Nicole
	EXPORT fSprayOKCFullStudentListCollegeInfo( 
		STRING		pVersionDate		=	'',
		STRING		pServerIP				= Constants().serverIP,
		STRING		pDirectory			= Constants().Directory,
		STRING		pGroupName			=	_Dataset().groupname,
		BOOLEAN		pIsTesting			=	FALSE,
		BOOLEAN		pOverwrite			=	TRUE,
		STRING		pNameOutput			=	'Spray OKC_Full_Student_List College Info'
	) :=
	FUNCTION
		FilesToSpray := DATASET([

				//	Copied from SBFE
				{
					pServerIP, 																//	SourceIP
					pDirectory, 															//	SourceDirectory
					//pFilename,																//	directory_filter
					'*.txt',
					0, 																				//	record_size
					'~thor_data400::in::okc_student_list::college_info_'+pVersionDate,	//	Thor_filename_template
					[ {'~thor_data400::in::okc_student_list::college_info'}	],		//	dSuperfilenames
					pGroupName, 															//	fun_Groupname
					pVersionDate, 														//	FileDate
					'[0-9]{8}', 															//	date_regex
					'VARIABLE', 															//	file_type
					'', 																			//	sourceRowTagXML
					tools.Constants('OKC_Full_Student_List').max_record_size,	//	sourceMaxRecordSize
					'\\t', 																		//	sourceCsvSeparate
					'\\n,\\r\\n', 														//	sourceCsvTerminate
					'', 																			//	sourceCsvQuote
					TRUE, 																		//	compress
					pOverwrite, 															//	shouldoverwrite
					FALSE, 																		//	ShouldSprayZeroByteFiles
					FALSE  																		//	ShouldSprayMultipleFilesAs1
				}
				], VersionControl.Layout_Sprays.Info);
				

				
				RETURN IF(	pDirectory != '',
				SEQUENTIAL
				(
					VersionControl.fSprayInputFiles
					( 
						FilesToSpray,						//	pSprayInformation
						, 											//	pSprayInfoSuperfile
						,												//	pSprayInfoLogicalfile
						pOverwrite, 						//	pOverwrite
						,												//	pReplicate
						TRUE,										//	pAddCounter
						pIsTesting,							//	pIsTesting
						'cathy.tio@lexisnexisrisk.com',												//	pEmailNotificationList
						'OKC_Full_Student_List ' + pVersionDate,	//	pEmailSubjectDataset
						pNameOutput, 						//	pOutputName
						TRUE, 									//	pShouldClearSuperfileFirst
						FALSE, 									//	pSplitEmails
						FALSE, 									//	pShouldSprayZeroByteFiles
						FALSE										//	pShouldSprayMultipleFilesAs1
					)
					
				)
			);

	END;

	//Spray college major mapping table from OKC to ASL, provided by Margaret Product Manager
	EXPORT fSprayOKCStudentListCollegeMajor( 
		STRING		pVersionDate		=	'',
		STRING		pServerIP				= 'bctlpedata12.risk.regn.net',
		STRING		pDirectory			= '/data/temp/logs/',
		STRING		pFilename				= 'ds_college_major_mapped.csv',
		STRING		pGroupName			=	'thor50_dev02',
		BOOLEAN		pIsTesting			=	FALSE,
		BOOLEAN		pOverwrite			=	TRUE,
		STRING		pNameOutput			=	'Spray OKC_Student_List College Major Mapping Table'
	) :=
	FUNCTION
		FilesToSpray := DATASET([

				//	Copied from SBFE
				{
					pServerIP, 																//	SourceIP
					pDirectory, 															//	SourceDirectory
					pFilename,																//	directory_filter
					// 'MajorList OKC majors mapped_old_major_codes_20170719.csv',
					0, 																				//	record_size
					'~thor_data400::in::okc_student_list::college_major_mapping_'+pVersionDate,	//	Thor_filename_template
					[ {'~thor_data400::in::okc_student_list::college_major_mapping'}	],		//	dSuperfilenames
					pGroupName, 															//	fun_Groupname
					pVersionDate, 														//	FileDate
					'[0-9]{8}', 															//	date_regex
					'VARIABLE', 															//	file_type
					'', 																			//	sourceRowTagXML
					tools.Constants('OKC_Student_List_College_Major').max_record_size,	//	sourceMaxRecordSize
					',', 																		//	sourceCsvSeparate
					'\\n,\\r\\n', 														//	sourceCsvTerminate
					'', 																			//	sourceCsvQuote
					TRUE, 																		//	compress
					pOverwrite, 															//	shouldoverwrite
					FALSE, 																		//	ShouldSprayZeroByteFiles
					FALSE  																		//	ShouldSprayMultipleFilesAs1
				}
				], VersionControl.Layout_Sprays.Info);
				

				
				RETURN IF(	pDirectory != '',
				SEQUENTIAL
				(
					VersionControl.fSprayInputFiles
					( 
						FilesToSpray,						//	pSprayInformation
						, 											//	pSprayInfoSuperfile
						,												//	pSprayInfoLogicalfile
						pOverwrite, 						//	pOverwrite
						,												//	pReplicate
						TRUE,										//	pAddCounter
						pIsTesting,							//	pIsTesting
						'cathy.tio@lexisnexisrisk.com',												//	pEmailNotificationList
						'OKC_Student_List College Major Mapping Table' + pVersionDate,	//	pEmailSubjectDataset
						pNameOutput, 						//	pOutputName
						TRUE, 									//	pShouldClearSuperfileFirst
						FALSE, 									//	pSplitEmails
						FALSE, 									//	pShouldSprayZeroByteFiles
						FALSE										//	pShouldSprayMultipleFilesAs1
					)
					
				)
			);

	END;
	
END;	