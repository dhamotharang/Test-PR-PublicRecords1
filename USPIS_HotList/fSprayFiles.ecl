import Versioncontrol, _control;

export fSprayFiles(

	 string		pversion
	,string		pServerIP		= _control.IPAddress.edata10
	,string		pDirectory	= '/prod_data_build_13/eval_data/uspis_address_inspection_list/'
	,string		pFilename		= 'all.csv'
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
	 	,Filenames(pversion).input.Template
	 	,[ {Filenames(pversion).input.sprayed	}	]
	 	,pGroupName
		,pversion
		,''
		,'VARIABLE'
		,''
		,_Dataset().max_record_size
	 	}

	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,true,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput);

end;
