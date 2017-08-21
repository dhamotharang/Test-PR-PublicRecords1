import Versioncontrol, _control;

export fSprayFiles(

	 string		pServerIP		= _control.IPAddress.edata10
	,string		pDirectory	= '/prod_data_build_10/temp/'
	,string		pFilename		= 'travel*'
	,string		pversion
	,string		pGroupName	= _dataset().groupname																		
	,boolean	pIsTesting	= false
	,boolean	pOverwrite	= false
	,string		pNameOutput	= 'Travelers Spray Info'	

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
		,'\t'
	 	}
		
	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,true,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput);

end;
