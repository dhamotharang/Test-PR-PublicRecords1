import Versioncontrol, _control;

export fSprayFiles(

	 string		pversion
	,string		pServerIP		= _control.IPAddress.edata10
	,string		pDirectory	= '/prod_data_build_13/eval_data/commercial_fraud/'
	,string		pFilename		= 'appl_info_1m.d00'																
	,string		pGroupName	= _dataset().groupname																		
	,boolean	pIsTesting	= false
	,boolean	pOverwrite	= false
	,string		pNameOutput	= 'Commercial Fraud Spray Info'	

) :=
function

	FilesToSpray := DATASET([

	 	{pServerIP
	 	,pDirectory
	 	,pFilename
	 	,sizeof(layouts.input.dell)
	 	,Filenames(pversion).input.Dell.Template
	 	,[ {Filenames(pversion).input.Dell.sprayed	}	]
	 	,pGroupName
		,pversion
	 	}

	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,true,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput);

end;
