import tools, _control;

export Spray(
	 string		pversion			= ''
	,string		pServerIP			= _control.IPAddress.bctlpedata11
	,string		pDirectory		= '/data/hds_180/CrashCarrier/data/'+ pversion
	,string		pFilename			= _Dataset().pName+'*txt'
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
	 	,Filenames(pversion).input.logical
	 	,[ {Filenames().input.sprayed	}	]
	 	,pGroupName
		,''
		,'[0-9]{8}'
		,'VARIABLE'
		,''
		,_Constants().max_record_size
		,'\t'
	 	}
	], tools.Layout_Sprays.Info);
		
	return if(					pDirectory != ''
							and not pExistSprayed
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Constants().Name + ' ' + pversion,pNameOutput));

end;
