import Versioncontrol, _control;

export fSprayFiles(

	 string		pServerIP		= _control.IPAddress.edata10
	,string		pDirectory	= '/prod_data_build_10/production_data/business_headers/aca/'
	,string		pFilename		= 'aca*csv'
	,string		pversion
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
	 	,sizeof(layout_aca_in)
	 	,filenames().input.template
	 	,[ {filenames().input.sprayed	}	]
	 	,pGroupName
		,''
		,'[0-9]{8}'
		,'VARIABLE'
	 	}

	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,false,pIsTesting,,'ACA ' + ' ' + pversion,pNameOutput,true);

end;
