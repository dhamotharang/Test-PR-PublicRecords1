import tools, _control;

export fSpray_Inputfile(
	 string		pversion
	,string		pDirectory	= '/hds_180/targus/pure_business_iyp_cp/' + pversion + '/'
	,string		pServerIP		= _control.IPAddress.edata12
	,string		pFilename		= 'IYP_*.dat*'
	,string		pGroupName	= constants().groupname																		
	,boolean	pIsTesting	= false
	,boolean	pOverwrite	= false
	,string		pNameOutput	= constants().name + ' Spray Info'	

) :=
function

	FilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFilename
	 	,sizeof(Layout_YellowPages)
	 	,Filenames(pversion).input.logical
	 	,[ {Filenames(pversion).input.sprayed	}	]
	 	,pGroupName
		,pversion
	 	}
	], tools.Layout_Sprays.Info);
		
	return tools.fun_Spray(FilesToSpray,,,pOverwrite,,true,pIsTesting,,Constants().Name + ' ' + pversion,pNameOutput,pShouldSprayMultipleFilesAs1 := true);

end;
