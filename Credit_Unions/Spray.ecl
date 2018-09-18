import tools, _control;

export Spray(

	 string		pversion			= ''
	,string		pServerIP			= _control.IPAddress.bctlpedata10
	,string		pDirectory		= '/data_build_5_2/credit_union/data'
	,string		pFilename			= '*txt'
	,string		pGroupName		= _Constants().groupname	
	,boolean	pIsTesting		= false
	,boolean	pOverwrite		= false
	,boolean	pExistSprayed	= _Flags.ExistCurrentSprayed
	,string		pNameOutput		= _Constants().Name + ' Spray Info'	

) :=
function

	FilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFilename
	 	,0
	 	,Filenames().input.Template
	 	,[ {Filenames().input.sprayed	}	]
	 	,pGroupName
		,pversion
		,'[0-9]{8}'
		,'VARIABLE'
		,''
		,_Constants().max_record_size
	 	}
	], tools.Layout_Sprays.Info);
		
	return if(					pDirectory != ''
							and not pExistSprayed
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Constants().Name + ' ' + pversion,pNameOutput));

end;
