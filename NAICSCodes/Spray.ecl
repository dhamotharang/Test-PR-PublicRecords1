IMPORT  _control, std, tools, NAICSCodes;

EXPORT Spray(
	 STRING		pversion			= ''
	,STRING		pServerIP			= _control.IPAddress.bctlpedata12
	,STRING		pDirectory		= '/data/temp/boneill/training' +pversion
	,STRING		pFileType			= ''	
	,STRING		pGroupName		= STD.System.Thorlib.Group( )	
	,BOOLEAN	pIsTesting		= FALSE
	,BOOLEAN	pOverwrite		= FALSE
	,BOOLEAN	pExistSprayed	= _Flags.ExistCurrentSprayed
	,STRING		pNameOutput		= NAICSCodes._Constants().Name + ' Spray Info'	
  ) := FUNCTION
	
	FilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFileType                               // FILENAME
	 	,0                                       // RECORD SIZE
	 	,Filenames(pversion).Input.logical       // THOR FILENAME TEMPLATE
	 	,[ {Filenames().Input.sprayed}	]        // SUPERFILE NAME
	 	,pGroupName                              // GROUPNAME
		,''                                      // FILEDATE
		,'[0-9]{8}'                              // DATE REGULAR EXPRESSION
		,'VARIABLE'                              // CAN BE 'VARIABLE', OR 'XML'
		,''                                      // SOURCE TAG IF DATA IS XML
		,NAICSCodes._Constants().max_record_size            // MAX RECORD SIZE
	 	}
	
	], tools.Layout_Sprays.Info);
		
	RETURN IF( pDirectory != '' AND NOT pExistSprayed
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,FALSE,pIsTesting,,NAICSCodes._Constants().Name + ' ' + pversion,pNameOutput));

END;
														
						


