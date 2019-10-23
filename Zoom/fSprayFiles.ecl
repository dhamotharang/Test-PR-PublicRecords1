import tools, _control;

export fSprayFiles(

	 string		pServerIP		= _control.IPAddress.bctlpedata11
	,string		pDirectory	= '/data/hds_180/zoom/out'
	,string		pFilename		= 'zoom*csv'
	,string		pFilename2	= 'zoom*xml'
	,string		pversion
	,string		pGroupName	= _dataset().groupname																		
	,boolean	pIsTesting	= false
	,boolean	pOverwrite	= false
	,string		pNameOutput	= 'Zoom Spray Info'	
	,boolean	pSprayMultipleFilesAs1	= true
	,set of string1 pSprayFiles				= ['C','X']

) :=
function

	FilesToSpray1 := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFilename
	 	,0
	 	,Filenames(pversion).input.Template
	 	,[ {Filenames(pversion).input.sprayed	}	]
	 	,pGroupName
		,pversion
		,''
		,'VARIABLE'
		,''
		,_Dataset().max_record_size
	 	}
	], tools.Layout_Sprays.Info);
		
	FilesToSpray2 := DATASET([
		{pServerIP												
		,pDirectory                             
		,pFilename2                                          
		,0                                                             
		,Filenames(pversion).inputXML.Template    
		,[{Filenames(pversion).inputXML.sprayed	}]    
		,pGroupName                                                
		,pversion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		,_Dataset().max_record_size * 200
		,'~~~~~'
		,'</personData>'
		,'~~~~@@'
		}

	], tools.Layout_Sprays.Info);



	FilesToSpray := 
			if((not _Flags.ExistCurrentSprayed		or pOverwrite) and 'C' in pSprayFiles ,FilesToSpray1)
		+ if((not _Flags.ExistCurrentXMLSprayed	or pOverwrite) and 'X' in pSprayFiles	,FilesToSpray2)

		;
	return tools.fun_Spray(FilesToSpray,,,pOverwrite,,true,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput,pShouldSprayMultipleFilesAs1 := pSprayMultipleFilesAs1);

end;