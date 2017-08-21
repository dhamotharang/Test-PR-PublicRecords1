import tools, _control;

export fun_SprayInput(

	 string		pversion
	,string		pServerIP		= _control.IPAddress.edata10
	,string		pDirectory	= '/prod_data_build_10/production_data/business_headers/dnb/test'
	,string		pFilename		= 'DMI*'
	,string		pGroupName	= _dataset().groupname																		
	,boolean	pIsTesting	= false
	,boolean	pOverwrite	= false
	,string		pNameOutput	= 'DNB DMI Spray Info'	
	,boolean	pSprayMultipleFilesAs1	= true

) :=
function

	FilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFilename
	 	,5698
	 	,Filenames(pversion).input.Template
	 	,[ {Filenames(pversion).input.sprayed	}	]
	 	,pGroupName
		,pversion
//		,''
//		,'VARIABLE'
//		,''
//		,_Dataset().max_record_size
	 	}
	], tools.Layout_Sprays.Info);
		

	return tools.fun_Spray(FilesToSpray,,,pOverwrite,,true,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput,pShouldSprayMultipleFilesAs1 := pSprayMultipleFilesAs1);

end;
