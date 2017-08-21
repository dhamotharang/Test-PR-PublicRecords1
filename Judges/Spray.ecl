import tools, _control;
export Spray(
	 string		pversion			= ''
	,string		pServerIP			= _control.IPAddress.edata10
	,string		pDirectory		= '/prod_data_build_13/eval_data/judge_data/'
	,string		pFilename			= '*txt'
	,string		pGroupName		= _dataset().groupname																		
	,boolean	pIsTesting		= false
	,boolean	pOverwrite		= false
	,boolean	pExistSprayed	= _Flags.ExistCurrentSprayed
	,string		pNameOutput		= _Dataset().Name + ' Spray Info'	
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
		,_Dataset().max_record_size
		,'\t'
	 	}
	], tools.Layout_Sprays.Info);
		
	return if(					pDirectory != ''
							and not pExistSprayed
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput));
end;
