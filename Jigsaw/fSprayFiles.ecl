import tools, _control;

export fSprayFiles(

	 string		pversion
	,string		pDirectory	= '/load02/jigsaw/'
	,string		pServerIP		= _control.IPAddress.edata14a
	,string		pFilename		= '*live*csv'
	,string		pFilename2	= '*dead*csv'
	,string		pFilename3	= '*deleted*csv'
	,string		pGroupName	= _dataset().groupname																		
	,boolean	pIsTesting	= false
	,boolean	pOverwrite	= false
	,string		pNameOutput	= _Dataset().Name + ' Spray Info'	

) :=
function

	FilesToSpray := DATASET([

	 	{pServerIP
	 	,pDirectory
	 	,pFilename
	 	,0
	 	,Filenames(pversion).input.Live.Template
	 	,[ {Filenames(pversion).input.Live.sprayed	}	]
	 	,pGroupName
		,pversion
		,''
		,'VARIABLE'
		,''
		,_Dataset().max_record_size
	 	}
		
	 	,{pServerIP
	 	,pDirectory
	 	,pFilename2
	 	,0
	 	,Filenames(pversion).input.Dead.Template
	 	,[ {Filenames(pversion).input.Dead.sprayed	}	]
	 	,pGroupName
		,pversion
		,''
		,'VARIABLE'
		,''
		,_Dataset().max_record_size
	 	}

	 	,{pServerIP
	 	,pDirectory
	 	,pFilename3
	 	,0
	 	,Filenames(pversion).input.deletedremove.Template
	 	,[ {Filenames(pversion).input.deletedremove.sprayed	}	]
	 	,pGroupName
		,pversion
		,''
		,'VARIABLE'
		,''
		,_Dataset().max_record_size
	 	}

	], tools.Layout_Sprays.Info);

	return tools.fun_Spray(FilesToSpray,,,pOverwrite,,true,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput);

end;
