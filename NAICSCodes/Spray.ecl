IMPORT  _control, std, tools;

EXPORT Spray(
	 STRING		pversion			= ''
	,STRING		pServerIP			= _control.IPAddress.bctlpedata12
	,STRING		pDirectory		= '/data/temp/boneill/training' +pversion
	,STRING		pFileName			= ''	
	,STRING		pDnbDmiFileName			= ''	
	,STRING		pGroupName		= STD.System.Thorlib.Group( )	
	,BOOLEAN	pIsTesting		= FALSE
	,BOOLEAN	pOverwrite		= FALSE
	,BOOLEAN	pExistSprayed	= _Flags.ExistCurrentSprayed
	,BOOLEAN  pExistDnbDmiSprayed = _Flags.ExistCurrentDnbDmiSprayed
	,STRING		pNameOutput		= _Constants().Name + ' Spray Info'	
	,STRING		pNameDnbDmiOutput		= _Constants().Name + 'Dnb Dmi Spray Info'	
  ) := FUNCTION
	
	FilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFileName                               // FILENAME
	 	,0                                       // RECORD SIZE
	 	,Filenames(pversion).Input.NAICS.logical       // THOR FILENAME TEMPLATE
	 	,[ {Filenames().Input.NAICS.sprayed}	]        // SUPERFILE NAME
	 	,pGroupName                              // GROUPNAME
		,''                                      // FILEDATE
		,'[0-9]{8}'                              // DATE REGULAR EXPRESSION
		,'VARIABLE'                              // CAN BE 'VARIABLE', OR 'XML'
		,''                                      // SOURCE TAG IF DATA IS XML
		,_Constants().max_record_size            // MAX RECORD SIZE
	 	}
	
	], tools.Layout_Sprays.Info);
	
	DnbDmiFilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pDnbDmiFileName                         // FILENAME
	 	,0                                       // RECORD SIZE
	 	,Filenames(pversion).Input.DnbDmi.logical       // THOR FILENAME TEMPLATE
	 	,[ {Filenames().Input.DnbDmi.sprayed}	]        // SUPERFILE NAME
	 	,pGroupName                              // GROUPNAME
		,''                                      // FILEDATE
		,'[0-9]{8}'                              // DATE REGULAR EXPRESSION
		,'VARIABLE'                              // CAN BE 'VARIABLE', OR 'XML'
		,''                                      // SOURCE TAG IF DATA IS XML
		,_Constants().max_record_size            // MAX RECORD SIZE
	 	}
	
	], tools.Layout_Sprays.Info);
		
	RETURN parallel (
			      IF( pDirectory != '' AND NOT pExistDnbDmiSprayed
						,tools.fun_Spray(DnbDmiFilesToSpray,,,pOverwrite,,FALSE,pIsTesting,,_Constants().Name + ' ' + pversion,pNameDnbDmiOutput)),
	          IF( pDirectory != '' AND NOT pExistSprayed
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,FALSE,pIsTesting,,_Constants().Name + ' ' + pversion,pNameOutput))
						);

END;
														
						


