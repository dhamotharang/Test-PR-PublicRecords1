IMPORT tools, _control;

EXPORT SprayFiles(
	 STRING		pversion			= ''
	,STRING		pServerIP			= _control.IPAddress.bctlpedata12
	,STRING		pDirectory		= '/data/hds_180/qa_data/data/' + pversion[1..8]
	,STRING		pFileType			= '*.txt'
	,STRING		pGroupName		= tools.fun_Groupname()																		
	,BOOLEAN	pIsTesting		= TRUE
	,BOOLEAN	pOverwrite		= FALSE
	,BOOLEAN	pExistSprayed	= _Flags.ExistCurrentSprayed
	,STRING		pNameOutput		= _Constants().Name + ' Spray Info'	
  ) := FUNCTION
	
	FilesToSpray := DATASET([

		// Addresses File -----------------------------------------------------//
		{pServerIP
	 	,pDirectory
	 	,'*Address' + pFileType                  // FILENAME
	 	,0                                       // RECORD SIZE
	 	,Filenames(pversion).InputAddr.logical   // THOR FILENAME TEMPLATE
	 	,[ {Filenames().InputAddr.sprayed}	]    // SUPERFILE NAME
	 	,pGroupName                              // GROUPNAME
		,''                                      // FILEDATE
		,'[0-9]{8}'                              // DATE REGULAR EXPRESSION
		,'VARIABLE'                              // CAN BE 'VARIABLE', OR 'XML'
		,''                                      // SOURCE TAG IF DATA IS XML
		,_Constants().max_record_size            // MAX RECORD SIZE
	 	},
		// Transactions File -----------------------------------------------------//
		{pServerIP
	 	,pDirectory
	 	,'*Trans' + pFileType                    // FILENAME
	 	,0                                       // RECORD SIZE
	 	,Filenames(pversion).InputTrans.logical  // THOR FILENAME TEMPLATE
	 	,[ {Filenames().InputTrans.sprayed}	]    // SUPERFILE NAME
	 	,pGroupName                              // GROUPNAME
		,''                                      // FILEDATE
		,'[0-9]{8}'                              // DATE REGULAR EXPRESSION
		,'VARIABLE'                              // CAN BE 'VARIABLE', OR 'XML'
		,''                                      // SOURCE TAG IF DATA IS XML
		,_Constants().max_record_size            // MAX RECORD SIZE
	 	}
	
	], tools.Layout_Sprays.Info);
		
	RETURN IF( pDirectory != '' AND NOT pExistSprayed
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,FALSE,pIsTesting,,_Constants().Name + ' ' + pversion,pNameOutput));

END;
