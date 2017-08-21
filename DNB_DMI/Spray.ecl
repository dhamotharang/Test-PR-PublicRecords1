import tools, _control, VersionControl;
export Spray(

	 string		pversion								= ''
	,string		pServerIP								= IF(VersionControl._Flags.IsDataland,
																				 _control.IPAddress.bctlpedata12,
																				 _control.IPAddress.bctlpedata11)
	,string		pDirectory							= '/data/prod_data_build_10/production_data/business_headers/dnb/test'
	,string		pFilename								= 'DMI*'
	,string		pGroupName							= _Constants().groupname																		
	,boolean	pIsTesting							= false
	,boolean	pOverwrite							= false
	,boolean	pExistSprayed						= _Flags.Companies.ExistCurrentSprayed
	,string		pNameOutput							= _Constants().Name + ' Spray Info'	
	,boolean	pSprayMultipleFilesAs1	= true

) :=
function
	FilesToSpray := DATASET([
		{pServerIP
	 	,pDirectory
	 	,pFilename
	 	,0
	 	,Filenames(pversion).input.raw.Template
	 	,[ {Filenames().input.raw.sprayed	}	]
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
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Constants().Name + ' ' + pversion,pNameOutput,pShouldSprayMultipleFilesAs1 := pSprayMultipleFilesAs1)
	);
end;
