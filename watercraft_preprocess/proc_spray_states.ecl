/*Note - Spray format command:
Watercraft_preprocess.proc_spray_states(Version, FolderDate, InfolinkQtr);
Watercraft_preprocess.proc_spray_states('20150107','14q2','Q2');*/

IMPORT Watercraft_preprocess, tools, _control, std;

  DaliIp           := std.system.Thorlib.DaliServer();
  GroupName 			 := map(//DaliIp = '10.241.3.242:7070'  => 'thor5_241_10a', // Dataland 1 
                          DaliIp = '10.241.12.201:7070' => 'thor50_dev02', // Dataland 2 
                          DaliIp = '10.173.44.105:7070' => 'thor400_44',   // Boca Production   
                          'thor400_44');                              

EXPORT proc_spray_states(
	STRING		pVersionDate		=	''
	,STRING		pFolderDate			=	''
	,STRING		pInfolinkQtr		=	''
	,STRING		pServerIP				=	if ( _Control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12 ,  _control.IPAddress.bctlpedata11 )
	,STRING		pDirectory			= '/data/super_credit/watercraft/infolink/data/'
	,STRING		pGroupName			=	GroupName															
	,BOOLEAN	pIsTesting			=	FALSE
	,BOOLEAN	pOverwrite			=	TRUE
	,STRING		pNameOutput			=	Watercraft_preprocess._Constants().Name + ' Spray Info'
) :=
function

	FilesToSpray := DATASET([
		//ALASKA
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'AK*'+pInfolinkQtr+'.txt' 							// directory_filter
			,1607 																		// record_size
			,'~thor_data400::in::watercraft_ak_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_ak'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},	
		//ALABAMA
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'AL*'+pInfolinkQtr+'.txt' 							// directory_filter
			,613 																		// record_size
			,'~thor_data400::in::watercraft_al_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_al'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//ARKANSAS
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'AR*'+pInfolinkQtr+'.txt' 							// directory_filter
			,650 																		// record_size
			,'~thor_data400::in::watercraft_ar_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_ar'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//ARIZONA
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'AZ*'+pInfolinkQtr+'.txt' 							// directory_filter
			,558 																		// record_size
			,'~thor_data400::in::watercraft_az_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_az'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//COAST GUARD
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'CG*'+pInfolinkQtr+'.txt' 							// directory_filter
			,2443 																		// record_size
			,'~thor_data400::in::watercraft_cg_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_cg'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//CONNETICUT
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'CT*'+pInfolinkQtr+'.txt' 							// directory_filter
			,2199 																		// record_size
			,'~thor_data400::in::watercraft_ct_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_ct'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//FLORIDA
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'FL*'+pInfolinkQtr+'.txt' 							// directory_filter
			,2456 																	// record_size
			,'~thor_data400::in::watercraft_fl_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_fl'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//GEORGIA
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'GA*'+pInfolinkQtr+'.txt' 							// directory_filter
			,611 																		// record_size
			,'~thor_data400::in::watercraft_ga_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_ga'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//IOWA
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'IA*'+pInfolinkQtr+'.txt' 							// directory_filter
			,766 																		// record_size
			,'~thor_data400::in::watercraft_ia_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_ia'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//KANSAS
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'KS*'+pInfolinkQtr+'.txt' 							// directory_filter
			,570 																		// record_size
			,'~thor_data400::in::watercraft_ks_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_ks'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//KENTUCKY
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'KY*'+pInfolinkQtr+'.txt' 							// directory_filter
			,582 																		// record_size
			,'~thor_data400::in::watercraft_ky_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_ky'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//MASSACHUSETTES
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'MA*'+pInfolinkQtr+'.txt' 							// directory_filter
			,782 																		// record_size
			,'~thor_data400::in::watercraft_ma_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_ma'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//MAINE
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'ME*'+pInfolinkQtr+'.txt' 							// directory_filter
			,980 																		// record_size
			,'~thor_data400::in::watercraft_me_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_me'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//MICHIGAN
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'MI*'+pInfolinkQtr+'.txt' 							// directory_filter
			,563 																		// record_size
			,'~thor_data400::in::watercraft_mi_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_mi'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//MISSOURI
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'MO*'+pInfolinkQtr+'.txt' 							// directory_filter
			,798 																		// record_size
			,'~thor_data400::in::watercraft_mo_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_mo'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//MISSISSIPPI
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'MS*'+pInfolinkQtr+'.txt' 							// directory_filter
			,566 																		// record_size DF-19984 Layout change, record length change from 584 to 566
			,'~thor_data400::in::watercraft_ms_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_ms'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//NORTH DAKOTA
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'ND*'+pInfolinkQtr+'.txt' 							// directory_filter
			,566 																		// record_size
			,'~thor_data400::in::watercraft_nd_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_nd'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//NEW ENGLAND
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'NE*'+pInfolinkQtr+'.txt' 							// directory_filter
			,706 																		// record_size
			,'~thor_data400::in::watercraft_ne_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_ne'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//NEW MEXICO
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'NM*'+pInfolinkQtr+'.txt' 							// directory_filter
			,1087 																	// record_size
			,'~thor_data400::in::watercraft_nm_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_nm'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//OHIO
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'OH*'+pInfolinkQtr+'.txt' 							// directory_filter
			,559 																		// record_size
			,'~thor_data400::in::watercraft_oh_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_oh'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//OREGON
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'OR*'+pInfolinkQtr+'.txt' 							// directory_filter
			,762 																		// record_size
			,'~thor_data400::in::watercraft_or_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_or'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//TEXAS
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'TX*'+pInfolinkQtr+'.txt' 							// directory_filter
			,2375 																	// record_size
			,'~thor_data400::in::watercraft_tx_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_tx'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//VIRGINIA
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'VA*'+pInfolinkQtr+'.txt' 							// directory_filter
			,754 																		// record_size
			,'~thor_data400::in::watercraft_va_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_va'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//WASHINGTON
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'WA*'+pInfolinkQtr+'.txt' 							// directory_filter
			,904 																		// record_size
			,'~thor_data400::in::watercraft_wa_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_wa'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//WISCONSIN
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'WI*'+pInfolinkQtr+'.txt' 							// directory_filter
			,808 																		// record_size
			,'~thor_data400::in::watercraft_wi_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_wi'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		},
		//WYOMING
		{
			pServerIP 															// SourceIP
			,pDirectory + pFolderDate 							// SourceDirectory
			,'WY*'+pInfolinkQtr+'.txt' 							// directory_filter
			,1116																		// record_size
			,'~thor_data400::in::watercraft_wy_'+pFolderDate+'_raw' // Thor_filename_template
			,[ {'~thor_data400::in::watercraft_raw_wy'}	]	// dSuperfilenames
			,pGroupName 														// fun_Groupname
			,pVersionDate 													// FileDate
			,'[0-9]{8}' 														// date_regex
			,'FIXED' 																// file_type
			,'' 																		// sourceRowTagXML
			,Watercraft_preprocess._Constants().max_record_size			 			// sourceMaxRecordSize
			,'' 																		// sourceCsvSeparate
			,'' 																		// sourceCsvTerminate
			,'' 																		// sourceCsvQuote
			,FALSE 																	// compress
			,pOverwrite 														// shouldoverwrite
			,FALSE 																	// ShouldSprayZeroByteFiles
			,FALSE  																// ShouldSprayMultipleFilesAs1
		}
	], tools.Layout_Sprays.Info);
	
	
RETURN IF(pDirectory + pFolderDate != '',
					tools.fun_Spray
					( 
					FilesToSpray	// pSprayInformation
					, 						// pSprayInfoSuperfile
					,							// pSprayInfoLogicalfile
					,pOverwrite 	// pOverwrite
					,							// pReplicate
					,TRUE					// pAddCounter
					,pIsTesting		// pIsTesting
					,'shannon.skumanich@lexisnexis.com; sudhir.kasavajjala@lexisnexis.com'				// pEmailNotificationList
					,'Watercraft states spray' + ' ' + pVersionDate	// pEmailSubjectDataset
					,pNameOutput 	// pOutputName
					,TRUE 				// pShouldClearSuperfileFirst
					,FALSE 				// pSplitEmails
					,FALSE 				// pShouldSprayZeroByteFiles
					,FALSE				// pShouldSprayMultipleFilesAs1
					)
				);
END;