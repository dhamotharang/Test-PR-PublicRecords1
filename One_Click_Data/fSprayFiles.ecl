import  _control, tools;

export fSprayFiles(

	 string			pversion
	,string			pDirectory					= '/data/prod_data_build_10/production_data/business_headers/one_click_data/data/'
	,string			pServerIP						= _control.IPAddress.bctlpedata11
	,string			pFilename						= '*csv'
	,string			pGroupName					= _dataset().groupname																		
	,boolean		pIsTesting					= false
	,boolean		pOverwrite					= false		
	,unsigned8	pMaxRecordSize			= _Dataset().max_record_size
	,STRING		  pNameOutput		      = _Dataset().Name + ' Spray Info'
) :=
function

	FilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFileName                               // FILENAME
	 	,0                                       // RECORD SIZE
	 	,Filenames(pversion[1..8]).Input.Logical       // THOR FILENAME TEMPLATE
	 	,[ {Filenames().Input.sprayed}	]        // SUPERFILE NAME
	 	,pGroupName                              // GROUPNAME
		,''                                      // FILEDATE
		,'[0-9]{8}'                              // DATE REGULAR EXPRESSION
		,'VARIABLE'                              // CAN BE 'VARIABLE', OR 'XML'
		,''                                      // SOURCE TAG IF DATA IS XML
		,pMaxRecordSize                          // MAX RECORD SIZE
		,'|' 																		 //	CSV SEPARATOR
		,'\\n,\\r\\n,\\n\\r'                     // TERMINATOR
		}                        
	
	], tools.Layout_Sprays.Info);
		
	return tools.fun_Spray(FilesToSpray,,,pOverwrite,,FALSE,pIsTesting,,pGroupName+' '+pversion,pNameOutput,,,,TRUE);
	
end;
