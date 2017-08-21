import Versioncontrol, _control;

export fSprayFiles(

	 string		pServerIP		= _control.IPAddress.bctlpedata11
	,string		pDirectory	= '/data/data_build_1/teletrack/build'
	,string		pFile				= '20100805.TT_LN_1008.TXT'	
	,string		pversion
	,string		pGroupName	= _dataset().groupname																		
	,boolean	pIsTesting	= false
	,boolean	pOverwrite	= false
	,string		pNameOutput	= 'Teletrack Spray Info'	

) :=
function

	FilesToSpray := DATASET([

	 	{pServerIP
	 	,pDirectory
	 	,pFile
	 	,0
	 	,Filenames(pversion).Input.Template
	 	,[ {Filenames(pversion).Input.sprayed	}	]
	 	,pGroupName
		,pversion
		,''
		,'VARIABLE'
		,''
		,_Dataset().max_record_size
		,'\t'
		,'\\n,\\r\\n'
		,','
	 	}

	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,true,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput);

end;
