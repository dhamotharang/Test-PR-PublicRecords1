import tools, _control;

export fSprayFiles(

	 string		pServerIP		= _control.IPAddress.edata14a
	,string		pDirectory	= '/load01/spoke/'
	,string		pFilename		= '*tsv'
	,string		pversion
	,string		pDelimiter	= '\t'
	,string		pGroupName	= _dataset().groupname																		
	,boolean	pIsTesting	= false
	,boolean	pOverwrite	= false																															

) :=
function

	FilesToSpray := DATASET([

	 	{pServerIP
	 	,pDirectory
	 	,pFilename
	 	,0
	 	,Filenames(pversion).input.Template
	 	,[ {Filenames(pversion).input.sprayed	}
			,{Filenames(pversion).input.root		}
		]
	 	,pGroupName
		,pversion
		,''
		,'VARIABLE'
		,''
		,_Dataset().max_record_size
		,pDelimiter
		,'\r\n'
		,'~~~'
	 	}

	], tools.Layout_Sprays.Info);

	return tools.fun_Spray(FilesToSpray,,,pOverwrite,,true,pIsTesting,,_Dataset().Name + ' ' + pversion);

end;
