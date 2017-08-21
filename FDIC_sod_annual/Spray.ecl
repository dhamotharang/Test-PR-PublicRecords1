import tools, _control;

export Spray(

	 string		pversion			= ''
	,string		pServerIP			= _control.IPAddress.edata10
	,string		pDirectory		= '/prod_data_build_13/eval_data/fdic/'
	,string		pFilename			= '*csv'
	,string		pGroupName		= _Constants().groupname																		
	,boolean	pIsTesting		= false
	,boolean	pOverwrite		= true
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
		,''
		,'[0-9]{8}'
		,'VARIABLE'
		,''
		,_Constants().max_record_size
	 	}
	], tools.Layout_Sprays.Info);
		
	return if(					pDirectory != ''
							and not pExistSprayed
						,tools.fun_Spray(FilesToSpray,,,true,false,,pIsTesting,,_Constants().Name + ' ' + pversion,pNameOutput));

end;
