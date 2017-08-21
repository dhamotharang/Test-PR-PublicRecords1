import tools;

export Spray(

	 string		pversion			= ''
	,string		pFilename			= '' //name on linux box
	,string		pLogicalname	= '' //name on thor
	,string		pServerIP			= prte_bip._Constants().sServerIP
	,string		pDirectory		= prte_bip._Constants().sDirectory
	,string		pFiletype			= '.csv'
	,string		pGroupName		= prte_bip._Dataset().groupname																		
	,boolean	pIsTesting		= false
	,boolean	pOverwrite		= false
	,boolean	pExistSprayed	= prte_bip._Flags(pLogicalname).ExistCurrentSprayed
	,string		pNameOutput		= prte_bip._Dataset().Name + '::' + pLogicalname + ' Spray Info'	

) :=
function
	
	FilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFilename + pFiletype
	 	,0
	 	,prte_bip.Filenames(pLogicalname,pversion).input.logical
	 	,[ {prte_bip.Filenames(pLogicalname).input.sprayed	}	]
	 	,pGroupName
		,''
		,'[0-9]{8}'
		,'VARIABLE'
		,''
		,_Dataset().max_record_size
		,'\t'
	 	}
	], tools.Layout_Sprays.Info);
		
	return if( pDirectory != '' and not pExistSprayed
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput)
					 );

end;
