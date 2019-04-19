﻿IMPORT  _control, std, tools;

EXPORT Spray(
	 STRING		pversion			= ''
	,STRING		pServerIP			= 'uspr-edata11.risk.regn.net'
	,STRING		pDirectory		= '/data/business/databridge/' + pversion[1..8] 
	,STRING		pFileType			= 'LN_*_database.txt'
	,STRING		pGroupName		= STD.System.Thorlib.Group( )
	,BOOLEAN	pIsTesting		= FALSE
	,BOOLEAN	pOverwrite		= FALSE
	,BOOLEAN	pExistSprayed	= _Flags.ExistCurrentSprayed
	,STRING		pNameOutput		= _Constants().Name + ' Spray Info'	
  ) := FUNCTION
	
	FilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFileType                               // FILENAME
	 	,0                                       // RECORD SIZE
	 	,Filenames(pversion).Input.Logical       // THOR FILENAME TEMPLATE
	 	,[ {Filenames().Input.sprayed}	]        // SUPERFILE NAME
	 	,pGroupName                              // GROUPNAME
		,''                                      // FILEDATE
		,'[0-9]{8}'                              // DATE REGULAR EXPRESSION
		,'VARIABLE'                              // CAN BE 'VARIABLE', OR 'XML'
		,''                                      // SOURCE TAG IF DATA IS XML
		,_Constants().max_record_size            // MAX RECORD SIZE
		,'|' 																		 //	CSV SEPARATOR
		,'\\n,\\r\\n,\\n\\r'                     // TERMINATOR
		}                        
	
	], tools.Layout_Sprays.Info);
		
	RETURN IF( pDirectory != '' AND NOT pExistSprayed
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,FALSE,pIsTesting,,_Constants().Name+' '+pversion,pNameOutput,,,,TRUE) );

END;